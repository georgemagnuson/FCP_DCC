"""
Diary router — periodic FCP compliance records.

Endpoints:
    POST /diary/opening-check
    POST /diary/closing-check
    GET  /diary/checks/today
    GET  /diary/checks?date=YYYY-MM-DD
    GET  /diary/dashboard/today

    POST /diary/cooking-verification
    GET  /diary/cooking-verifications?date=YYYY-MM-DD

    POST /diary/weekly-check
    GET  /diary/weekly-checks?business_id=&weeks=8

    POST /diary/four-week-review
    GET  /diary/four-week-reviews?business_id=

    POST /diary/thermometer-calibration
    GET  /diary/thermometer-calibrations?business_id=

Permission levels:
    Employee  (1): POST opening/closing check, cooking verification; all GETs
    Manager   (3): POST weekly check, four-week review
    Supervisor(2): POST thermometer calibration
    Manager   (3): POST thermometer calibration (also allowed)
"""
from fastapi import APIRouter, Depends, HTTPException, Query
from datetime import date, datetime, timedelta
from typing import Optional
import database
import auth
from models.diary import (
    OpeningCheckIn, ClosingCheckIn, DailyCheckOut,
    CookingVerificationIn, CookingVerificationOut,
    WeeklyCheckIn, WeeklyCheckOut,
    FourWeekReviewIn, FourWeekReviewOut,
    ThermometerCalibrationIn, ThermometerCalibrationOut,
)

router = APIRouter(prefix="/diary", tags=["diary"])

EMPLOYEE_LEVEL   = auth.GROUPS["training_employee"]
SUPERVISOR_LEVEL = auth.GROUPS["training_supervisor"]
MANAGER_LEVEL    = auth.GROUPS["training_manager"]


# =============================================================
# Daily Checks
# =============================================================

@router.post("/opening-check", response_model=DailyCheckOut)
def opening_check(
    body:   OpeningCheckIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record the daily opening checklist."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    check_date = body.check_date or date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO daily_check
                (business_id, location_id, check_date, check_type,
                 staff_fit, facility_clean, handwash_available, notes, checked_by)
            VALUES (%s, %s, %s, 'opening', %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.location_id) if body.location_id else None,
            check_date,
            body.staff_fit, body.facility_clean, body.handwash_available,
            body.notes, caller["username"],
        ))
        return dict(cur.fetchone())


@router.post("/closing-check", response_model=DailyCheckOut)
def closing_check(
    body:   ClosingCheckIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record the daily closing checklist."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    check_date = body.check_date or date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO daily_check
                (business_id, location_id, check_date, check_type,
                 food_stored_correctly, temp_compliant, expired_food_disposed,
                 cleaning_complete, waste_managed, notes, checked_by)
            VALUES (%s, %s, %s, 'closing', %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.location_id) if body.location_id else None,
            check_date,
            body.food_stored_correctly, body.temp_compliant,
            body.expired_food_disposed, body.cleaning_complete,
            body.waste_managed, body.notes, caller["username"],
        ))
        return dict(cur.fetchone())


@router.get("/checks/today")
def checks_today(
    business_id: str = Query(...),
    caller:      dict = Depends(auth.verify_request),
):
    """Today's opening and closing check status for a business."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    today = date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT check_type, id, all_ok, checked_by, created_at
            FROM daily_check
            WHERE business_id = %s AND check_date = %s
            ORDER BY check_type
        """, (business_id, today))
        rows = cur.fetchall()
    result = {t: None for t in ("opening", "closing")}
    for row in rows:
        result[row["check_type"]] = {
            "id":         str(row["id"]),
            "all_ok":     row["all_ok"],
            "checked_by": row["checked_by"],
            "created_at": row["created_at"].isoformat(),
        }
    return {"date": today.isoformat(), "checks": result}


@router.get("/checks")
def checks_for_date(
    business_id: str  = Query(...),
    date_:       Optional[date] = Query(None, alias="date"),
    caller:      dict = Depends(auth.verify_request),
):
    """Opening and closing checks for a specific date (defaults to today)."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    target = date_ or date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM daily_check
            WHERE business_id = %s AND check_date = %s
            ORDER BY check_type
        """, (business_id, target))
        return [dict(r) for r in cur.fetchall()]


@router.get("/dashboard/today")
def dashboard_today(
    business_id: str = Query(...),
    location_id: str = Query(...),
    caller:      dict = Depends(auth.verify_request),
):
    """Daily dashboard: opening/closing check status, temperature count, active cooling events."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    today = date.today()
    with database.get_cursor() as cur:
        # Opening and closing checks
        cur.execute("""
            SELECT check_type, all_ok, checked_by, created_at
            FROM daily_check
            WHERE business_id = %s AND check_date = %s
        """, (business_id, today))
        checks_raw = {r["check_type"]: dict(r) for r in cur.fetchall()}

        # Temperature readings today for this location
        cur.execute("""
            SELECT COUNT(*) AS cnt
            FROM temperature_log tl
            JOIN equipment e ON e.id = tl.equipment_id
            WHERE e.location_id = %s
              AND tl.recorded_at::date = %s
        """, (location_id, today))
        temp_count = cur.fetchone()["cnt"]

        # Active cooling events for this location
        cur.execute("""
            SELECT id, food_description, cooked_at, clock_started_at,
                   target_stage1_minutes, target_stage2_minutes,
                   stage1_completed_at, stage2_completed_at
            FROM food_cooling_event
            WHERE location_id = %s AND closed_at IS NULL
            ORDER BY cooked_at DESC
        """, (location_id,))
        cooling_rows = cur.fetchall()

    def _check_summary(row):
        if row is None:
            return {"done": False, "all_ok": None, "checked_by": None, "time": None}
        return {
            "done":       True,
            "all_ok":     row["all_ok"],
            "checked_by": row["checked_by"],
            "time":       row["created_at"].strftime("%H:%M"),
        }

    cooling_events = []
    for row in cooling_rows:
        stage = "stage_2" if row["stage1_completed_at"] else "stage_1"
        clock_start = row["clock_started_at"] or row["cooked_at"]
        stage1_dl = clock_start + timedelta(minutes=row["target_stage1_minutes"]) if clock_start else None
        stage2_dl = clock_start + timedelta(minutes=row["target_stage1_minutes"] + row["target_stage2_minutes"]) if clock_start else None
        cooling_events.append({
            "event_id":        str(row["id"]),
            "food_description": row["food_description"],
            "cooked_at":       row["cooked_at"].isoformat() if row["cooked_at"] else None,
            "stage":           stage,
            "stage1_deadline": stage1_dl.isoformat() if stage1_dl else None,
            "stage2_deadline": stage2_dl.isoformat() if stage2_dl else None,
        })

    return {
        "date":                       today.isoformat(),
        "opening_check":              _check_summary(checks_raw.get("opening")),
        "closing_check":              _check_summary(checks_raw.get("closing")),
        "temperature_readings_today": int(temp_count),
        "active_cooling_events":      cooling_events,
    }


# =============================================================
# Cooking Verification
# =============================================================

@router.post("/cooking-verification", response_model=CookingVerificationOut)
def cooking_verification(
    body:   CookingVerificationIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a cooking temperature verification."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    verified_date = body.verified_date or date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO cooking_verification
                (business_id, location_id, verified_date, food_item,
                 cooking_temp_c, target_temp_c, verified_by, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.location_id) if body.location_id else None,
            verified_date, body.food_item,
            body.cooking_temp_c, body.target_temp_c,
            caller["username"], body.notes,
        ))
        return dict(cur.fetchone())


@router.get("/cooking-verifications")
def get_cooking_verifications(
    business_id: str = Query(...),
    date_:       Optional[date] = Query(None, alias="date"),
    caller:      dict = Depends(auth.verify_request),
):
    """Cooking verifications for a business. Filtered by date if provided."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        if date_:
            cur.execute("""
                SELECT * FROM cooking_verification
                WHERE business_id = %s AND verified_date = %s
                ORDER BY created_at DESC
            """, (business_id, date_))
        else:
            cur.execute("""
                SELECT * FROM cooking_verification
                WHERE business_id = %s
                ORDER BY verified_date DESC, created_at DESC
                LIMIT 50
            """, (business_id,))
        return [dict(r) for r in cur.fetchall()]


# =============================================================
# Weekly Check
# =============================================================

@router.post("/weekly-check", response_model=WeeklyCheckOut)
def weekly_check(
    body:   WeeklyCheckIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record the weekly FCP review. Manager and above."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO weekly_check
                (business_id, location_id, week_ending,
                 pest_activity_found, pest_notes,
                 cleaning_tasks_complete, maintenance_tasks_complete,
                 cooking_verification_done, manager_notes, reviewed_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.location_id) if body.location_id else None,
            body.week_ending,
            body.pest_activity_found, body.pest_notes,
            body.cleaning_tasks_complete, body.maintenance_tasks_complete,
            body.cooking_verification_done, body.manager_notes,
            caller["username"],
        ))
        return dict(cur.fetchone())


@router.get("/weekly-checks")
def get_weekly_checks(
    business_id: str = Query(...),
    weeks:       int = Query(8, ge=1, le=52),
    caller:      dict = Depends(auth.verify_request),
):
    """Last N weeks of weekly checks for a business (default 8)."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM weekly_check
            WHERE business_id = %s
            ORDER BY week_ending DESC
            LIMIT %s
        """, (business_id, weeks))
        return [dict(r) for r in cur.fetchall()]


# =============================================================
# Four-Week Review
# =============================================================

@router.post("/four-week-review", response_model=FourWeekReviewOut)
def four_week_review(
    body:   FourWeekReviewIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a mandatory 4-weekly FCP review. Manager and above."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO four_week_review
                (business_id, location_id, period_ending,
                 problems_recurring, customer_complaints,
                 new_staff_added, new_staff_notes,
                 menu_changes, supplier_changes, equipment_changes,
                 fcp_updated, council_approval_needed, council_notes,
                 reviewed_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.location_id) if body.location_id else None,
            body.period_ending,
            body.problems_recurring, body.customer_complaints,
            body.new_staff_added, body.new_staff_notes,
            body.menu_changes, body.supplier_changes, body.equipment_changes,
            body.fcp_updated, body.council_approval_needed, body.council_notes,
            caller["username"],
        ))
        return dict(cur.fetchone())


@router.get("/four-week-reviews")
def get_four_week_reviews(
    business_id: str = Query(...),
    caller:      dict = Depends(auth.verify_request),
):
    """All four-week reviews for a business, newest first."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM four_week_review
            WHERE business_id = %s
            ORDER BY period_ending DESC
        """, (business_id,))
        return [dict(r) for r in cur.fetchall()]


# =============================================================
# Thermometer Calibration
# =============================================================

@router.post("/thermometer-calibration", response_model=ThermometerCalibrationOut)
def thermometer_calibration(
    body:   ThermometerCalibrationIn,
    caller: dict = Depends(auth.verify_request),
):
    """Record a thermometer calibration. Supervisor and above."""
    auth.require_level(SUPERVISOR_LEVEL)(caller)
    calibration_date = body.calibration_date or date.today()
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO thermometer_calibration
                (business_id, equipment_id, thermometer_description,
                 calibration_date, ice_slurry_reading_c, boiling_reading_c,
                 passed, calibrated_by, next_due_date, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING *
        """, (
            str(body.business_id),
            str(body.equipment_id) if body.equipment_id else None,
            body.thermometer_description, calibration_date,
            body.ice_slurry_reading_c, body.boiling_reading_c,
            body.passed, caller["username"],
            body.next_due_date, body.notes,
        ))
        return dict(cur.fetchone())


@router.get("/thermometer-calibrations")
def get_thermometer_calibrations(
    business_id: str = Query(...),
    caller:      dict = Depends(auth.verify_request),
):
    """All thermometer calibrations for a business, newest first."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT * FROM thermometer_calibration
            WHERE business_id = %s
            ORDER BY calibration_date DESC
        """, (business_id,))
        return [dict(r) for r in cur.fetchall()]
