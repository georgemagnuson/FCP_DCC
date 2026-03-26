from fastapi import APIRouter, Depends, HTTPException
import database
import auth
from services import cooling as svc
from models.cooling import (
    CoolingEventIn, CoolingEventOut,
    CoolingReadingIn, CoolingReadingOut,
)

router = APIRouter(prefix="/cooling", tags=["food-cooling"])

EMPLOYEE_LEVEL = auth.GROUPS["training_employee"]
MANAGER_LEVEL  = auth.GROUPS["training_manager"]


def _resolve_employee(username: str, cur) -> str:
    cur.execute(
        "SELECT id FROM employee WHERE mediawiki_username = %s AND is_active = TRUE",
        (username,)
    )
    emp = cur.fetchone()
    if not emp:
        raise HTTPException(status_code=400, detail="Employee not found for this MW user.")
    return str(emp["id"])


@router.post("/start", response_model=CoolingEventOut)
def start_cooling_event(
    body:   CoolingEventIn,
    caller: dict = Depends(auth.verify_request),
):
    """Open a new food cooling event when food comes off the heat."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            INSERT INTO food_cooling_event (
                location_id, food_description, batch_reference, quantity_kg,
                cooked_at, cooling_methods, clock_start_temp,
                target_stage1_temp, target_stage1_minutes,
                target_stage2_temp, target_stage2_minutes,
                is_proven_method, proven_method_ref, opened_by, notes
            ) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            RETURNING *
        """, (
            str(body.location_id), body.food_description, body.batch_reference,
            body.quantity_kg, body.cooked_at, body.cooling_methods,
            body.clock_start_temp, body.target_stage1_temp, body.target_stage1_minutes,
            body.target_stage2_temp, body.target_stage2_minutes,
            body.is_proven_method, body.proven_method_ref, emp_id, body.notes
        ))
        row = dict(cur.fetchone())
        row["readings"] = []
        row["stage1_breach"] = False
        row["incident_suggested"] = False
        return row


@router.post("/{event_id}/reading")
def add_cooling_reading(
    event_id: str,
    body:     CoolingReadingIn,
    caller:   dict = Depends(auth.verify_request),
):
    """Add a temperature reading to an active cooling event."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        try:
            reading, event = svc.add_reading(
                event_id    = event_id,
                temp_celsius = body.temp_celsius,
                recorded_by  = emp_id,
                recorded_at  = body.recorded_at,
                source       = body.source,
                sensor_id    = body.sensor_id,
                notes        = body.notes,
                cur          = cur,
            )
        except ValueError as e:
            raise HTTPException(status_code=400, detail=str(e))

    # Flag if stage 1 failed or overall non-compliant
    event["stage1_breach"] = event["stage1_compliant"] is False
    event["incident_suggested"] = (
        event["overall_compliant"] is False or event["stage1_breach"]
    )
    event["readings"] = [reading]
    return event


@router.get("/active")
def get_active_events(
    location_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """All open cooling events for a location."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM food_cooling_event
            WHERE location_id = %s AND closed_at IS NULL
            ORDER BY cooked_at DESC
        """, (location_id,))
        return [dict(r) for r in cur.fetchall()]


@router.get("/history")
def get_history(
    location_id: str,
    days: int = 30,
    caller: dict = Depends(auth.verify_request),
):
    """Past cooling events for a location. Manager and above."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM food_cooling_event
            WHERE location_id = %s
              AND cooked_at >= NOW() - INTERVAL '1 day' * %s
            ORDER BY cooked_at DESC
        """, (location_id, days))
        return [dict(r) for r in cur.fetchall()]


@router.get("/{event_id}", response_model=CoolingEventOut)
def get_event(
    event_id: str,
    caller:   dict = Depends(auth.verify_request),
):
    """Full cooling event with all readings."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("SELECT * FROM food_cooling_event WHERE id = %s", (event_id,))
        event = cur.fetchone()
        if not event:
            raise HTTPException(status_code=404, detail="Cooling event not found.")
        event = dict(event)

        cur.execute("""
            SELECT * FROM food_cooling_reading
            WHERE event_id = %s ORDER BY recorded_at ASC
        """, (event_id,))
        event["readings"] = [dict(r) for r in cur.fetchall()]
        event["stage1_breach"] = event["stage1_compliant"] is False
        event["incident_suggested"] = event["overall_compliant"] is False
        return event
