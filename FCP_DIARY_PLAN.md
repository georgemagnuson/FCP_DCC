# FCP Daily Diary — Implementation Plan

## Objective

Build out all data entry forms and display pages needed to complete the
Food Control Plan diary, storing all records in the `jitsu_fcp` PostgreSQL
database via the FCP API. Covers daily, weekly, four-weekly, and quarterly
requirements.

---

## Recording Schedule

| Frequency | What |
|-----------|------|
| **Daily** | Opening check, closing check, temperature readings (all equipment) |
| **Per batch** | Food cooling process record (start + hourly readings) |
| **Per delivery** | Supplier delivery check |
| **Per incident** | Problem report + corrective action |
| **Weekly** | Pest activity, cleaning/maintenance completion, cooking verification |
| **Every 4 weeks** | Full review (problems, new staff, changes, FCP updates) |
| **Quarterly** | Thermometer calibration |

---

## What Already Exists

### Database Tables (jitsu_fcp on llamajail)
| Table | Purpose |
|-------|---------|
| `temperature_log` | Equipment temperature readings |
| `food_cooling_event` | Cooling batch record (start/end) |
| `food_cooling_reading` | Hourly readings per cooling event |
| `incident_report` | Problem reports |
| `corrective_action` | Actions taken per incident |
| `cleaning_log` | Cleaning tasks completed |
| `maintenance_log` | Equipment maintenance records |
| `delivery_check` | Supplier delivery inspections |
| `equipment` | FRIDGE-01, FREEZER-01, HOTBOX-01, DISPLAY-01 |

### FCP API Endpoints (working)
| Endpoint | Used for |
|----------|---------|
| `POST /temperature/reading` | Record a temp reading |
| `GET /temperature/today/{equipment_id}` | Today's readings |
| `GET /temperature/alerts` | Out-of-range readings |
| `POST /cooling/start` | Start a cooling event |
| `POST /cooling/{id}/reading` | Add a cooling reading |
| `GET /cooling/active` | Active cooling events |
| `GET /cooling/{id}` | Full event + readings |
| `POST /incidents` | File an incident |
| `POST /incidents/{id}/action` | Add corrective action |
| `POST /operations/cleaning` | Record cleaning task |
| `POST /operations/cleaning/{id}/verify` | Supervisor verify cleaning |
| `POST /operations/maintenance` | Record maintenance |
| `POST /operations/delivery` | Record delivery check |

### FcpBridge (MediaWiki Extension)
- `Special:FcpSubmit` — receives HTML form POSTs, forwards to API
- `{{#fcp_query:}}` — displays live API data in wiki pages
- `Special:FcpCoolingRecord` — **to be built** (multi-step)

---

## What Needs Building

### Wave 1 — New Database Tables

**1. `daily_check`** — Opening and closing checklists

```sql
CREATE TABLE daily_check (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id     uuid NOT NULL REFERENCES business(id),
    location_id     uuid REFERENCES location(id),
    check_date      date NOT NULL DEFAULT CURRENT_DATE,
    check_type      text NOT NULL CHECK (check_type IN ('opening', 'closing')),
    -- Opening fields
    staff_fit               boolean,
    facility_clean          boolean,
    handwash_available      boolean,
    -- Closing fields
    food_stored_correctly   boolean,
    temp_compliant          boolean,
    expired_food_disposed   boolean,
    cleaning_complete       boolean,
    waste_managed           boolean,
    -- Common
    all_ok          boolean GENERATED ALWAYS AS (
                        COALESCE(staff_fit, true) AND
                        COALESCE(facility_clean, true) AND
                        COALESCE(handwash_available, true) AND
                        COALESCE(food_stored_correctly, true) AND
                        COALESCE(temp_compliant, true) AND
                        COALESCE(expired_food_disposed, true) AND
                        COALESCE(cleaning_complete, true) AND
                        COALESCE(waste_managed, true)
                    ) STORED,
    notes           text,
    checked_by      text NOT NULL,   -- mediawiki_username
    created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON daily_check (check_date, check_type);
```

**2. `cooking_verification`** — Poultry/meat cooking temperature verification

```sql
CREATE TABLE cooking_verification (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id     uuid NOT NULL REFERENCES business(id),
    location_id     uuid REFERENCES location(id),
    verified_date   date NOT NULL DEFAULT CURRENT_DATE,
    food_item       text NOT NULL,          -- e.g. "Whole chicken", "Chicken breast"
    cooking_temp_c  numeric(5,1) NOT NULL,  -- recorded internal temp
    target_temp_c   numeric(5,1) NOT NULL DEFAULT 75.0,
    passed          boolean GENERATED ALWAYS AS (cooking_temp_c >= target_temp_c) STORED,
    verified_by     text NOT NULL,          -- mediawiki_username
    notes           text,
    created_at      timestamptz NOT NULL DEFAULT now()
);
```

**3. `weekly_check`** — Weekly review checklist

```sql
CREATE TABLE weekly_check (
    id                          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id                 uuid NOT NULL REFERENCES business(id),
    location_id                 uuid REFERENCES location(id),
    week_ending                 date NOT NULL,
    pest_activity_found         boolean NOT NULL DEFAULT false,
    pest_notes                  text,
    cleaning_tasks_complete     boolean NOT NULL DEFAULT true,
    maintenance_tasks_complete  boolean NOT NULL DEFAULT true,
    cooking_verification_done   boolean NOT NULL DEFAULT true,
    manager_notes               text,
    reviewed_by                 text NOT NULL,   -- mediawiki_username
    created_at                  timestamptz NOT NULL DEFAULT now(),
    UNIQUE (business_id, week_ending)
);
```

**4. `four_week_review`** — Mandatory 4-weekly review (13×/year)

```sql
CREATE TABLE four_week_review (
    id                          uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id                 uuid NOT NULL REFERENCES business(id),
    location_id                 uuid REFERENCES location(id),
    period_ending               date NOT NULL,
    problems_recurring          text,   -- issues occurring 3+ times
    customer_complaints         text,
    new_staff_added             boolean NOT NULL DEFAULT false,
    new_staff_notes             text,
    menu_changes                text,
    supplier_changes            text,
    equipment_changes           text,
    fcp_updated                 boolean NOT NULL DEFAULT false,
    council_approval_needed     boolean NOT NULL DEFAULT false,
    council_notes               text,
    reviewed_by                 text NOT NULL,   -- mediawiki_username
    created_at                  timestamptz NOT NULL DEFAULT now(),
    UNIQUE (business_id, period_ending)
);
```

**5. `thermometer_calibration`** — Quarterly calibration records

```sql
CREATE TABLE thermometer_calibration (
    id                      uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             uuid NOT NULL REFERENCES business(id),
    equipment_id            uuid REFERENCES equipment(id),
    thermometer_description text NOT NULL,  -- e.g. "Blue probe thermometer"
    calibration_date        date NOT NULL DEFAULT CURRENT_DATE,
    ice_slurry_reading_c    numeric(4,1),   -- should be 0°C ± 1°C
    boiling_reading_c       numeric(5,1),   -- should be ~99.7°C at sea level
    passed                  boolean NOT NULL,
    calibrated_by           text NOT NULL,  -- mediawiki_username
    next_due_date           date,
    notes                   text,
    created_at              timestamptz NOT NULL DEFAULT now()
);
```

---

### Wave 2 — New API Router: `diary.py`

New file: `fcp_api/routers/diary.py` with prefix `/diary`

```
POST /diary/opening-check           — daily_check (check_type=opening)
POST /diary/closing-check           — daily_check (check_type=closing)
GET  /diary/checks/today            — both checks for today (done/not done)
GET  /diary/checks?date=YYYY-MM-DD  — checks for a specific date

POST /diary/cooking-verification    — cooking_verification record
GET  /diary/cooking-verifications?date=YYYY-MM-DD

POST /diary/weekly-check            — weekly_check record
GET  /diary/weekly-checks?weeks=8   — last N weeks

POST /diary/four-week-review        — four_week_review record
GET  /diary/four-week-reviews       — all reviews

POST /diary/thermometer-calibration — thermometer_calibration record
GET  /diary/thermometer-calibrations — all calibration records
```

**Permission levels:**
- POST opening/closing check: `training_employee` (any logged-in user)
- POST cooking verification: `training_employee`
- POST weekly check: `training_manager`
- POST four-week review: `training_manager`
- POST thermometer calibration: `training_supervisor` or `training_manager`
- All GET: `training_employee`

---

### Wave 3 — Update `SpecialFcpSubmit` Whitelist

Add new diary endpoints to `ALLOWED_ENDPOINTS` in `SpecialFcpSubmit.php`:

```php
'diary/opening-check',
'diary/closing-check',
'diary/cooking-verification',
'diary/weekly-check',
'diary/four-week-review',
'diary/thermometer-calibration',
'operations/delivery',
'operations/maintenance',
'incidents',
```

---

### Wave 4 — MediaWiki Pages & Forms

All pages live under the `FCP:` namespace prefix.

#### Daily Pages

**`FCP:Temperature_Log`**
- `{{#fcp_query: endpoint=temperature/today/FRIDGE-01-uuid | format=table}}`
  (one block per equipment)
- Form → `Special:FcpSubmit` with `fcp_action=temperature/reading`
- Fields: equipment (dropdown), temperature_c, recorded_at (datetime)
- Redirect back to this page on success

**`FCP:Opening_Check`**
- Display: this week's opening checks
- Form → `fcp_action=diary/opening-check`
- Checkboxes: staff_fit, facility_clean, handwash_available + notes field

**`FCP:Closing_Check`**
- Display: this week's closing checks
- Form → `fcp_action=diary/closing-check`
- Checkboxes: food_stored_correctly, temp_compliant, expired_food_disposed,
  cleaning_complete, waste_managed + notes field

#### Cooling Process — Special Page

**`Special:FcpCoolingRecord`** — dedicated multi-step special page

```
?action=start
  — form: food_item, initial_temp_c, quantity_kg, start_time
  — calls POST /cooling/start
  — redirects to ?action=view&event={new_uuid}

?action=reading&event={uuid}
  — form: temperature_c, reading_time
  — calls POST /cooling/{uuid}/reading
  — shows running compliance status (within time limits?)
  — redirects back to ?action=view&event={uuid}

?action=view&event={uuid}
  — GET /cooling/{uuid}
  — shows all readings, elapsed time, compliance status
  — link to add another reading
  — compliance check: 60→21°C within 2h, 21→5°C within 4h
```

**`FCP:Cooling_Records`** (display page)
- `{{#fcp_query: endpoint=cooling/active | format=table}}` — active events
- `{{#fcp_query: endpoint=cooling/history | format=table}}` — recent completed
- Link to `Special:FcpCoolingRecord?action=start`

#### Operational Pages

**`FCP:Delivery_Check`**
- Form → `fcp_action=operations/delivery`
- Fields: supplier (dropdown from GET /suppliers), delivery_time,
  temp_on_arrival_c, packaging_ok (checkbox), accepted (checkbox), notes

**`FCP:Incident_Report`**
- Form → `fcp_action=incidents`
- Fields: description, severity (dropdown: low/medium/high/critical),
  equipment_id (optional dropdown), immediate_action_taken

**`FCP:Cleaning_Log`**
- Form → `fcp_action=operations/cleaning`
- Fields: task_description, area, cleaned_by (dropdown), completed_at (datetime)
- Verify form → `fcp_action=operations/cleaning/{id}/verify`

#### Weekly Pages

**`FCP:Weekly_Check`**
- Display: last 8 weeks of weekly checks
- Form → `fcp_action=diary/weekly-check`
- Fields: week_ending (date), pest_activity_found (yes/no), pest_notes,
  cleaning_tasks_complete, maintenance_tasks_complete,
  cooking_verification_done, manager_notes

**`FCP:Cooking_Verification`**
- Display: last 4 weeks of verifications
- Form → `fcp_action=diary/cooking-verification`
- Fields: food_item (text), cooking_temp_c (number), notes
- Shows pass/fail based on ≥75°C threshold

#### Monthly/Quarterly Pages

**`FCP:Four_Week_Review`**
- Display: all past reviews
- Form → `fcp_action=diary/four-week-review`
- Fields: period_ending (date), problems_recurring, customer_complaints,
  new_staff_added (yes/no), new_staff_notes, menu_changes, supplier_changes,
  equipment_changes, fcp_updated (yes/no), council_approval_needed (yes/no),
  council_notes

**`FCP:Thermometer_Calibration`**
- Display: all past calibrations + next due dates
- Form → `fcp_action=diary/thermometer-calibration`
- Fields: thermometer_description, calibration_date, ice_slurry_reading_c,
  boiling_reading_c, passed (yes/no), next_due_date, notes

---

### Wave 5 — Daily Dashboard

**`FCP:Daily_Dashboard`** (or `FCP:Diary`)

Central landing page showing today's compliance status at a glance:

```
TODAY — Tuesday 25 March 2026
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Opening Check     ✅ Done — 7:02am — Carlos Chef
Temperature Log   ⚠️  3 of 4 done — DISPLAY-01 missing
Active Cooling    🔴 1 active — Chicken stock (started 2:00pm)
Closing Check     ❌ Not done
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Record Temperature]  [Opening Check]  [Closing Check]
[Start Cooling]       [Delivery Check] [Report Incident]
```

This page uses `{{#fcp_query:}}` blocks for each section and quick-action links.

---

## Implementation Waves Summary

| Wave | Scope | New Files |
|------|-------|-----------|
| 1 | DB schema (5 new tables) | `jitsu_fcp_diary_tables.sql` |
| 2 | API router | `fcp_api/routers/diary.py`, update `main.py` |
| 3 | FcpSubmit whitelist | Update `SpecialFcpSubmit.php` |
| 4a | Daily forms (temp, opening, closing) | 3 wiki pages |
| 4b | Special:FcpCoolingRecord | New PHP special page + extension.json |
| 4c | Operational forms (delivery, incident, cleaning) | 3 wiki pages |
| 4d | Weekly forms (weekly check, cooking verification) | 2 wiki pages |
| 4e | Monthly/quarterly forms (4-week review, calibration) | 2 wiki pages |
| 5 | Daily dashboard | 1 wiki page |

---

## Supplier Endpoint (needed for Delivery Check dropdown)

`GET /suppliers` — list active suppliers for dropdown
- Add to `fcp_api/routers/business.py` or new `suppliers.py`
- Returns id, name, contact for the delivery form

## Equipment Endpoint (needed for Temperature form dropdown)

`GET /equipment` — list active equipment for dropdown
- Already has data: FRIDGE-01, FREEZER-01, HOTBOX-01, DISPLAY-01
- Add to `fcp_api/routers/business.py`
