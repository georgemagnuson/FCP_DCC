"""
Food cooling business logic.
Manages stage transitions and compliance per NZ FCP S39-00005:
  Stage 1: clock_start_temp (60°C) → target_stage1_temp (21°C) in target_stage1_minutes (120)
  Stage 2: target_stage1_temp (21°C) → target_stage2_temp (5°C) in target_stage2_minutes (240)
"""
from datetime import datetime
from typing import Optional
import database


def _elapsed_minutes(start: datetime, end: datetime) -> int:
    return int((end - start).total_seconds() / 60)


def add_reading(
    event_id: str,
    temp_celsius: float,
    recorded_by: str,
    recorded_at: Optional[datetime],
    source: str,
    sensor_id: Optional[str],
    notes: Optional[str],
    cur,
) -> tuple[dict, dict]:
    """
    Insert a cooling reading and update the event state machine.
    Returns (reading_row, updated_event_row).
    """
    ts = recorded_at or datetime.now()

    # Fetch current event state
    cur.execute("SELECT * FROM food_cooling_event WHERE id = %s", (event_id,))
    event = dict(cur.fetchone())

    if event["closed_at"] is not None:
        raise ValueError("Cannot add reading to a closed cooling event.")

    # Determine stage and update clock if needed
    stage          = 0
    clock_started  = event["clock_started_at"]
    minutes_elapsed = None

    if clock_started is None:
        # Has food reached the clock start temperature?
        if temp_celsius <= event["clock_start_temp"]:
            clock_started = ts
            cur.execute(
                "UPDATE food_cooling_event SET clock_started_at = %s, updated_at = NOW() WHERE id = %s",
                (clock_started, event_id)
            )
            stage = 1
    else:
        minutes_elapsed = _elapsed_minutes(clock_started, ts)
        # Determine current stage from event state
        if event["stage1_completed_at"] is None:
            stage = 1
        else:
            stage = 2

    # Insert the reading
    cur.execute("""
        INSERT INTO food_cooling_reading
            (event_id, recorded_at, minutes_elapsed, temp_celsius,
             stage, recorded_by, source, sensor_id, notes)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING *
    """, (event_id, ts, minutes_elapsed, temp_celsius,
          stage, recorded_by, source, sensor_id, notes))
    reading = dict(cur.fetchone())

    # Stage transition logic
    if clock_started and stage == 1 and temp_celsius <= event["target_stage1_temp"]:
        elapsed = _elapsed_minutes(clock_started, ts)
        compliant = elapsed <= event["target_stage1_minutes"]
        cur.execute("""
            UPDATE food_cooling_event
            SET stage1_completed_at = %s,
                stage1_compliant    = %s,
                updated_at          = NOW()
            WHERE id = %s
        """, (ts, compliant, event_id))

    elif clock_started and stage == 2 and temp_celsius <= event["target_stage2_temp"]:
        stage2_start = event["stage1_completed_at"]
        elapsed = _elapsed_minutes(stage2_start, ts)
        s2_compliant = elapsed <= event["target_stage2_minutes"]
        # Fetch stage1_compliant (may have just been set above)
        cur.execute("SELECT stage1_compliant FROM food_cooling_event WHERE id = %s", (event_id,))
        s1 = cur.fetchone()["stage1_compliant"]
        overall = bool(s1) and s2_compliant
        cur.execute("""
            UPDATE food_cooling_event
            SET stage2_completed_at = %s,
                stage2_compliant    = %s,
                overall_compliant   = %s,
                closed_at           = %s,
                closed_by           = %s,
                updated_at          = NOW()
            WHERE id = %s
        """, (ts, s2_compliant, overall, ts, recorded_by, event_id))

    # Check 6-hour breach (total = stage1 + stage2 minutes)
    elif clock_started:
        max_minutes = event["target_stage1_minutes"] + event["target_stage2_minutes"]
        if minutes_elapsed and minutes_elapsed > max_minutes and event["closed_at"] is None:
            cur.execute("""
                UPDATE food_cooling_event
                SET overall_compliant = FALSE,
                    closed_at         = %s,
                    closed_by         = %s,
                    updated_at        = NOW()
                WHERE id = %s
            """, (ts, recorded_by, event_id))

    # Return updated event
    cur.execute("SELECT * FROM food_cooling_event WHERE id = %s", (event_id,))
    updated_event = dict(cur.fetchone())

    return reading, updated_event
