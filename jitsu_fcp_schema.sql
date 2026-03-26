-- =============================================================
-- jitsu_fcp database schema
-- Food Control Plan operational records
-- Created: 2026-03-24
-- =============================================================

-- =============================================================
-- REGISTRY TABLES
-- =============================================================

CREATE TABLE business (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                    TEXT NOT NULL,
    trading_name            TEXT,
    address                 TEXT,
    city                    TEXT,
    country                 TEXT NOT NULL DEFAULT 'New Zealand',
    phone                   TEXT,
    email                   TEXT,
    food_registration_number TEXT,          -- MPI / council registration
    fcp_version             TEXT,
    fcp_effective_date      DATE,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE business IS 'Top-level business entity. One business may have multiple locations.';
COMMENT ON COLUMN business.food_registration_number IS 'MPI or local council food registration number.';


CREATE TABLE location (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    name                    TEXT NOT NULL,  -- e.g. "TheJitsu Ponsonby"
    address                 TEXT,
    city                    TEXT,
    phone                   TEXT,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE location IS 'Physical location belonging to a business. All operational records trace to a location.';


CREATE TABLE employee (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    location_id             UUID REFERENCES location(id),       -- primary location
    mediawiki_username      TEXT,                               -- links to MediaWiki employee page
    full_name               TEXT NOT NULL,
    role                    TEXT,
    food_handler_cert_number TEXT,
    cert_expiry             DATE,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE employee IS 'Employee reference table. MediaWiki is source of truth; this table enables FK joins on operational records.';
COMMENT ON COLUMN employee.mediawiki_username IS 'Matches MediaWiki username for cross-system identity.';


CREATE TABLE supplier (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id             UUID NOT NULL REFERENCES business(id),
    name                    TEXT NOT NULL,
    trading_name            TEXT,
    contact_person          TEXT,
    address                 TEXT,
    phone                   TEXT,
    email                   TEXT,
    products_supplied       TEXT,
    is_temperature_sensitive BOOLEAN NOT NULL DEFAULT FALSE,    -- drives temp check on delivery
    food_safety_cert        TEXT,                               -- MPI reg, HACCP cert number, etc.
    risk_level              TEXT NOT NULL DEFAULT 'medium'
                                CHECK (risk_level IN ('low', 'medium', 'high')),
    is_approved             BOOLEAN NOT NULL DEFAULT FALSE,
    approval_date           DATE,
    review_date             DATE,                               -- FCP requires periodic review
    notes                   TEXT,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE supplier IS 'Approved supplier register as required by FCP. Includes food safety certification and risk level.';
COMMENT ON COLUMN supplier.review_date IS 'Next scheduled supplier review date as required by FCP.';


CREATE TABLE equipment_category (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name                    TEXT NOT NULL UNIQUE,               -- Refrigeration, Freezer, Cooking, etc.
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE equipment_category IS 'Equipment type categories (Refrigeration, Cooking, Dishwashing, etc.).';


CREATE TABLE equipment (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    location_id             UUID NOT NULL REFERENCES location(id),
    category_id             UUID NOT NULL REFERENCES equipment_category(id),
    name                    TEXT NOT NULL,                      -- "Walk-in Fridge", "Prep Fridge 1"
    make                    TEXT,
    model                   TEXT,
    serial_number           TEXT,
    purchase_date           DATE,
    min_safe_temp           NUMERIC(4,1),                       -- lower bound of safe range
    max_safe_temp           NUMERIC(4,1),                       -- upper bound; API flags breach on insert
    check_frequency_minutes INT,                                -- 60 = hourly; NULL = no schedule
    notes                   TEXT,
    is_active               BOOLEAN NOT NULL DEFAULT TRUE,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE equipment IS 'Equipment registry. min/max_safe_temp defines acceptable range; API auto-calculates in_range on temperature_log inserts.';
COMMENT ON COLUMN equipment.check_frequency_minutes IS 'Expected monitoring frequency in minutes. Used by API to detect missed checks.';


-- =============================================================
-- TEMPERATURE RECORDS
-- =============================================================

CREATE TABLE temperature_log (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipment_id            UUID NOT NULL REFERENCES equipment(id),
    recorded_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    temp_celsius            NUMERIC(4,1) NOT NULL,
    in_range                BOOLEAN,                            -- API calculates against equipment min/max on insert
    source                  TEXT NOT NULL DEFAULT 'manual'
                                CHECK (source IN ('manual', 'sensor', 'automated')),
    sensor_id               TEXT,                               -- NULL now; populated when sensors deployed
    recorded_by             UUID REFERENCES employee(id),       -- NULL if automated
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE temperature_log IS 'Time-series temperature readings per equipment unit. in_range calculated by API on insert.';
COMMENT ON COLUMN temperature_log.sensor_id IS 'Future use: identifier of the physical sensor that submitted this reading.';


-- =============================================================
-- FOOD COOLING
-- =============================================================
-- NZ FCP requirement (S39-00005):
--   Clock starts when food reaches 60°C
--   Stage 1: 60°C → ≤21°C in < 2 hours
--   Stage 2: 21°C → ≤5°C in < 4 hours
--   Total:   6 hours maximum

CREATE TABLE food_cooling_event (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    location_id             UUID NOT NULL REFERENCES location(id),
    food_description        TEXT NOT NULL,                      -- "Beef stock", "Chicken curry"
    batch_reference         TEXT,                               -- kitchen batch/lot number
    quantity_kg             NUMERIC(6,2),
    cooked_at               TIMESTAMPTZ NOT NULL,               -- when cooking finished
    cooling_methods         TEXT[],                             -- ['ice_bath','shallow_containers',
                                                                --  'blast_chiller','smaller_portions',
                                                                --  'cooling_racks']
    -- Clock management (API-managed)
    clock_start_temp        NUMERIC(4,1) NOT NULL DEFAULT 60.0, -- temp at which timing begins
    clock_started_at        TIMESTAMPTZ,                        -- set by API when first reading ≤ clock_start_temp
    -- Stage targets (defaults from NZ FCP; can be stricter per business)
    target_stage1_temp      NUMERIC(4,1) NOT NULL DEFAULT 21.0,
    target_stage1_minutes   INT NOT NULL DEFAULT 120,           -- 2 hours
    target_stage2_temp      NUMERIC(4,1) NOT NULL DEFAULT 5.0,
    target_stage2_minutes   INT NOT NULL DEFAULT 240,           -- 4 hours
    -- Stage completion (API-managed)
    stage1_completed_at     TIMESTAMPTZ,                        -- when reading ≤ target_stage1_temp
    stage2_completed_at     TIMESTAMPTZ,                        -- when reading ≤ target_stage2_temp
    stage1_compliant        BOOLEAN,                            -- NULL until stage 1 completes
    stage2_compliant        BOOLEAN,                            -- NULL until stage 2 completes
    overall_compliant       BOOLEAN,                            -- NULL until event closes
    -- Proven method
    is_proven_method        BOOLEAN NOT NULL DEFAULT FALSE,     -- pre-approved method (3-batch tested)
    proven_method_ref       TEXT,                               -- reference to the approved method record
    -- Lifecycle
    opened_by               UUID NOT NULL REFERENCES employee(id),
    closed_by               UUID REFERENCES employee(id),
    closed_at               TIMESTAMPTZ,                        -- NULL = event still active
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE food_cooling_event IS 'One record per cooling batch. Clock starts when food hits clock_start_temp (default 60°C). API manages stage transitions and compliance flags.';
COMMENT ON COLUMN food_cooling_event.cooling_methods IS 'Array of methods used: ice_bath, shallow_containers, blast_chiller, smaller_portions, cooling_racks.';
COMMENT ON COLUMN food_cooling_event.is_proven_method IS 'If TRUE, only one weekly check required per FCP proven method provision.';


CREATE TABLE food_cooling_reading (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_id                UUID NOT NULL REFERENCES food_cooling_event(id),
    recorded_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    minutes_elapsed         INT,                                -- API calculates: recorded_at - clock_started_at
    temp_celsius            NUMERIC(4,1) NOT NULL,
    stage                   INT CHECK (stage IN (0, 1, 2)),     -- 0=pre-clock, 1=60→21°C, 2=21→5°C
    recorded_by             UUID REFERENCES employee(id),       -- NULL if automated
    source                  TEXT NOT NULL DEFAULT 'manual'
                                CHECK (source IN ('manual', 'sensor', 'automated')),
    sensor_id               TEXT,
    notes                   TEXT,                               -- "moved to blast chiller", "stirred batch"
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE food_cooling_reading IS 'Individual temperature readings within a cooling event. Recommended every 30 minutes. API sets stage and minutes_elapsed.';


-- =============================================================
-- INCIDENT & CORRECTIVE ACTION
-- =============================================================

CREATE TABLE incident_report (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    location_id             UUID NOT NULL REFERENCES location(id),
    reported_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    reported_by             UUID NOT NULL REFERENCES employee(id),
    incident_type           TEXT NOT NULL CHECK (incident_type IN (
                                'temperature_breach', 'cooling_failure',
                                'equipment_failure', 'maintenance_issue',
                                'delivery_rejection', 'accident',
                                'contamination', 'pest', 'other'
                            )),
    severity                TEXT NOT NULL DEFAULT 'medium'
                                CHECK (severity IN ('low', 'medium', 'high', 'critical')),
    description             TEXT NOT NULL,
    -- Polymorphic trigger reference: what caused this incident?
    trigger_table           TEXT CHECK (trigger_table IN (
                                'temperature_log', 'food_cooling_event',
                                'maintenance_log', 'delivery_check', 'cleaning_log'
                            )),
    trigger_id              UUID,                               -- UUID of the triggering record
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE incident_report IS 'Records any incident requiring corrective action. Polymorphic trigger_table/trigger_id links to the source record (temperature breach, cooling failure, etc.).';
COMMENT ON COLUMN incident_report.trigger_table IS 'Name of the table that triggered this incident. NULL for manually reported incidents.';
COMMENT ON COLUMN incident_report.trigger_id IS 'UUID of the specific record that triggered this incident.';


CREATE TABLE corrective_action (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    incident_report_id      UUID NOT NULL REFERENCES incident_report(id),
    action_taken            TEXT NOT NULL,
    actioned_by             UUID NOT NULL REFERENCES employee(id),
    actioned_at             TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    outcome                 TEXT,
    follow_up_required      BOOLEAN NOT NULL DEFAULT FALSE,
    follow_up_notes         TEXT,
    closed_at               TIMESTAMPTZ,                        -- NULL = action still open
    closed_by               UUID REFERENCES employee(id),
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE corrective_action IS 'Documents how an incident was resolved. An incident may have multiple corrective actions.';


-- =============================================================
-- OPERATIONAL LOGS
-- =============================================================

CREATE TABLE cleaning_log (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    location_id             UUID NOT NULL REFERENCES location(id),
    equipment_id            UUID REFERENCES equipment(id),      -- NULL if area-based cleaning
    area                    TEXT,                               -- "Prep bench", "Cool room floor"
    task                    TEXT NOT NULL,
    performed_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    performed_by            UUID NOT NULL REFERENCES employee(id),
    product_used            TEXT,
    method                  TEXT,
    verified_by             UUID REFERENCES employee(id),       -- supervisor sign-off
    source                  TEXT NOT NULL DEFAULT 'manual'
                                CHECK (source IN ('manual', 'automated')),
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE cleaning_log IS 'Cleaning and sanitising records. Covers both equipment-specific and area-based tasks.';


CREATE TABLE maintenance_log (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    equipment_id            UUID NOT NULL REFERENCES equipment(id),
    task_description        TEXT NOT NULL,
    performed_at            TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    performed_by_employee   UUID REFERENCES employee(id),       -- NULL if external contractor
    contractor_name         TEXT,                               -- NULL if internal staff
    next_due_date           DATE,
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE maintenance_log IS 'Equipment maintenance records. Either internal staff or external contractor; at least one must be populated.';


CREATE TABLE delivery_check (
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    location_id             UUID NOT NULL REFERENCES location(id),
    supplier_id             UUID NOT NULL REFERENCES supplier(id),
    delivery_date           TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    product_description     TEXT NOT NULL,
    quantity                TEXT,
    use_by_date             DATE,
    temp_on_arrival         NUMERIC(4,1),                       -- NULL if not temperature-sensitive
    packaging_intact        BOOLEAN,
    appearance_ok           BOOLEAN,
    accepted                BOOLEAN NOT NULL,
    rejection_reason        TEXT,                               -- required if accepted = FALSE
    checked_by              UUID NOT NULL REFERENCES employee(id),
    notes                   TEXT,
    created_at              TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

COMMENT ON TABLE delivery_check IS 'Delivery acceptance records per FCP. Links to supplier register. temp_on_arrival required when supplier.is_temperature_sensitive = TRUE.';


-- =============================================================
-- INDEXES
-- =============================================================

-- location
CREATE INDEX idx_location_business          ON location(business_id);

-- employee
CREATE INDEX idx_employee_business          ON employee(business_id);
CREATE INDEX idx_employee_location          ON employee(location_id);
CREATE INDEX idx_employee_mediawiki         ON employee(mediawiki_username);

-- supplier
CREATE INDEX idx_supplier_business          ON supplier(business_id);
CREATE INDEX idx_supplier_review_due        ON supplier(review_date) WHERE is_active = TRUE;

-- equipment
CREATE INDEX idx_equipment_location         ON equipment(location_id);
CREATE INDEX idx_equipment_active           ON equipment(location_id) WHERE is_active = TRUE;

-- temperature_log — primary query patterns: by equipment over time, out-of-range alerts
CREATE INDEX idx_temp_log_equipment_time    ON temperature_log(equipment_id, recorded_at DESC);
CREATE INDEX idx_temp_log_out_of_range      ON temperature_log(equipment_id, recorded_at DESC)
                                                WHERE in_range = FALSE;
CREATE INDEX idx_temp_log_recorded_by       ON temperature_log(recorded_by);

-- food_cooling_event — open events and location history
CREATE INDEX idx_cooling_event_location     ON food_cooling_event(location_id, cooked_at DESC);
CREATE INDEX idx_cooling_event_open         ON food_cooling_event(location_id)
                                                WHERE closed_at IS NULL;
CREATE INDEX idx_cooling_event_noncompliant ON food_cooling_event(location_id)
                                                WHERE overall_compliant = FALSE;

-- food_cooling_reading — always queried in event order
CREATE INDEX idx_cooling_reading_event      ON food_cooling_reading(event_id, recorded_at ASC);

-- incident_report — open incidents, by location, by trigger
CREATE INDEX idx_incident_location_time     ON incident_report(location_id, reported_at DESC);
CREATE INDEX idx_incident_trigger           ON incident_report(trigger_table, trigger_id);
CREATE INDEX idx_incident_open              ON incident_report(location_id)
                                                WHERE updated_at = created_at;  -- no corrective action yet

-- corrective_action — open actions
CREATE INDEX idx_corrective_incident        ON corrective_action(incident_report_id);
CREATE INDEX idx_corrective_open            ON corrective_action(incident_report_id)
                                                WHERE closed_at IS NULL;

-- cleaning_log
CREATE INDEX idx_cleaning_location_time     ON cleaning_log(location_id, performed_at DESC);
CREATE INDEX idx_cleaning_equipment_time    ON cleaning_log(equipment_id, performed_at DESC);

-- maintenance_log — recent maintenance and upcoming due dates
CREATE INDEX idx_maintenance_equipment_time ON maintenance_log(equipment_id, performed_at DESC);
CREATE INDEX idx_maintenance_due            ON maintenance_log(equipment_id, next_due_date ASC);

-- delivery_check
CREATE INDEX idx_delivery_location_time     ON delivery_check(location_id, delivery_date DESC);
CREATE INDEX idx_delivery_supplier_time     ON delivery_check(supplier_id, delivery_date DESC);
CREATE INDEX idx_delivery_rejected          ON delivery_check(location_id, delivery_date DESC)
                                                WHERE accepted = FALSE;
