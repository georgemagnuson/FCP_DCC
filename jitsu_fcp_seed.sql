-- =============================================================
-- jitsu_fcp seed data
-- Extracted from MediaWiki pages 2026-03-24
-- =============================================================

-- =============================================================
-- BUSINESS
-- Source: Business:The_Jitsu/Details (page 10100)
-- =============================================================

INSERT INTO business (
    id, name, trading_name, address, city, country,
    phone, email, food_registration_number,
    fcp_version, fcp_effective_date
) VALUES (
    'a1000000-0000-0000-0000-000000000001',
    'The Jitsu Ltd.',
    'The Jitsu',
    '133 Stuart Street',
    'Dunedin',
    'New Zealand',
    '+6434701155',
    'info@thejitsu.com',
    NULL,                           -- registration number not yet recorded in MW
    'S39-00006',
    '2026-08-11'                    -- based on MPI PDF metadata (dmsdocument 16684); no separate regulatory notice date confirmed
);


-- =============================================================
-- LOCATION
-- Source: Business:The_Jitsu/Details — site_1_street_address
-- =============================================================

INSERT INTO location (
    id, business_id, name, address, city, phone
) VALUES (
    'b1000000-0000-0000-0000-000000000001',
    'a1000000-0000-0000-0000-000000000001',
    'The Jitsu — Stuart Street',
    '133 Stuart Street',
    'Dunedin',
    '+6434701155'
);


-- =============================================================
-- EQUIPMENT CATEGORIES
-- Source: Equipment pages in namespace 100
-- =============================================================

INSERT INTO equipment_category (id, name) VALUES
    ('c1000000-0000-0000-0000-000000000001', 'Refrigeration'),
    ('c1000000-0000-0000-0000-000000000002', 'Freezer'),
    ('c1000000-0000-0000-0000-000000000003', 'Hot Holding'),
    ('c1000000-0000-0000-0000-000000000004', 'Cooking'),
    ('c1000000-0000-0000-0000-000000000005', 'Dishwashing'),
    ('c1000000-0000-0000-0000-000000000006', 'Display — Refrigerated');


-- =============================================================
-- EQUIPMENT
-- Source: Equipment pages (namespace 100, page_ids 322-325)
--
-- FRIDGE-01:  Refrigerator      — Cold holding (0–4°C)
-- FREEZER-01: Freezer           — Frozen storage (-18°C or below)
-- HOTBOX-01:  Hot Holding       — Hot holding (65°C or above)
-- DISPLAY-01: Refrigerated Display — Cold display of RTE food (0–4°C)
--
-- Safe ranges based on NZ FCP temperature requirements:
--   Refrigeration:  0°C to 4°C (max_safe_temp = 4.0)
--   Freezer:       -25°C to -18°C
--   Hot holding:    65°C to 80°C (no practical upper limit for food safety)
--
-- check_frequency_minutes = 720 (twice daily: morning + evening)
-- =============================================================

INSERT INTO equipment (
    id, location_id, category_id, name,
    min_safe_temp, max_safe_temp, check_frequency_minutes, notes
) VALUES
    (
        'd1000000-0000-0000-0000-000000000001',
        'b1000000-0000-0000-0000-000000000001',
        'c1000000-0000-0000-0000-000000000001',
        'FRIDGE-01 — Main Refrigerator',
        0.0, 4.0, 720,
        'Cold holding. Target: 0–4°C. Source: Equipment:FRIDGE-01 (MW page 322)'
    ),
    (
        'd1000000-0000-0000-0000-000000000002',
        'b1000000-0000-0000-0000-000000000001',
        'c1000000-0000-0000-0000-000000000002',
        'FREEZER-01 — Main Freezer',
        -25.0, -18.0, 720,
        'Frozen food storage. Target: -18°C or below. Source: Equipment:FREEZER-01 (MW page 323)'
    ),
    (
        'd1000000-0000-0000-0000-000000000003',
        'b1000000-0000-0000-0000-000000000001',
        'c1000000-0000-0000-0000-000000000003',
        'HOTBOX-01 — Hot Holding Cabinet',
        65.0, NULL, 720,
        'Hot holding. Minimum: 65°C. No upper limit. Source: Equipment:HOTBOX-01 (MW page 324)'
    ),
    (
        'd1000000-0000-0000-0000-000000000004',
        'b1000000-0000-0000-0000-000000000001',
        'c1000000-0000-0000-0000-000000000006',
        'DISPLAY-01 — Refrigerated Display Case',
        0.0, 4.0, 720,
        'Cold display of ready-to-eat food. Target: 0–4°C. Source: Equipment:DISPLAY-01 (MW page 325)'
    );


-- =============================================================
-- EMPLOYEES
-- Source: JITSU_EMPLOYEES namespace (ns=3006) pages
--
-- Carlos_Chef:   Chef / Kitchen Staff    — no MW username recorded
-- Gaby_Magnuson: Waitstaff               — mediawiki_username=gabymagnuson
-- Sarah_Manager: Manager / Front-of-House — no MW username in page
-- Tom_Waiter:    Waiter                  — no MW username in page
--
-- MW usernames for missing staff to be confirmed and updated later.
-- =============================================================

INSERT INTO employee (
    id, business_id, location_id,
    mediawiki_username, full_name, role
) VALUES
    (
        'e1000000-0000-0000-0000-000000000001',
        'a1000000-0000-0000-0000-000000000001',
        'b1000000-0000-0000-0000-000000000001',
        NULL,                               -- MW username not recorded in page
        'Carlos Chef',
        'Chef / Kitchen Staff'
    ),
    (
        'e1000000-0000-0000-0000-000000000002',
        'a1000000-0000-0000-0000-000000000001',
        'b1000000-0000-0000-0000-000000000001',
        'gabymagnuson',
        'Gabrielle Magnuson',
        'Waitstaff'
    ),
    (
        'e1000000-0000-0000-0000-000000000003',
        'a1000000-0000-0000-0000-000000000001',
        'b1000000-0000-0000-0000-000000000001',
        NULL,                               -- MW username not recorded in page
        'Sarah Manager',
        'Manager / Front-of-House'
    ),
    (
        'e1000000-0000-0000-0000-000000000004',
        'a1000000-0000-0000-0000-000000000001',
        'b1000000-0000-0000-0000-000000000001',
        NULL,                               -- MW username not recorded in page
        'Tom Waiter',
        'Waiter'
    );


-- =============================================================
-- VERIFICATION QUERIES
-- Run these after seeding to confirm data looks correct
-- =============================================================

SELECT 'business'          AS tbl, COUNT(*) FROM business;
SELECT 'location'          AS tbl, COUNT(*) FROM location;
SELECT 'equipment_category' AS tbl, COUNT(*) FROM equipment_category;
SELECT 'equipment'         AS tbl, COUNT(*) FROM equipment;
SELECT 'employee'          AS tbl, COUNT(*) FROM employee;
