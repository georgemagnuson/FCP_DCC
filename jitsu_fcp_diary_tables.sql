-- =============================================================
-- jitsu_fcp diary tables — Wave 1
-- Food Control Plan periodic diary records
-- Daily, weekly, 4-weekly, quarterly requirements
-- =============================================================

-- =============================================================
-- DAILY RECORDS
-- =============================================================

CREATE TABLE daily_check (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    location_id             UUID REFERENCES location(id),
    check_date              DATE NOT NULL DEFAULT CURRENT_DATE,
    check_type              TEXT NOT NULL CHECK (check_type IN ('opening', 'closing')),
    -- Opening fields (NULL if closing check)
    staff_fit               BOOLEAN,                            -- staff are well and fit for work
    facility_clean          BOOLEAN,                            -- facility is clean and tidy
    handwash_available      BOOLEAN,                            -- handwash facilities stocked
    -- Closing fields (NULL if opening check)
    food_stored_correctly   BOOLEAN,                            -- all food covered and at correct temp
    temp_compliant          BOOLEAN,                            -- all equipment within safe range
    expired_food_disposed   BOOLEAN,                            -- expired/out-of-date food removed
    cleaning_complete       BOOLEAN,                            -- end-of-day cleaning done
    waste_managed           BOOLEAN,                            -- waste bins emptied, area clear
    -- Computed: TRUE only if every applicable field is TRUE
    all_ok                  BOOLEAN GENERATED ALWAYS AS (
                                COALESCE(staff_fit, TRUE) AND
                                COALESCE(facility_clean, TRUE) AND
                                COALESCE(handwash_available, TRUE) AND
                                COALESCE(food_stored_correctly, TRUE) AND
                                COALESCE(temp_compliant, TRUE) AND
                                COALESCE(expired_food_disposed, TRUE) AND
                                COALESCE(cleaning_complete, TRUE) AND
                                COALESCE(waste_managed, TRUE)
                            ) STORED,
    notes                   TEXT,
    checked_by              TEXT NOT NULL,                      -- mediawiki_username
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE daily_check IS 'Opening and closing checklists per FCP daily monitoring requirements. One row per check_type per day.';
COMMENT ON COLUMN daily_check.all_ok IS 'Generated: TRUE only if every applicable boolean field is TRUE (NULLs treated as OK).';
COMMENT ON COLUMN daily_check.checked_by IS 'MediaWiki username of the staff member completing the check.';

CREATE INDEX idx_daily_check_location_date  ON daily_check(location_id, check_date DESC);
CREATE INDEX idx_daily_check_date_type      ON daily_check(check_date, check_type);
CREATE INDEX idx_daily_check_not_ok         ON daily_check(location_id, check_date DESC)
                                                WHERE all_ok = FALSE;
CREATE UNIQUE INDEX idx_daily_check_unique  ON daily_check(business_id, location_id, check_date, check_type);


-- =============================================================
-- COOKING VERIFICATION
-- =============================================================

CREATE TABLE cooking_verification (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    location_id             UUID REFERENCES location(id),
    verified_date           DATE NOT NULL DEFAULT CURRENT_DATE,
    food_item               TEXT NOT NULL,                      -- e.g. "Whole chicken", "Chicken breast"
    cooking_temp_c          NUMERIC(5,1) NOT NULL,              -- recorded internal temperature
    target_temp_c           NUMERIC(5,1) NOT NULL DEFAULT 75.0, -- NZ FCP minimum: 75°C core temp
    passed                  BOOLEAN GENERATED ALWAYS AS (cooking_temp_c >= target_temp_c) STORED,
    verified_by             TEXT NOT NULL,                      -- mediawiki_username
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE cooking_verification IS 'Weekly cooking temperature verification per FCP. Records that high-risk foods (poultry, meat) reach the required internal temperature.';
COMMENT ON COLUMN cooking_verification.target_temp_c IS 'NZ FCP minimum is 75°C core temperature. Can be set higher per business policy.';
COMMENT ON COLUMN cooking_verification.passed IS 'Generated: TRUE if cooking_temp_c >= target_temp_c.';
COMMENT ON COLUMN cooking_verification.verified_by IS 'MediaWiki username of the staff member taking the temperature reading.';

CREATE INDEX idx_cooking_verif_location_date ON cooking_verification(location_id, verified_date DESC);
CREATE INDEX idx_cooking_verif_failed        ON cooking_verification(location_id, verified_date DESC)
                                                WHERE passed = FALSE;


-- =============================================================
-- WEEKLY REVIEW
-- =============================================================

CREATE TABLE weekly_check (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id                 UUID NOT NULL REFERENCES business(id),
    location_id                 UUID REFERENCES location(id),
    week_ending                 DATE NOT NULL,
    pest_activity_found         BOOLEAN NOT NULL DEFAULT FALSE,
    pest_notes                  TEXT,                           -- required if pest_activity_found = TRUE
    cleaning_tasks_complete     BOOLEAN NOT NULL DEFAULT TRUE,
    maintenance_tasks_complete  BOOLEAN NOT NULL DEFAULT TRUE,
    cooking_verification_done   BOOLEAN NOT NULL DEFAULT TRUE,
    manager_notes               TEXT,
    reviewed_by                 TEXT NOT NULL,                  -- mediawiki_username
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (business_id, week_ending)
);

COMMENT ON TABLE weekly_check IS 'Weekly FCP review covering pest activity, cleaning/maintenance completion, and cooking verification status.';
COMMENT ON COLUMN weekly_check.week_ending IS 'The Sunday (or last day) of the review week. UNIQUE per business to prevent duplicate weekly reviews.';
COMMENT ON COLUMN weekly_check.pest_notes IS 'Required when pest_activity_found = TRUE. Describe what was found and action taken.';
COMMENT ON COLUMN weekly_check.reviewed_by IS 'MediaWiki username of the manager completing the weekly review.';

CREATE INDEX idx_weekly_check_location       ON weekly_check(location_id, week_ending DESC);
CREATE INDEX idx_weekly_check_pest           ON weekly_check(location_id, week_ending DESC)
                                                WHERE pest_activity_found = TRUE;


-- =============================================================
-- FOUR-WEEKLY REVIEW
-- =============================================================

CREATE TABLE four_week_review (
    id                          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id                 UUID NOT NULL REFERENCES business(id),
    location_id                 UUID REFERENCES location(id),
    period_ending               DATE NOT NULL,
    -- Required review sections
    problems_recurring          TEXT,                           -- issues occurring 3+ times in the period
    customer_complaints         TEXT,
    new_staff_added             BOOLEAN NOT NULL DEFAULT FALSE,
    new_staff_notes             TEXT,                           -- names, roles, training status
    menu_changes                TEXT,                           -- new dishes, ingredients, methods
    supplier_changes            TEXT,                           -- new, changed, or removed suppliers
    equipment_changes           TEXT,                           -- new, repaired, or decommissioned equipment
    -- FCP update flags
    fcp_updated                 BOOLEAN NOT NULL DEFAULT FALSE,
    council_approval_needed     BOOLEAN NOT NULL DEFAULT FALSE,
    council_notes               TEXT,                           -- what needs approval and why
    reviewed_by                 TEXT NOT NULL,                  -- mediawiki_username
    created_at                  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (business_id, period_ending)
);

COMMENT ON TABLE four_week_review IS 'Mandatory 4-weekly (13×/year) FCP review. Covers recurring problems, changes to staff/menu/suppliers/equipment, and FCP update requirements.';
COMMENT ON COLUMN four_week_review.period_ending IS 'Last day of the 4-week review period. UNIQUE per business.';
COMMENT ON COLUMN four_week_review.council_approval_needed IS 'Set TRUE if changes require council notification or FCP amendment approval.';
COMMENT ON COLUMN four_week_review.reviewed_by IS 'MediaWiki username of the manager completing the review.';

CREATE INDEX idx_four_week_location          ON four_week_review(location_id, period_ending DESC);
CREATE INDEX idx_four_week_council           ON four_week_review(business_id)
                                                WHERE council_approval_needed = TRUE;


-- =============================================================
-- THERMOMETER CALIBRATION
-- =============================================================

CREATE TABLE thermometer_calibration (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    equipment_id            UUID REFERENCES equipment(id),      -- NULL if handheld probe (not registered equipment)
    thermometer_description TEXT NOT NULL,                      -- e.g. "Blue probe thermometer", "Digital instant-read"
    calibration_date        DATE NOT NULL DEFAULT CURRENT_DATE,
    -- Ice slurry test: should read 0°C ± 1°C
    ice_slurry_reading_c    NUMERIC(4,1),
    -- Boiling water test: should read ~99.7°C at sea level (NZ)
    boiling_reading_c       NUMERIC(5,1),
    passed                  BOOLEAN NOT NULL,
    calibrated_by           TEXT NOT NULL,                      -- mediawiki_username
    next_due_date           DATE,                               -- typically 3 months (quarterly)
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE thermometer_calibration IS 'Quarterly thermometer calibration records per FCP. Ice slurry method (0°C ± 1°C) and/or boiling water method (~99.7°C at NZ sea level).';
COMMENT ON COLUMN thermometer_calibration.equipment_id IS 'NULL for handheld probes not in the equipment registry.';
COMMENT ON COLUMN thermometer_calibration.ice_slurry_reading_c IS 'Expected: 0°C ± 1°C. Both test methods are optional but at least one should be recorded.';
COMMENT ON COLUMN thermometer_calibration.boiling_reading_c IS 'Expected: ~99.7°C at sea level in New Zealand.';
COMMENT ON COLUMN thermometer_calibration.next_due_date IS 'Typically 3 months from calibration_date. Used to track overdue calibrations.';
COMMENT ON COLUMN thermometer_calibration.calibrated_by IS 'MediaWiki username of the staff member performing the calibration.';

CREATE INDEX idx_thermo_calib_business       ON thermometer_calibration(business_id, calibration_date DESC);
CREATE INDEX idx_thermo_calib_due            ON thermometer_calibration(business_id, next_due_date ASC)
                                                WHERE next_due_date IS NOT NULL;
CREATE INDEX idx_thermo_calib_failed         ON thermometer_calibration(business_id, calibration_date DESC)
                                                WHERE passed = FALSE;
