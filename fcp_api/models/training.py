from pydantic import BaseModel
from datetime import date
from typing import Optional


class TrainingModuleOut(BaseModel):
    id: int
    module_code: str
    module_name: str
    category: str
    display_order: int
    is_active: bool


class TrainingRecordStatus(BaseModel):
    module_id: int
    module_code: str
    module_name: str
    category: str
    display_order: int
    na_date: Optional[date]
    na_reason: Optional[str]
    na_by: Optional[str]
    assigned_date: Optional[date]
    assigned_by: Optional[str]
    completed_date: Optional[date]
    completed_by: Optional[str]
    verified_date: Optional[date]
    verified_by: Optional[str]
    status: str  # "not_assigned" | "assigned" | "na" | "completed" | "verified"


class TrainingEmployeeRecord(BaseModel):
    mediawiki_username: str
    full_name: str
    modules: list[TrainingRecordStatus]


class AssignIn(BaseModel):
    action_date: Optional[date] = None


class NaIn(BaseModel):
    action_date: Optional[date] = None
    reason: str


class CompleteIn(BaseModel):
    action_date: Optional[date] = None


class VerifyIn(BaseModel):
    action_date: Optional[date] = None
