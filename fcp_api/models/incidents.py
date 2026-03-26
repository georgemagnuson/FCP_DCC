from pydantic import BaseModel, model_validator
from uuid import UUID
from datetime import datetime
from typing import Optional
from models.utils import coerce_string_bools


class IncidentReportIn(BaseModel):
    location_id:    UUID
    incident_type:  str     # temperature_breach | cooling_failure | equipment_failure |
                            # maintenance_issue | delivery_rejection | accident |
                            # contamination | pest | other
    severity:       str = "medium"   # low | medium | high | critical
    description:    str
    trigger_table:  Optional[str] = None   # source table name
    trigger_id:     Optional[UUID] = None  # UUID of triggering record


class IncidentReportOut(BaseModel):
    id:             UUID
    location_id:    UUID
    reported_at:    datetime
    reported_by:    UUID
    incident_type:  str
    severity:       str
    description:    str
    trigger_table:  Optional[str]
    trigger_id:     Optional[UUID]
    created_at:     datetime
    updated_at:     datetime
    actions:        list["CorrectiveActionOut"] = []
    is_open:        bool = True


class CorrectiveActionIn(BaseModel):
    action_taken:       str
    actioned_at:        Optional[datetime] = None
    outcome:            Optional[str] = None
    follow_up_required: bool = False
    follow_up_notes:    Optional[str] = None

    coerce_bools = model_validator(mode="before")(coerce_string_bools)


class CorrectiveActionOut(BaseModel):
    id:                  UUID
    incident_report_id:  UUID
    action_taken:        str
    actioned_by:         UUID
    actioned_at:         datetime
    outcome:             Optional[str]
    follow_up_required:  bool
    follow_up_notes:     Optional[str]
    closed_at:           Optional[datetime]
    closed_by:           Optional[UUID]
    created_at:          datetime
    updated_at:          datetime


class CloseActionIn(BaseModel):
    outcome:  Optional[str] = None


IncidentReportOut.model_rebuild()
