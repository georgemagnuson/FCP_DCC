from fastapi import APIRouter, Depends, HTTPException, Query
import database
import auth

router = APIRouter(prefix="/business", tags=["business"])

# Separate routers for reference data — no /business prefix needed
suppliers_router = APIRouter(prefix="/suppliers", tags=["reference"])
equipment_router = APIRouter(prefix="/equipment",  tags=["reference"])

EMPLOYEE_LEVEL = auth.GROUPS["training_employee"]


@router.get("/{business_id}")
def get_business(
    business_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """
    Return business details with locations and key staff.
    Used by wiki pages to display live data from jitsu_fcp.
    """
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        # Business
        cur.execute("SELECT * FROM business WHERE id = %s AND is_active = TRUE", (business_id,))
        biz = cur.fetchone()
        if not biz:
            raise HTTPException(status_code=404, detail="Business not found.")
        biz = dict(biz)

        # Locations
        cur.execute(
            "SELECT * FROM location WHERE business_id = %s AND is_active = TRUE ORDER BY name",
            (business_id,)
        )
        biz["locations"] = [dict(r) for r in cur.fetchall()]

        # Key staff — operators and managers
        cur.execute("""
            SELECT full_name, role, mediawiki_username
            FROM employee
            WHERE business_id = %s AND is_active = TRUE
            ORDER BY full_name
        """, (business_id,))
        biz["staff"] = [dict(r) for r in cur.fetchall()]

        return biz


@router.get("/{business_id}/summary")
def get_business_summary(
    business_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """
    Flat key/value summary suitable for {{#fcp_query: format=summary}}.
    Returns one row — business + primary location combined.
    """
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT
                b.trading_name           AS "Trading Name",
                b.name                   AS "Legal Name",
                b.food_registration_number AS "Registration Number",
                b.fcp_version            AS "FCP Version",
                b.fcp_effective_date     AS "FCP Effective Date",
                b.phone                  AS "Phone",
                b.email                  AS "Email",
                l.name                   AS "Location",
                l.address || ', ' || l.city AS "Address"
            FROM business b
            LEFT JOIN location l ON l.business_id = b.id AND l.is_active = TRUE
            WHERE b.id = %s AND b.is_active = TRUE
            ORDER BY l.name
            LIMIT 1
        """, (business_id,))
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Business not found.")
        return dict(row)


@suppliers_router.get("")
def list_suppliers(
    business_id: str = Query(...),
    caller: dict = Depends(auth.verify_request),
):
    """List active suppliers for a business — used to populate delivery check dropdowns."""
    auth.require_level(auth.GROUPS["training_employee"])(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT id, name, trading_name, contact_person, is_temperature_sensitive
            FROM supplier
            WHERE business_id = %s AND is_active = TRUE
            ORDER BY name
        """, (business_id,))
        return [dict(r) for r in cur.fetchall()]


@equipment_router.get("")
def list_equipment(
    location_id: str = Query(...),
    caller: dict = Depends(auth.verify_request),
):
    """List active equipment for a location — used to populate dropdowns."""
    auth.require_level(auth.GROUPS["training_employee"])(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT e.id, e.name, ec.name AS category
            FROM equipment e
            JOIN equipment_category ec ON ec.id = e.category_id
            WHERE e.location_id = %s AND e.is_active = TRUE
            ORDER BY ec.name, e.name
        """, (location_id,))
        return [dict(r) for r in cur.fetchall()]
