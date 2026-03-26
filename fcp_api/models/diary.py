from pydantic import BaseModel, model_validator
from uuid import UUID
from datetime import date, datetime
from typing import Optional
from models.utils import coerce_string_bools

# Alias used as model_validator target — keeps model definitions concise
_coerce_string_bools = coerce_string_bools


# =============================================================
# Daily Check — opening and closing checklists
# =============================================================

class OpeningCheckIn(BaseModel):
    business_id:        UUID
    location_id:        Optional[UUID] = None
    check_date:         Optional[date] = None       # defaults to today in router
    staff_fit:          Optional[bool] = None
    facility_clean:     Optional[bool] = None
    handwash_available: Optional[bool] = None
    notes:              Optional[str] = None

    coerce_bools = model_validator(mode="before")(_coerce_string_bools)


class ClosingCheckIn(BaseModel):
    business_id:            UUID
    location_id:            Optional[UUID] = None
    check_date:             Optional[date] = None   # defaults to today in router
    food_stored_correctly:  Optional[bool] = None
    temp_compliant:         Optional[bool] = None
    expired_food_disposed:  Optional[bool] = None
    cleaning_complete:      Optional[bool] = None
    waste_managed:          Optional[bool] = None
    notes:                  Optional[str] = None

    coerce_bools = model_validator(mode="before")(_coerce_string_bools)


class DailyCheckOut(BaseModel):
    id:                     UUID
    business_id:            UUID
    location_id:            Optional[UUID]
    check_date:             date
    check_type:             str
    staff_fit:              Optional[bool]
    facility_clean:         Optional[bool]
    handwash_available:     Optional[bool]
    food_stored_correctly:  Optional[bool]
    temp_compliant:         Optional[bool]
    expired_food_disposed:  Optional[bool]
    cleaning_complete:      Optional[bool]
    waste_managed:          Optional[bool]
    all_ok:                 bool
    notes:                  Optional[str]
    checked_by:             str
    created_at:             datetime


# =============================================================
# Cooking Verification
# =============================================================

class CookingVerificationIn(BaseModel):
    business_id:    UUID
    location_id:    Optional[UUID] = None
    verified_date:  Optional[date] = None           # defaults to today in router
    food_item:      str
    cooking_temp_c: float
    target_temp_c:  float = 75.0
    notes:          Optional[str] = None


class CookingVerificationOut(BaseModel):
    id:             UUID
    business_id:    UUID
    location_id:    Optional[UUID]
    verified_date:  date
    food_item:      str
    cooking_temp_c: float
    target_temp_c:  float
    passed:         bool
    verified_by:    str
    notes:          Optional[str]
    created_at:     datetime


# =============================================================
# Weekly Check
# =============================================================

class WeeklyCheckIn(BaseModel):
    business_id:                UUID
    location_id:                Optional[UUID] = None
    week_ending:                date
    pest_activity_found:        bool = False
    pest_notes:                 Optional[str] = None
    cleaning_tasks_complete:    bool = True
    maintenance_tasks_complete: bool = True
    cooking_verification_done:  bool = True
    manager_notes:              Optional[str] = None

    coerce_bools = model_validator(mode="before")(_coerce_string_bools)


class WeeklyCheckOut(BaseModel):
    id:                         UUID
    business_id:                UUID
    location_id:                Optional[UUID]
    week_ending:                date
    pest_activity_found:        bool
    pest_notes:                 Optional[str]
    cleaning_tasks_complete:    bool
    maintenance_tasks_complete: bool
    cooking_verification_done:  bool
    manager_notes:              Optional[str]
    reviewed_by:                str
    created_at:                 datetime


# =============================================================
# Four-Week Review
# =============================================================

class FourWeekReviewIn(BaseModel):
    business_id:            UUID
    location_id:            Optional[UUID] = None
    period_ending:          date
    problems_recurring:     Optional[str] = None
    customer_complaints:    Optional[str] = None
    new_staff_added:        bool = False
    new_staff_notes:        Optional[str] = None
    menu_changes:           Optional[str] = None
    supplier_changes:       Optional[str] = None
    equipment_changes:      Optional[str] = None
    fcp_updated:            bool = False
    council_approval_needed: bool = False
    council_notes:          Optional[str] = None

    coerce_bools = model_validator(mode="before")(_coerce_string_bools)


class FourWeekReviewOut(BaseModel):
    id:                     UUID
    business_id:            UUID
    location_id:            Optional[UUID]
    period_ending:          date
    problems_recurring:     Optional[str]
    customer_complaints:    Optional[str]
    new_staff_added:        bool
    new_staff_notes:        Optional[str]
    menu_changes:           Optional[str]
    supplier_changes:       Optional[str]
    equipment_changes:      Optional[str]
    fcp_updated:            bool
    council_approval_needed: bool
    council_notes:          Optional[str]
    reviewed_by:            str
    created_at:             datetime


# =============================================================
# Thermometer Calibration
# =============================================================

class ThermometerCalibrationIn(BaseModel):
    business_id:            UUID
    equipment_id:           Optional[UUID] = None
    thermometer_description: str
    calibration_date:       Optional[date] = None   # defaults to today in router
    ice_slurry_reading_c:   Optional[float] = None
    boiling_reading_c:      Optional[float] = None
    passed:                 bool
    next_due_date:          Optional[date] = None
    notes:                  Optional[str] = None

    coerce_bools = model_validator(mode="before")(_coerce_string_bools)


class ThermometerCalibrationOut(BaseModel):
    id:                     UUID
    business_id:            UUID
    equipment_id:           Optional[UUID]
    thermometer_description: str
    calibration_date:       date
    ice_slurry_reading_c:   Optional[float]
    boiling_reading_c:      Optional[float]
    passed:                 bool
    calibrated_by:          str
    next_due_date:          Optional[date]
    notes:                  Optional[str]
    created_at:             datetime
