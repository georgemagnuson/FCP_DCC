from pydantic import BaseModel, model_validator
from uuid import UUID
from datetime import datetime, date
from typing import Optional
from models.utils import coerce_string_bools


class CleaningLogIn(BaseModel):
    location_id:   UUID
    equipment_id:  Optional[UUID] = None
    area:          Optional[str] = None
    task:          str
    performed_at:  Optional[datetime] = None
    product_used:  Optional[str] = None
    method:        Optional[str] = None
    source:        str = "manual"
    notes:         Optional[str] = None


class CleaningLogOut(BaseModel):
    id:            UUID
    location_id:   UUID
    equipment_id:  Optional[UUID]
    area:          Optional[str]
    task:          str
    performed_at:  datetime
    performed_by:  UUID
    product_used:  Optional[str]
    method:        Optional[str]
    verified_by:   Optional[UUID]
    source:        str
    notes:         Optional[str]
    created_at:    datetime


class MaintenanceLogIn(BaseModel):
    equipment_id:      UUID
    task_description:  str
    performed_at:      Optional[datetime] = None
    contractor_name:   Optional[str] = None     # if external contractor
    next_due_date:     Optional[date] = None
    notes:             Optional[str] = None


class MaintenanceLogOut(BaseModel):
    id:                     UUID
    equipment_id:           UUID
    task_description:       str
    performed_at:           datetime
    performed_by_employee:  Optional[UUID]
    contractor_name:        Optional[str]
    next_due_date:          Optional[date]
    notes:                  Optional[str]
    created_at:             datetime


class DeliveryCheckIn(BaseModel):
    location_id:        UUID
    supplier_id:        UUID
    product_description: str
    quantity:           Optional[str] = None
    use_by_date:        Optional[date] = None
    temp_on_arrival:    Optional[float] = None
    packaging_intact:   Optional[bool] = None
    appearance_ok:      Optional[bool] = None
    accepted:           bool
    rejection_reason:   Optional[str] = None
    delivery_date:      Optional[datetime] = None
    notes:              Optional[str] = None

    coerce_bools = model_validator(mode="before")(coerce_string_bools)


class DeliveryCheckOut(BaseModel):
    id:                  UUID
    location_id:         UUID
    supplier_id:         UUID
    delivery_date:       datetime
    product_description: str
    quantity:            Optional[str]
    use_by_date:         Optional[date]
    temp_on_arrival:     Optional[float]
    packaging_intact:    Optional[bool]
    appearance_ok:       Optional[bool]
    accepted:            bool
    rejection_reason:    Optional[str]
    checked_by:          UUID
    notes:               Optional[str]
    created_at:          datetime
