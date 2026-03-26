from pydantic import BaseModel
from uuid import UUID
from datetime import datetime
from typing import Optional
from enum import IntEnum


class CoolingStage(IntEnum):
    PRE_CLOCK = 0
    STAGE_1   = 1   # 60°C → 21°C
    STAGE_2   = 2   # 21°C → 5°C


class CoolingEventIn(BaseModel):
    location_id:       UUID
    food_description:  str
    batch_reference:   Optional[str] = None
    quantity_kg:       Optional[float] = None
    cooked_at:         datetime
    cooling_methods:   Optional[list[str]] = None
    is_proven_method:  bool = False
    proven_method_ref: Optional[str] = None
    notes:             Optional[str] = None
    # NZ FCP defaults — override only if stricter requirements apply
    clock_start_temp:       float = 60.0
    target_stage1_temp:     float = 21.0
    target_stage1_minutes:  int   = 120
    target_stage2_temp:     float = 5.0
    target_stage2_minutes:  int   = 240


class CoolingReadingIn(BaseModel):
    temp_celsius:  float
    recorded_at:   Optional[datetime] = None
    source:        str = "manual"
    sensor_id:     Optional[str] = None
    notes:         Optional[str] = None         # "moved to blast chiller", "stirred"


class CoolingReadingOut(BaseModel):
    id:              UUID
    event_id:        UUID
    recorded_at:     datetime
    minutes_elapsed: Optional[int]
    temp_celsius:    float
    stage:           Optional[int]
    recorded_by:     Optional[UUID]
    source:          str
    notes:           Optional[str]
    created_at:      datetime


class CoolingEventOut(BaseModel):
    id:                     UUID
    location_id:            UUID
    food_description:       str
    batch_reference:        Optional[str]
    quantity_kg:            Optional[float]
    cooked_at:              datetime
    cooling_methods:        Optional[list[str]]
    clock_start_temp:       float
    clock_started_at:       Optional[datetime]
    target_stage1_temp:     float
    target_stage1_minutes:  int
    target_stage2_temp:     float
    target_stage2_minutes:  int
    stage1_completed_at:    Optional[datetime]
    stage2_completed_at:    Optional[datetime]
    stage1_compliant:       Optional[bool]
    stage2_compliant:       Optional[bool]
    overall_compliant:      Optional[bool]
    is_proven_method:       bool
    opened_by:              UUID
    closed_by:              Optional[UUID]
    closed_at:              Optional[datetime]
    notes:                  Optional[str]
    created_at:             datetime
    updated_at:             datetime
    readings:               list[CoolingReadingOut] = []
    # Alert flags set by API
    stage1_breach:          bool = False        # True if stage 1 failed or at risk
    incident_suggested:     bool = False
