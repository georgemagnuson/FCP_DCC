"""
HACCP compliance report builder for CAPM sessions (capm_sessions/capm_readings).

Mirrors the two-phase cooling state machine and report layout implemented
on-device in Arduino/ESP8266/Continuous_Ambient_Probe_Monitor/ComplianceManager.h
and handleComplianceReport(), but reads from the durable jitsu_fcp copy of the
data instead of the device's bounded in-RAM log — so a report can be produced
for any past session, not just the current/just-finished one.

Cooling protocol (NZ Food Control Plan, matches firmware defaults):
  Cooking  -> Phase 1: probe must reach <=21C (advisory 2h, no hard fail)
  Phase 1  -> Phase 2: probe must reach <=5C within 4h, else 30-min grace
  Grace expires without reaching target -> Fail
"""
from pathlib import Path
from typing import Any

from jinja2 import Environment, FileSystemLoader

_TEMPLATE_DIR = Path(__file__).resolve().parent.parent / "templates"
_env = Environment(loader=FileSystemLoader(_TEMPLATE_DIR))
_env.filters["dt"] = lambda v: v.strftime("%Y-%m-%d %H:%M:%S") if v else "--"
_env.filters["time_only"] = lambda v: v.strftime("%H:%M:%S") if v else "--"

COOK_THRESHOLD_C  = 60.0
PHASE1_TARGET_C   = 21.0
PHASE2_TARGET_C   = 5.0
PHASE1_LIMIT_SEC  = 2 * 3600
PHASE2_LIMIT_SEC  = 4 * 3600
GRACE_LIMIT_SEC   = 30 * 60

PHASE_LABELS = {
    "idle":    "Idle",
    "cooking": "Cooking",
    "phase1":  "Phase 1",
    "phase2":  "Phase 2",
    "grace":   "Grace",
    "pass":    "Pass",
    "fail":    "Fail",
}

# CSS row classes, matching the firmware's on-device report styling.
PHASE_ROW_CLASS = {
    "cooking": "ck",
    "phase1":  "p1",
    "phase2":  "p2",
    "grace":   "gr",
    "pass":    "ps",
    "fail":    "fl",
}

# (result label, badge class) for the two possible verdicts.
RESULT_BY_PHASE = {
    "pass": ("COMPLIANT", "pass"),
    "fail": ("NON-COMPLIANT", "fail"),
}
RESULT_DEFAULT = ("IN PROGRESS", "prog")

# SVG chart geometry (viewBox units) — shared by the plot area and the
# reference/axis lines drawn against it.
CHART_W, CHART_H = 620, 210
CHART_X0, CHART_X1 = 40, 580
CHART_Y0, CHART_Y1 = 22, 190

# The phase timeline bar sits above the chart at full container width, so it
# gets the same left/right inset (as a % of that width) as the chart's plot
# area — that's what keeps the two time axes visually aligned.
CHART_MARGIN_LEFT_PCT  = CHART_X0 / CHART_W * 100
CHART_MARGIN_RIGHT_PCT = (CHART_W - CHART_X1) / CHART_W * 100


def get_session(session_id: str, cur) -> dict | None:
    cur.execute("""
        SELECT s.*, d.device_name, d.hostname, d.device_type
        FROM capm_sessions s
        LEFT JOIN capm_devices d ON d.mac_address = s.mac_address
        WHERE s.id = %s
    """, (session_id,))
    row = cur.fetchone()
    return dict(row) if row else None


def get_readings(session_id: str, cur) -> list[dict]:
    cur.execute("""
        SELECT reading_timestamp, readings, compliance_phase, danger_zone_level
        FROM capm_readings
        WHERE session_id = %s
        ORDER BY reading_timestamp ASC
    """, (session_id,))
    return [dict(r) for r in cur.fetchall()]


def _fmt_elapsed(seconds: float | None) -> str:
    if seconds is None:
        return "--"
    total = int(seconds)
    return f"{total // 3600}h {(total % 3600) // 60}m {total % 60}s"


def _fmt_temp(value: Any) -> str:
    return "--" if value is None else f"{value:.1f}"


def _phase_timing(readings: list[dict]) -> dict:
    """
    Derive Phase 1 / Phase 2 start/end times and end temps from each row's
    logged compliance_phase, the same approach the firmware's report uses
    against its in-RAM log.
    """
    p1_start = p1_end = p2_start = p2_end = None
    p1_end_temp = p2_end_temp = None

    for row in readings:
        phase = row["compliance_phase"]
        if not phase or phase == "idle":
            continue
        ts = row["reading_timestamp"]
        probe_temp = (row["readings"] or {}).get("kmeter_temp")

        if phase == "phase1" and p1_start is None:
            p1_start = ts

        if phase in ("phase2", "grace", "pass", "fail") and p1_end is None and p1_start is not None:
            p1_end = ts
            p1_end_temp = probe_temp
            p2_start = ts

        if phase in ("pass", "fail"):
            p2_end = ts
            p2_end_temp = probe_temp

    p1_elapsed_sec = (p1_end - p1_start).total_seconds() if p1_start and p1_end else None
    p2_elapsed_sec = (p2_end - p2_start).total_seconds() if p2_start and p2_end else None

    p1_late_sec = 0
    if p1_elapsed_sec is not None:
        overrun = p1_elapsed_sec - PHASE1_LIMIT_SEC
        p1_late_sec = int(overrun) if overrun > 0 else 0

    return {
        "phase1": {
            "start": p1_start, "end": p1_end,
            "elapsed_seconds": p1_elapsed_sec, "elapsed_label": _fmt_elapsed(p1_elapsed_sec),
            "end_temp": p1_end_temp, "end_temp_label": _fmt_temp(p1_end_temp),
            "late_seconds": p1_late_sec,
        },
        "phase2": {
            "start": p2_start, "end": p2_end,
            "elapsed_seconds": p2_elapsed_sec, "elapsed_label": _fmt_elapsed(p2_elapsed_sec),
            "end_temp": p2_end_temp, "end_temp_label": _fmt_temp(p2_end_temp),
        },
    }


def _build_visuals(readings: list[dict]) -> dict:
    """
    Phase timeline segments (as % width) and an SVG line-chart polyline of
    probe (needle/kmeter) temperature over elapsed time, scaled to this
    session's own duration and temperature range.
    """
    non_idle = [r for r in readings if r["compliance_phase"] and r["compliance_phase"] != "idle"]
    if len(non_idle) < 2:
        return {"segments": [], "chart": None, "ticks": []}

    # Anchor 0h at the moment the probe first reaches the 60C cook threshold,
    # not at the first logged reading — cooking rows still above 60C are
    # pre-cook-down time, not part of the cooling clock, so they're dropped
    # from the timeline/chart entirely rather than shown before "0h".
    cook_idx = next(
        (i for i, r in enumerate(non_idle)
         if ((r["readings"] or {}).get("kmeter_temp") or 999) <= COOK_THRESHOLD_C),
        0,
    )
    non_idle = non_idle[cook_idx:]
    if len(non_idle) < 2:
        return {"segments": [], "chart": None, "ticks": []}

    t0 = non_idle[0]["reading_timestamp"]
    total_min = (non_idle[-1]["reading_timestamp"] - t0).total_seconds() / 60.0
    if total_min <= 0:
        return {"segments": [], "chart": None, "ticks": []}

    def elapsed_min(row) -> float:
        return (row["reading_timestamp"] - t0).total_seconds() / 60.0

    # --- Phase timeline segments ---
    segments = []
    seg_phase = non_idle[0]["compliance_phase"]
    seg_start = 0.0
    for row in non_idle[1:]:
        phase = row["compliance_phase"]
        if phase != seg_phase:
            seg_end = elapsed_min(row)
            segments.append({
                "class": PHASE_ROW_CLASS.get(seg_phase, ""),
                "width_pct": (seg_end - seg_start) / total_min * 100,
            })
            seg_phase, seg_start = phase, seg_end
    segments.append({
        "class": PHASE_ROW_CLASS.get(seg_phase, ""),
        "width_pct": (total_min - seg_start) / total_min * 100,
    })

    # --- Time-axis ticks (whole hours, capped to ~8 marks) ---
    total_hours = total_min / 60.0
    step_hours = max(1, -(-int(total_hours) // 7))  # ceil(total_hours / 7), min 1
    ticks = list(range(0, int(total_hours) + step_hours, step_hours))

    # --- Temperature chart (needle/kmeter probe) ---
    points = [(elapsed_min(r), (r["readings"] or {}).get("kmeter_temp")) for r in non_idle]
    points = [(m, t) for m, t in points if t is not None]
    if not points:
        return {"segments": segments, "chart": None, "ticks": ticks}

    temp_max = max(10.0, *(t for _, t in points))
    y_max_axis = ((int(temp_max) // 10) + 1) * 10  # round up to next 10

    def x_px(m: float) -> float:
        return CHART_X0 + (m / total_min) * (CHART_X1 - CHART_X0)

    def y_px(c: float) -> float:
        return CHART_Y1 - (c / y_max_axis) * (CHART_Y1 - CHART_Y0)

    chart = {
        "poly_points": " ".join(f"{x_px(m):.1f},{y_px(t):.1f}" for m, t in points),
        "y_target0":   round(y_px(COOK_THRESHOLD_C), 1),
        "y_target1":   round(y_px(PHASE1_TARGET_C), 1),
        "y_target2":   round(y_px(PHASE2_TARGET_C), 1),
        "y_axis_max_label": f"{y_max_axis:.0f}°C",
        "tick_x": [round(x_px(h * 60), 1) for h in ticks],
        "tick_pct": [round(x_px(h * 60) / CHART_W * 100, 2) for h in ticks],
        "tick_label": [f"{h}h" for h in ticks],
    }
    return {"segments": segments, "chart": chart, "ticks": ticks}


def build_report(session: dict, readings: list[dict]) -> dict:
    """
    Assemble the full report payload: session/device info, phase timing,
    overall result, danger-zone alerts, and the per-reading table rows.
    """
    final_phase = readings[-1]["compliance_phase"] if readings else None
    timing = _phase_timing(readings)
    p2_note = ""

    if final_phase == "pass":
        result_label, badge_class = RESULT_BY_PHASE["pass"]
    elif session["ended_at"] is None:
        # Session still open — no verdict yet regardless of current phase.
        result_label, badge_class = RESULT_DEFAULT
    else:
        # Session has ended and Phase 2's target was never confirmed reached —
        # whether the firmware logged a formal "fail" row, the grace window
        # expired, or the session was simply closed mid-Phase-2/Phase-1 — the
        # monitoring period is over without proof of compliance, so the cook
        # is non-compliant. Don't let a missing "fail" transition read as
        # an open-ended "in progress".
        result_label, badge_class = RESULT_BY_PHASE["fail"]
        if final_phase == "fail":
            p2_note = "grace expired, target not reached"
        elif final_phase == "grace":
            p2_note = "session ended during grace period, target not reached"
        else:
            p2_note = "session ended before the Phase 2 target was reached"

    danger_alerts = [
        r for r in readings
        if r["danger_zone_level"] not in (None, "ok")
    ]

    visuals = _build_visuals(readings)

    rows = []
    for r in readings:
        phase = r["compliance_phase"] or "idle"
        if phase == "idle":
            continue
        vals = r["readings"] or {}
        rows.append({
            "time":         r["reading_timestamp"],
            "needle":       _fmt_temp(vals.get("kmeter_temp")),
            "water_probe":  _fmt_temp(vals.get("ds_probe")),
            "air_temp":     _fmt_temp(vals.get("dht_temp")),
            "humidity":     _fmt_temp(vals.get("dht_humidity")),
            "phase_label":  PHASE_LABELS.get(phase, phase),
            "row_class":    PHASE_ROW_CLASS.get(phase, ""),
            "danger_zone":  r["danger_zone_level"] if r["danger_zone_level"] not in (None, "ok") else "",
        })

    return {
        "session": {
            "id":           str(session["id"]),
            "session_name": session["session_name"],
            "device_name":  session.get("device_name") or session["mac_address"],
            "mac_address":  session["mac_address"],
            "mode":         session["mode"],
            "profile":      session["profile"],
            "started_at":   session["started_at"],
            "ended_at":     session["ended_at"],
            "end_reason":   session["end_reason"],
        },
        "result_label": result_label,
        "badge_class":   badge_class,
        "cook_threshold": COOK_THRESHOLD_C,
        "phase1_target": PHASE1_TARGET_C,
        "phase2_target": PHASE2_TARGET_C,
        "phase2_note":   p2_note,
        "timing":        timing,
        "danger_zone_alert_count": len(danger_alerts),
        "rows": rows,
        "segments": visuals["segments"],
        "chart":    visuals["chart"],
        "chart_w":  CHART_W, "chart_h": CHART_H,
        "chart_x0": CHART_X0, "chart_x1": CHART_X1,
        "chart_y0": CHART_Y0, "chart_y1": CHART_Y1,
        "chart_margin_left_pct":  round(CHART_MARGIN_LEFT_PCT, 2),
        "chart_margin_right_pct": round(CHART_MARGIN_RIGHT_PCT, 2),
    }


def render_html(report: dict) -> str:
    template = _env.get_template("capm_compliance_report.html")
    return template.render(**report)
