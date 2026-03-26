from fastapi import APIRouter, Depends, HTTPException, Query
from datetime import datetime
import database
import auth
from models.operations import (
    CleaningLogIn, CleaningLogOut,
    MaintenanceLogIn, MaintenanceLogOut,
    DeliveryCheckIn, DeliveryCheckOut,
)

router = APIRouter(prefix="/operations", tags=["operations"])

EMPLOYEE_LEVEL   = auth.GROUPS["training_employee"]
SUPERVISOR_LEVEL = auth.GROUPS["training_supervisor"]


def _resolve_employee(username: str, cur) -> str:
    cur.execute(
        "SELECT id FROM employee WHERE mediawiki_username = %s AND is_active = TRUE",
        (username,)
    )
    emp = cur.fetchone()
    if not emp:
        raise HTTPException(status_code=400, detail="Employee not found for this MW user.")
    return str(emp["id"])


@router.post("/cleaning", response_model=CleaningLogOut)
def log_cleaning(
    body:   CleaningLogIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a cleaning task."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            INSERT INTO cleaning_log
                (location_id, equipment_id, area, task, performed_at,
                 performed_by, product_used, method, source, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.location_id),
            str(body.equipment_id) if body.equipment_id else None,
            body.area, body.task,
            body.performed_at or datetime.now(),
            emp_id, body.product_used, body.method, body.source, body.notes
        ))
        return dict(cur.fetchone())


@router.post("/cleaning/{log_id}/verify")
def verify_cleaning(
    log_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Supervisor sign-off on a cleaning task."""
    auth.require_level(SUPERVISOR_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            UPDATE cleaning_log SET verified_by = %s WHERE id = %s RETURNING *
        """, (emp_id, log_id))
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Cleaning log entry not found.")
        return dict(row)


@router.post("/maintenance", response_model=MaintenanceLogOut)
def log_maintenance(
    body:   MaintenanceLogIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a maintenance task. Supervisor and above."""
    auth.require_level(SUPERVISOR_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        # Either internal employee or contractor — not both
        performed_by = emp_id if not body.contractor_name else None
        cur.execute("""
            INSERT INTO maintenance_log
                (equipment_id, task_description, performed_at,
                 performed_by_employee, contractor_name, next_due_date, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.equipment_id), body.task_description,
            body.performed_at or datetime.now(),
            performed_by, body.contractor_name,
            body.next_due_date, body.notes
        ))
        return dict(cur.fetchone())


@router.post("/delivery", response_model=DeliveryCheckOut)
def log_delivery(
    body:   DeliveryCheckIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a delivery check."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            INSERT INTO delivery_check
                (location_id, supplier_id, delivery_date, product_description,
                 quantity, use_by_date, temp_on_arrival, packaging_intact,
                 appearance_ok, accepted, rejection_reason, checked_by, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.location_id), str(body.supplier_id),
            body.delivery_date or datetime.now(),
            body.product_description, body.quantity, body.use_by_date,
            body.temp_on_arrival, body.packaging_intact, body.appearance_ok,
            body.accepted, body.rejection_reason, emp_id, body.notes
        ))
        row = dict(cur.fetchone())
        # Rejected delivery should suggest an incident report
        if not body.accepted:
            row["incident_suggested"] = True
        return row


@router.get("/cleaning")
def get_cleaning_log(
    location_id: str = Query(...),
    days:        int  = Query(14, ge=1, le=90),
    caller: dict = Depends(auth.verify_request),
):
    """Recent cleaning log entries for a location (default 14 days)."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT cl.id, cl.area, cl.task, cl.performed_at,
                   e.full_name AS performed_by_name,
                   v.full_name AS verified_by_name,
                   cl.product_used, cl.notes
            FROM cleaning_log cl
            LEFT JOIN employee e ON e.id = cl.performed_by
            LEFT JOIN employee v ON v.id = cl.verified_by
            WHERE cl.location_id = %s
              AND cl.performed_at >= NOW() - INTERVAL '%s days'
            ORDER BY cl.performed_at DESC
            LIMIT 100
        """, (location_id, days))
        return [dict(r) for r in cur.fetchall()]


@router.get("/delivery")
def get_delivery_log(
    location_id: str = Query(...),
    days:        int  = Query(14, ge=1, le=90),
    caller: dict = Depends(auth.verify_request),
):
    """Recent delivery checks for a location (default 14 days)."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT dc.id, s.name AS supplier, dc.product_description,
                   dc.delivery_date, dc.temp_on_arrival,
                   dc.packaging_intact, dc.appearance_ok,
                   dc.accepted, dc.rejection_reason,
                   e.full_name AS checked_by_name, dc.notes
            FROM delivery_check dc
            JOIN supplier s ON s.id = dc.supplier_id
            LEFT JOIN employee e ON e.id = dc.checked_by
            WHERE dc.location_id = %s
              AND dc.delivery_date >= NOW() - INTERVAL '%s days'
            ORDER BY dc.delivery_date DESC
            LIMIT 100
        """, (location_id, days))
        return [dict(r) for r in cur.fetchall()]
