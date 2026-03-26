"""
Shared Pydantic utilities for FCP API models.
"""
from typing import Any


def coerce_string_bools(values: dict[str, Any]) -> dict[str, Any]:
    """
    Pre-process incoming data to coerce string boolean values to actual booleans.

    The PHP bridge sends all HTML form values as strings inside JSON.
    This validator is applied as a model_validator(mode="before") on any
    model that contains bool fields populated from HTML form submissions.

    Accepts: "true"/"false", "1"/"0", "yes"/"no", "on"/"off" (case-insensitive).
    Non-matching strings are left unchanged.
    """
    TRUE_VALS  = {"true", "1", "yes", "on"}
    FALSE_VALS = {"false", "0", "no", "off"}
    result = {}
    for k, v in values.items():
        if isinstance(v, str):
            low = v.lower()
            if low in TRUE_VALS:
                result[k] = True
            elif low in FALSE_VALS:
                result[k] = False
            else:
                result[k] = v
        else:
            result[k] = v
    return result
