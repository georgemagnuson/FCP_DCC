from pydantic import BaseModel
from datetime import date
from typing import Optional


class EmployeeIn(BaseModel):
    full_name: str
    role: str
    mediawiki_username: Optional[str] = None
    food_handler_cert_number: Optional[str] = None
    cert_expiry: Optional[date] = None


class EmployeeOut(BaseModel):
    id: str
    full_name: str
    role: str
    mediawiki_username: Optional[str]
    food_handler_cert_number: Optional[str]
    cert_expiry: Optional[date]
    is_active: bool
