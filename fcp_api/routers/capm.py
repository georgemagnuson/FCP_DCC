from fastapi import APIRouter, Depends, HTTPException, Response
import database
import auth
from services import capm_reports as svc

router = APIRouter(prefix="/capm", tags=["capm"])

EMPLOYEE_LEVEL = auth.GROUPS["training_employee"]
MANAGER_LEVEL  = auth.GROUPS["training_manager"]


def _load_session_and_readings(session_id: str, cur) -> tuple[dict, list[dict]]:
    session = svc.get_session(session_id, cur)
    if not session:
        raise HTTPException(status_code=404, detail="CAPM session not found.")
    readings = svc.get_readings(session_id, cur)
    return session, readings


@router.get("/sessions")
def list_sessions(
    mac_address: str | None = None,
    mode:        str | None = "compliance",
    days:        int = 30,
    caller:      dict = Depends(auth.verify_request),
):
    """Recent CAPM sessions. Manager and above."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT s.*, d.device_name
            FROM capm_sessions s
            LEFT JOIN capm_devices d ON d.mac_address = s.mac_address
            WHERE s.started_at >= NOW() - INTERVAL '1 day' * %s
              AND (%s IS NULL OR s.mac_address = %s)
              AND (%s IS NULL OR s.mode = %s)
            ORDER BY s.started_at DESC
        """, (days, mac_address, mac_address, mode, mode))
        return [dict(r) for r in cur.fetchall()]


@router.get("/sessions/{session_id}")
def get_session(
    session_id: str,
    caller:     dict = Depends(auth.verify_request),
):
    """Full session details plus all raw readings."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        session, readings = _load_session_and_readings(session_id, cur)
        session["readings"] = readings
        return session


@router.get("/sessions/{session_id}/report")
def get_report_json(
    session_id: str,
    caller:     dict = Depends(auth.verify_request),
):
    """HACCP compliance report for one session, as structured JSON."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        session, readings = _load_session_and_readings(session_id, cur)
        return svc.build_report(session, readings)


@router.get("/sessions/{session_id}/report.pdf")
def get_report_pdf(
    session_id: str,
    caller:     dict = Depends(auth.verify_request),
):
    """HACCP compliance report rendered to PDF for download/filing."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    try:
        from weasyprint import HTML
    except ImportError:
        raise HTTPException(
            status_code=501,
            detail="PDF rendering unavailable — weasyprint is not installed on the server.",
        )
    with database.get_cursor() as cur:
        session, readings = _load_session_and_readings(session_id, cur)
        report = svc.build_report(session, readings)
    pdf_bytes = HTML(string=svc.render_html(report)).write_pdf()
    filename = f"capm-compliance-{report['session']['id']}.pdf"
    return Response(
        content=pdf_bytes,
        media_type="application/pdf",
        headers={"Content-Disposition": f'attachment; filename="{filename}"'},
    )
