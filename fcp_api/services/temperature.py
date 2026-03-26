"""
Temperature business logic.
- Calculate in_range against equipment safe range
- Detect open incidents for the same equipment
"""
from datetime import datetime
from typing import Optional
import database


def calculate_in_range(
    equipment_id: str,
    temp_celsius: float,
    cur,
) -> Optional[bool]:
    """Return True/False/None based on equipment min/max_safe_temp."""
    cur.execute(
        "SELECT min_safe_temp, max_safe_temp FROM equipment WHERE id = %s",
        (equipment_id,)
    )
    row = cur.fetchone()
    if not row:
        return None
    min_t = row["min_safe_temp"]
    max_t = row["max_safe_temp"]
    if min_t is None and max_t is None:
        return None
    if min_t is not None and temp_celsius < min_t:
        return False
    if max_t is not None and temp_celsius > max_t:
        return False
    return True


def has_open_incident(equipment_id: str, cur) -> bool:
    """Return True if an unresolved incident already exists for this equipment."""
    cur.execute("""
        SELECT 1 FROM incident_report ir
        WHERE ir.trigger_table = 'temperature_log'
          AND ir.trigger_id IN (
              SELECT id FROM temperature_log
              WHERE equipment_id = %s AND in_range = FALSE
          )
          AND NOT EXISTS (
              SELECT 1 FROM corrective_action ca
              WHERE ca.incident_report_id = ir.id
                AND ca.closed_at IS NOT NULL
          )
        LIMIT 1
    """, (equipment_id,))
    return cur.fetchone() is not None


def insert_reading(
    equipment_id: str,
    temp_celsius: float,
    recorded_by: str,
    recorded_at: Optional[datetime],
    source: str,
    sensor_id: Optional[str],
    notes: Optional[str],
    cur,
) -> dict:
    """Insert a temperature reading and return the full row."""
    in_range = calculate_in_range(equipment_id, temp_celsius, cur)
    ts = recorded_at or datetime.now()

    cur.execute("""
        INSERT INTO temperature_log
            (equipment_id, recorded_at, temp_celsius, in_range,
             source, sensor_id, recorded_by, notes)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING *
    """, (equipment_id, ts, temp_celsius, in_range,
          source, sensor_id, recorded_by, notes))

    row = dict(cur.fetchone())

    # Enrich with equipment name
    cur.execute("SELECT name FROM equipment WHERE id = %s", (equipment_id,))
    eq = cur.fetchone()
    row["equipment_name"] = eq["name"] if eq else None
    row["alert"] = in_range is False
    row["incident_suggested"] = row["alert"] and not has_open_incident(equipment_id, cur)

    return row
