from fastapi import APIRouter, Depends, HTTPException, Query
from datetime import date
import database
import auth
from models.training import (
    TrainingModuleOut,
    TrainingEmployeeRecord,
    TrainingRecordStatus,
    AssignIn,
    NaIn,
    CompleteIn,
    VerifyIn,
)

router = APIRouter(prefix="/training", tags=["training"])

EMPLOYEE_LEVEL   = auth.GROUPS["training_employee"]
SUPERVISOR_LEVEL = auth.GROUPS["training_supervisor"]
MANAGER_LEVEL    = auth.GROUPS["training_manager"]

# Explicit group sets for training — hierarchy is Employee < Manager < Supervisor
# (training_supervisor outranks training_manager for training purposes)
_MANAGER_GROUPS    = {"training_manager", "sysop", "bureaucrat"}
_SUPERVISOR_GROUPS = {"training_supervisor", "sysop", "bureaucrat"}
_ASSIGN_GROUPS     = _MANAGER_GROUPS | _SUPERVISOR_GROUPS  # both can assign/NA


def _in_groups(caller: dict, allowed: set) -> bool:
    return bool(allowed & caller["groups"])


def _resolve_employee(mediawiki_username: str, cur) -> tuple[str, str]:
    """Return (employee_id, full_name) for a mediawiki_username or full_name.
    Normalises underscores↔spaces since MediaWiki page titles use underscores
    but stored usernames use spaces.
    """
    normalised = mediawiki_username.replace("_", " ")
    cur.execute(
        "SELECT id, full_name FROM employee WHERE (mediawiki_username = %s OR mediawiki_username = %s) AND is_active = TRUE",
        (mediawiki_username, normalised)
    )
    emp = cur.fetchone()
    if not emp:
        # Fallback: match by full_name
        cur.execute(
            "SELECT id, full_name FROM employee WHERE (full_name = %s OR full_name = %s) AND is_active = TRUE",
            (mediawiki_username, normalised)
        )
        emp = cur.fetchone()
    if not emp:
        raise HTTPException(status_code=404, detail=f"No active employee found for '{mediawiki_username}'.")
    return str(emp["id"]), emp["full_name"]


def _resolve_module(module_code: str, cur) -> int:
    """Return module_id for a module_code."""
    cur.execute(
        "SELECT id FROM training_module WHERE module_code = %s AND is_active = TRUE",
        (module_code,)
    )
    mod = cur.fetchone()
    if not mod:
        raise HTTPException(status_code=404, detail=f"Training module '{module_code}' not found.")
    return mod["id"]


def _derive_status(row: dict) -> str:
    if row.get("verified_date"):
        return "verified"
    if row.get("completed_date"):
        return "completed"
    if row.get("na_date"):
        return "na"
    if row.get("assigned_date"):
        return "assigned"
    return "not_assigned"


# ---------------------------------------------------------------------------
# GET /training/modules
# ---------------------------------------------------------------------------

@router.get("/modules", response_model=list[TrainingModuleOut])
def list_modules(
    category: str | None = Query(None, description="Filter by category: chef, waitstaff, all"),
    caller: dict = Depends(auth.verify_request),
):
    """List all active training modules, optionally filtered by category."""
    with database.get_cursor() as cur:
        if category:
            cur.execute(
                "SELECT * FROM training_module WHERE is_active = TRUE AND category = %s ORDER BY display_order",
                (category,)
            )
        else:
            cur.execute(
                "SELECT * FROM training_module WHERE is_active = TRUE ORDER BY category, display_order"
            )
        return [dict(row) for row in cur.fetchall()]


# ---------------------------------------------------------------------------
# GET /training/employee/{mediawiki_username}
# ---------------------------------------------------------------------------

@router.get("/employee/{mediawiki_username}", response_model=TrainingEmployeeRecord)
def get_employee_training(
    mediawiki_username: str,
    category: str | None = Query(None, description="Filter modules by category"),
    caller: dict = Depends(auth.verify_request),
):
    """
    Full training record for an employee.
    Employees can only view their own record unless supervisor+.
    """
    can_view_any = _in_groups(caller, _ASSIGN_GROUPS)
    if not can_view_any and caller["username"].replace("_", " ") != mediawiki_username.replace("_", " "):
        raise HTTPException(status_code=403, detail="You can only view your own training record.")

    with database.get_cursor() as cur:
        emp_id, full_name = _resolve_employee(mediawiki_username, cur)

        cat_filter = "AND m.category = %s" if category else ""
        params = [emp_id, category] if category else [emp_id]

        cur.execute(f"""
            SELECT
                m.id          AS module_id,
                m.module_code,
                m.module_name,
                m.category,
                m.display_order,
                r.na_date,       r.na_reason,    r.na_by,
                r.assigned_date, r.assigned_by,
                r.completed_date,r.completed_by,
                r.verified_date, r.verified_by
            FROM training_module m
            LEFT JOIN training_record r
                ON r.module_id = m.id AND r.employee_id = %s
            WHERE m.is_active = TRUE {cat_filter}
            ORDER BY m.category, m.display_order
        """, params)

        modules = []
        for row in cur.fetchall():
            d = dict(row)
            d["status"] = _derive_status(d)
            modules.append(d)

        return {"mediawiki_username": mediawiki_username, "full_name": full_name, "modules": modules}


# ---------------------------------------------------------------------------
# POST /training/employee/{mediawiki_username}/{module_code}/assign
# ---------------------------------------------------------------------------

@router.post("/employee/{mediawiki_username}/{module_code}/assign")
def assign_module(
    mediawiki_username: str,
    module_code: str,
    body: AssignIn,
    caller: dict = Depends(auth.verify_request),
):
    """Manager or supervisor assigns a training module to an employee."""
    if not _in_groups(caller, _ASSIGN_GROUPS):
        raise HTTPException(status_code=403, detail="Insufficient permissions.")

    with database.get_cursor() as cur:
        emp_id, _ = _resolve_employee(mediawiki_username, cur)
        mod_id = _resolve_module(module_code, cur)
        assigned_date = body.action_date or date.today()

        cur.execute("""
            INSERT INTO training_record (employee_id, module_id, assigned_date, assigned_by)
            VALUES (%s, %s, %s, %s)
            ON CONFLICT (employee_id, module_id) DO UPDATE
                SET assigned_date = EXCLUDED.assigned_date,
                    assigned_by   = EXCLUDED.assigned_by,
                    updated_at    = now()
            RETURNING *
        """, (emp_id, mod_id, assigned_date, caller["username"]))

        row = dict(cur.fetchone())
        row["status"] = _derive_status(row)
        return row


# ---------------------------------------------------------------------------
# POST /training/employee/{mediawiki_username}/{module_code}/na
# ---------------------------------------------------------------------------

@router.post("/employee/{mediawiki_username}/{module_code}/na")
def mark_na(
    mediawiki_username: str,
    module_code: str,
    body: NaIn,
    caller: dict = Depends(auth.verify_request),
):
    """Manager or supervisor marks a module as not applicable for this employee."""
    if not _in_groups(caller, _ASSIGN_GROUPS):
        raise HTTPException(status_code=403, detail="Insufficient permissions.")

    with database.get_cursor() as cur:
        emp_id, _ = _resolve_employee(mediawiki_username, cur)
        mod_id = _resolve_module(module_code, cur)
        na_date = body.action_date or date.today()

        cur.execute("""
            INSERT INTO training_record (employee_id, module_id, na_date, na_reason, na_by)
            VALUES (%s, %s, %s, %s, %s)
            ON CONFLICT (employee_id, module_id) DO UPDATE
                SET na_date   = EXCLUDED.na_date,
                    na_reason = EXCLUDED.na_reason,
                    na_by     = EXCLUDED.na_by,
                    updated_at = now()
            RETURNING *
        """, (emp_id, mod_id, na_date, body.reason, caller["username"]))

        row = dict(cur.fetchone())
        row["status"] = _derive_status(row)
        return row


# ---------------------------------------------------------------------------
# POST /training/employee/{mediawiki_username}/{module_code}/complete
# ---------------------------------------------------------------------------

@router.post("/employee/{mediawiki_username}/{module_code}/complete")
def complete_module(
    mediawiki_username: str,
    module_code: str,
    body: CompleteIn,
    caller: dict = Depends(auth.verify_request),
):
    """
    Employee marks a module as completed (reading done).
    Employees can only complete their own modules; supervisors+ can complete any.
    Module must be assigned first.
    """
    # Only the employee themselves (or sysop/bureaucrat) can mark complete
    is_privileged = bool({"sysop", "bureaucrat"} & caller["groups"])
    if not is_privileged and caller["username"].replace("_", " ") != mediawiki_username.replace("_", " "):
        raise HTTPException(status_code=403, detail="You can only complete your own training modules.")

    with database.get_cursor() as cur:
        emp_id, _ = _resolve_employee(mediawiki_username, cur)
        mod_id = _resolve_module(module_code, cur)

        # Must be assigned before completing
        cur.execute(
            "SELECT assigned_date FROM training_record WHERE employee_id = %s AND module_id = %s",
            (emp_id, mod_id)
        )
        record = cur.fetchone()
        if not record or not record["assigned_date"]:
            raise HTTPException(status_code=400, detail="Module must be assigned before marking complete.")

        completed_date = body.action_date or date.today()

        cur.execute("""
            UPDATE training_record
            SET completed_date = %s, completed_by = %s, updated_at = now()
            WHERE employee_id = %s AND module_id = %s
            RETURNING *
        """, (completed_date, caller["username"], emp_id, mod_id))

        row = dict(cur.fetchone())
        row["status"] = _derive_status(row)
        return row


# ---------------------------------------------------------------------------
# POST /training/employee/{mediawiki_username}/{module_code}/verify
# ---------------------------------------------------------------------------

@router.post("/employee/{mediawiki_username}/{module_code}/verify")
def verify_module(
    mediawiki_username: str,
    module_code: str,
    body: VerifyIn,
    caller: dict = Depends(auth.verify_request),
):
    """
    Supervisor signs off that the employee has demonstrated understanding.
    Module must be completed first. Managers cannot verify.
    """
    if not _in_groups(caller, _SUPERVISOR_GROUPS):
        raise HTTPException(status_code=403, detail="Only supervisors can verify training modules.")

    with database.get_cursor() as cur:
        emp_id, _ = _resolve_employee(mediawiki_username, cur)
        mod_id = _resolve_module(module_code, cur)

        cur.execute(
            "SELECT completed_date FROM training_record WHERE employee_id = %s AND module_id = %s",
            (emp_id, mod_id)
        )
        record = cur.fetchone()
        if not record or not record["completed_date"]:
            raise HTTPException(status_code=400, detail="Module must be completed before verification.")

        verified_date = body.action_date or date.today()

        cur.execute("""
            UPDATE training_record
            SET verified_date = %s, verified_by = %s, updated_at = now()
            WHERE employee_id = %s AND module_id = %s
            RETURNING *
        """, (verified_date, caller["username"], emp_id, mod_id))

        row = dict(cur.fetchone())
        row["status"] = _derive_status(row)
        return row
