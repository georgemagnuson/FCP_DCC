from pydantic import BaseModel
from uuid import UUID
from datetime import datetime
from typing import Optional


class TemperatureReadingIn(BaseModel):
    equipment_id:  UUID
    temp_celsius:  float
    recorded_at:   Optional[datetime] = None   # defaults to NOW() if omitted
    source:        str = "manual"              # manual | sensor | automated
    sensor_id:     Optional[str] = None
    notes:         Optional[str] = None


class TemperatureReadingOut(BaseModel):
    id:            UUID
    equipment_id:  UUID
    recorded_at:   datetime
    temp_celsius:  float
    in_range:      Optional[bool]
    source:        str
    sensor_id:     Optional[str]
    recorded_by:   Optional[UUID]
    notes:         Optional[str]
    created_at:    datetime

    # Enriched fields added by API
    equipment_name:     Optional[str] = None
    alert:              bool = False           # True when in_range is False
    incident_suggested: bool = False           # True when alert and no open incident exists
