from fastapi import APIRouter, Depends, HTTPException
import database
import auth
from models.employee import EmployeeIn, EmployeeOut

router = APIRouter(prefix="/employees", tags=["employees"])

EMPLOYEE_LEVEL = auth.GROUPS["training_employee"]
MANAGER_LEVEL  = auth.GROUPS["training_manager"]

# Fixed UUIDs for The Jitsu — single-location system
BUSINESS_ID = "a1000000-0000-0000-0000-000000000001"
LOCATION_ID = "b1000000-0000-0000-0000-000000000001"


@router.get("")
def list_employees(caller: dict = Depends(auth.verify_request)):
    """
    List all active employees.
    Returns full_name, role, mediawiki_username for directory display.
    """
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT full_name, role, mediawiki_username
            FROM employee
            WHERE is_active = TRUE
            ORDER BY full_name
        """)
        return [dict(r) for r in cur.fetchall()]


@router.get("/by-username/{mediawiki_username}")
def get_employee(mediawiki_username: str, caller: dict = Depends(auth.verify_request)):
    """
    Get a single employee by mediawiki_username.
    MediaWiki page titles use underscores; spaces and underscores are equivalent.
    Returns all employee fields for display on the employee wiki page.
    """
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    # MediaWiki normalises underscores↔spaces in titles — match both
    normalised = mediawiki_username.replace("_", " ")
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT
                full_name,
                role,
                mediawiki_username,
                food_handler_cert_number,
                cert_expiry,
                is_active
            FROM employee
            WHERE mediawiki_username = %s
               OR mediawiki_username = %s
        """, (mediawiki_username, normalised))
        row = cur.fetchone()
    if not row:
        raise HTTPException(status_code=404, detail=f"Employee not found: {mediawiki_username}")
    return dict(row)


@router.post("", status_code=201)
def create_employee(body: EmployeeIn, caller: dict = Depends(auth.verify_request)):
    """
    Create a new employee. Requires manager level.
    The trg_seed_employee_training trigger automatically seeds all 20 training modules.
    """
    auth.require_level(MANAGER_LEVEL)(caller)

    if body.mediawiki_username:
        # Check for duplicate mediawiki_username
        with database.get_cursor() as cur:
            cur.execute(
                "SELECT id FROM employee WHERE mediawiki_username = %s",
                (body.mediawiki_username,)
            )
            if cur.fetchone():
                raise HTTPException(
                    status_code=409,
                    detail=f"Employee with MediaWiki username '{body.mediawiki_username}' already exists."
                )

    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO employee
                (business_id, location_id, full_name, role, mediawiki_username,
                 food_handler_cert_number, cert_expiry)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            RETURNING id, full_name, role, mediawiki_username,
                      food_handler_cert_number, cert_expiry, is_active
        """, (
            BUSINESS_ID,
            LOCATION_ID,
            body.full_name,
            body.role,
            body.mediawiki_username or None,
            body.food_handler_cert_number or None,
            body.cert_expiry,
        ))
        return dict(cur.fetchone())
