from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional
import database
import auth
from services import temperature as svc
from models.temperature import TemperatureReadingIn, TemperatureReadingOut

router = APIRouter(prefix="/temperature", tags=["temperature"])

EMPLOYEE_LEVEL  = auth.GROUPS["training_employee"]
MANAGER_LEVEL   = auth.GROUPS["training_manager"]


@router.post("/reading", response_model=TemperatureReadingOut)
def record_temperature(
    body:   TemperatureReadingIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a temperature reading. Any staff member can submit."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)

    with database.get_cursor() as cur:
        # Resolve employee UUID from MW username
        cur.execute(
            "SELECT id FROM employee WHERE mediawiki_username = %s AND is_active = TRUE",
            (caller["username"],)
        )
        emp = cur.fetchone()
        if not emp:
            raise HTTPException(status_code=400, detail="Employee not found for this MW user.")

        row = svc.insert_reading(
            equipment_id = str(body.equipment_id),
            temp_celsius = body.temp_celsius,
            recorded_by  = str(emp["id"]),
            recorded_at  = body.recorded_at,
            source       = body.source,
            sensor_id    = body.sensor_id,
            notes        = body.notes,
            cur          = cur,
        )
    return row


@router.get("/today/{equipment_id}")
def get_today(
    equipment_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Today's readings for one piece of equipment."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT tl.*, e.name AS equipment_name
            FROM temperature_log tl
            JOIN equipment e ON e.id = tl.equipment_id
            WHERE tl.equipment_id = %s
              AND tl.recorded_at >= CURRENT_DATE
            ORDER BY tl.recorded_at DESC
        """, (equipment_id,))
        return [dict(r) for r in cur.fetchall()]


@router.get("/alerts")
def get_alerts(
    location_id: Optional[str] = Query(None),
    caller: dict = Depends(auth.verify_request),
):
    """All out-of-range readings. Manager and above only."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        if location_id:
            cur.execute("""
                SELECT tl.*, e.name AS equipment_name
                FROM temperature_log tl
                JOIN equipment e ON e.id = tl.equipment_id
                WHERE tl.in_range = FALSE
                  AND e.location_id = %s
                ORDER BY tl.recorded_at DESC
                LIMIT 200
            """, (location_id,))
        else:
            cur.execute("""
                SELECT tl.*, e.name AS equipment_name
                FROM temperature_log tl
                JOIN equipment e ON e.id = tl.equipment_id
                WHERE tl.in_range = FALSE
                ORDER BY tl.recorded_at DESC
                LIMIT 200
            """)
        return [dict(r) for r in cur.fetchall()]


@router.get("/summary/{equipment_id}")
def get_summary(
    equipment_id: str,
    days:   int = Query(7, ge=1, le=90),
    caller: dict = Depends(auth.verify_request),
):
    """Min/max/avg temperature summary for a piece of equipment over N days."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT
                COUNT(*)                            AS reading_count,
                ROUND(MIN(temp_celsius)::numeric, 1) AS min_temp,
                ROUND(MAX(temp_celsius)::numeric, 1) AS max_temp,
                ROUND(AVG(temp_celsius)::numeric, 1) AS avg_temp,
                COUNT(*) FILTER (WHERE in_range = FALSE) AS out_of_range_count
            FROM temperature_log
            WHERE equipment_id = %s
              AND recorded_at >= NOW() - INTERVAL '1 day' * %s
        """, (equipment_id, days))
        return dict(cur.fetchone())
