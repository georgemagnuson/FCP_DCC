from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel
from typing import Optional
import database
import auth

router = APIRouter(prefix="/business", tags=["business"])

# Separate routers for reference data — no /business prefix needed
suppliers_router = APIRouter(prefix="/suppliers", tags=["reference"])
equipment_router = APIRouter(prefix="/equipment",  tags=["reference"])

EMPLOYEE_LEVEL = auth.GROUPS["training_employee"]
MANAGER_LEVEL  = auth.GROUPS["training_manager"]


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


# ---------------------------------------------------------------------------
# Equipment — list, get, create, update, delete
# ---------------------------------------------------------------------------

class EquipmentIn(BaseModel):
    location_id: str
    category_id: str
    name: str
    make: Optional[str] = None
    model: Optional[str] = None
    serial_number: Optional[str] = None
    min_safe_temp: Optional[float] = None
    max_safe_temp: Optional[float] = None
    check_frequency_minutes: Optional[int] = None
    notes: Optional[str] = None


@equipment_router.get("/categories")
def list_equipment_categories(
    caller: dict = Depends(auth.verify_request),
):
    """List all equipment categories — used to populate the Add/Edit form dropdown."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("SELECT id, name FROM equipment_category ORDER BY name")
        return [dict(r) for r in cur.fetchall()]


@equipment_router.get("")
def list_equipment(
    location_id: str = Query(...),
    caller: dict = Depends(auth.verify_request),
):
    """List active equipment for a location."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT
                e.id,
                e.category_id,
                ec.name                                         AS category,
                e.name,
                COALESCE(e.make, '')                            AS make,
                COALESCE(e.model, '')                           AS model,
                COALESCE(e.serial_number, '')                   AS serial_number,
                e.min_safe_temp,
                e.max_safe_temp,
                e.check_frequency_minutes,
                COALESCE(e.notes, '')                           AS notes
            FROM equipment e
            JOIN equipment_category ec ON ec.id = e.category_id
            WHERE e.location_id = %s AND e.is_active = TRUE
            ORDER BY ec.name, e.name
        """, (location_id,))
        return [dict(r) for r in cur.fetchall()]


@equipment_router.get("/{equipment_id}")
def get_equipment(
    equipment_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Get a single equipment record by ID — used to pre-fill the edit form."""
    auth.require_level(EMPLOYEE_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            SELECT e.id, e.location_id, e.category_id, ec.name AS category,
                   e.name, e.make, e.model, e.serial_number,
                   e.min_safe_temp, e.max_safe_temp,
                   e.check_frequency_minutes, e.notes
            FROM equipment e
            JOIN equipment_category ec ON ec.id = e.category_id
            WHERE e.id = %s AND e.is_active = TRUE
        """, (equipment_id,))
        row = cur.fetchone()
        if not row:
            raise HTTPException(status_code=404, detail="Equipment not found.")
        return dict(row)


@equipment_router.post("")
def create_equipment(
    body: EquipmentIn,
    caller: dict = Depends(auth.verify_request),
):
    """Create a new equipment record. Requires manager level."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            INSERT INTO equipment
                (location_id, category_id, name, make, model, serial_number,
                 min_safe_temp, max_safe_temp, check_frequency_minutes, notes,
                 created_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            RETURNING id
        """, (
            body.location_id, body.category_id, body.name,
            body.make or None, body.model or None, body.serial_number or None,
            body.min_safe_temp, body.max_safe_temp,
            body.check_frequency_minutes, body.notes or None,
            caller["username"],
        ))
        return {"id": str(cur.fetchone()["id"]), "status": "created"}


@equipment_router.put("/{equipment_id}")
def update_equipment(
    equipment_id: str,
    body: EquipmentIn,
    caller: dict = Depends(auth.verify_request),
):
    """Update an equipment record. Requires manager level."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            UPDATE equipment SET
                category_id             = %s,
                name                    = %s,
                make                    = %s,
                model                   = %s,
                serial_number           = %s,
                min_safe_temp           = %s,
                max_safe_temp           = %s,
                check_frequency_minutes = %s,
                notes                   = %s,
                updated_by              = %s,
                updated_at              = NOW()
            WHERE id = %s AND is_active = TRUE
            RETURNING id
        """, (
            body.category_id, body.name,
            body.make or None, body.model or None, body.serial_number or None,
            body.min_safe_temp, body.max_safe_temp,
            body.check_frequency_minutes, body.notes or None,
            caller["username"],
            equipment_id,
        ))
        if not cur.fetchone():
            raise HTTPException(status_code=404, detail="Equipment not found.")
        return {"id": equipment_id, "status": "updated"}


@equipment_router.delete("/{equipment_id}")
def delete_equipment(
    equipment_id: str,
    caller: dict = Depends(auth.verify_request),
):
    """Soft-delete an equipment record (sets is_active = FALSE). Requires manager level."""
    auth.require_level(MANAGER_LEVEL)(caller)
    with database.get_cursor() as cur:
        cur.execute("""
            UPDATE equipment SET
                is_active  = FALSE,
                deleted_by = %s,
                updated_at = NOW()
            WHERE id = %s AND is_active = TRUE
            RETURNING id
        """, (caller["username"], equipment_id,))
        if not cur.fetchone():
            raise HTTPException(status_code=404, detail="Equipment not found.")
        return {"id": equipment_id, "status": "deleted"}
