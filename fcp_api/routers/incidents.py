from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional
import database
import auth
from models.incidents import (
    IncidentReportIn, IncidentReportOut,
    CorrectiveActionIn, CorrectiveActionOut,
    CloseActionIn,
)

router = APIRouter(prefix="/incidents", tags=["incidents"])

EMPLOYEE_LEVEL   = auth.GROUPS["training_employee"]
SUPERVISOR_LEVEL = auth.GROUPS["training_supervisor"]
MANAGER_LEVEL    = auth.GROUPS["training_manager"]


def _resolve_employee(username: str, cur) -> str:
    cur.execute(
        "SELECT id FROM employee WHERE mediawiki_username = %s AND is_active = TRUE",
        (username,)
    )
    emp = cur.fetchone()
    if not emp:
        raise HTTPException(status_code=400, detail="Employee not found for this MW user.")
    return str(emp["id"])


def _fetch_incident(incident_id: str, cur) -> dict:
    cur.execute("SELECT * FROM incident_report WHERE id = %s", (incident_id,))
    row = cur.fetchone()
    if not row:
        raise HTTPException(status_code=404, detail="Incident report not found.")
    incident = dict(row)
    cur.execute(
        "SELECT * FROM corrective_action WHERE incident_report_id = %s ORDER BY actioned_at",
        (incident_id,)
    )
    incident["actions"] = [dict(r) for r in cur.fetchall()]
    incident["is_open"] = not any(a["closed_at"] for a in incident["actions"])
    return incident


@router.post("", response_model=IncidentReportOut)
def report_incident(
    body:   IncidentReportIn,
    caller: dict = Depends(auth.verify_request),
):
    """Any staff member can file an incident report."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            INSERT INTO incident_report
                (location_id, reported_by, incident_type, severity,
                 description, trigger_table, trigger_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.location_id), emp_id, body.incident_type,
            body.severity, body.description,
            body.trigger_table, str(body.trigger_id) if body.trigger_id else None
        ))
        incident = dict(cur.fetchone())
        incident["actions"] = []
        incident["is_open"] = True
        return incident


@router.post("/{incident_id}/action", response_model=CorrectiveActionOut)
def add_corrective_action(
    incident_id: str,
    body:        CorrectiveActionIn,
    caller:      dict = Depends(auth.verify_request),
):
    """Add a corrective action to an incident. Supervisor and above."""
    auth.require_level(SUPERVISOR_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        # Verify incident exists
        cur.execute("SELECT id FROM incident_report WHERE id = %s", (incident_id,))
        if not cur.fetchone():
            raise HTTPException(status_code=404, detail="Incident report not found.")
        from datetime import datetime
        cur.execute("""
            INSERT INTO corrective_action
                (incident_report_id, action_taken, actioned_by,
                 actioned_at, outcome, follow_up_required, follow_up_notes,
                 parent_action_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            incident_id, body.action_taken, emp_id,
            body.actioned_at or datetime.now(),
            body.outcome, body.follow_up_required, body.follow_up_notes,
            str(body.parent_action_id) if body.parent_action_id else None,
        ))
        return dict(cur.fetchone())


@router.post("/{incident_id}/action/{action_id}/close")
def close_corrective_action(
    incident_id: str,
    action_id:   str,
    body:        CloseActionIn,
    caller:      dict = Depends(auth.verify_request),
):
    """Close a corrective action. Supervisor and above."""
    auth.require_level(SUPERVISOR_LEVEL)(caller)
    with database.get_cursor() as cur:
        emp_id = _resolve_employee(caller["username"], cur)
        cur.execute("""
            UPDATE corrective_action
            SET closed_at  = NOW(),
                closed_by  = %s,
                outcome    = COALESCE(%s, outcome),
                updated_at = NOW()
            WHERE id = %s AND incident_report_id = %s
            RETURNING *
        """, (emp_id, body.outcome, action_id, incident_id))
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Corrective action not found.")
        return dict(row)


@router.get("/open")
def get_open_incidents(
    location_id: Optional[str] = Query(None),
    caller: dict = Depends(auth.verify_request),
):
    """All open incidents with their corrective actions. Manager and above."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        base = """
            SELECT ir.id FROM incident_report ir
            WHERE NOT EXISTS (
                SELECT 1 FROM corrective_action ca
                WHERE ca.incident_report_id = ir.id
                  AND ca.closed_at IS NOT NULL
            )
        """
        if location_id:
            cur.execute(base + " AND ir.location_id = %s ORDER BY ir.reported_at DESC",
                        (location_id,))
        else:
            cur.execute(base + " ORDER BY ir.reported_at DESC")
        ids = [str(r["id"]) for r in cur.fetchall()]
        return [_fetch_incident(id_, cur) for id_ in ids]


@router.get("/{incident_id}", response_model=IncidentReportOut)
def get_incident(
    incident_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Full incident report with all corrective actions."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        return _fetch_incident(incident_id, cur)
