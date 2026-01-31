-- Record Management Pages Creation
-- Creates 4 Record Management Pages (Daily, Weekly, Monthly, Incident Records)
-- Organizes all 38 forms (30 existing + 8 Diary) for easy access

BEGIN;

-- ============================================================================
-- PAGE 1: Daily_Records (16 forms)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (348, '= Daily Records =

This page provides quick access to all daily data entry forms. Staff use these forms to record daily operational checks, temperatures, and procedures.

== Daily Operations ==

=== Orange Section (4 forms) ===

* [[Form:HotHoldingTemperatureLog|Hot Holding Temperature Log]] - Track temperature maintenance for hot-held foods during service
* [[Form:FoodTransportLog|Food Transport Log]] - Record temperatures and timing for transported food items
* [[Form:LiveShellfishDisplayLog|Live Shellfish Display Log]] - Monitor temperature, salinity, and condition of live shellfish displays
* [[Form:SelfServiceDisplayChecklist|Self-Service Display Checklist]] - Daily verification of self-service food display safety

=== End-of-Day Procedures ===

=== Purple Section (4 forms) ===

* [[Form:End_of_Day_Stock_Control|End of Day Stock Control]] - Daily inventory tracking and disposal of expired/damaged items
* [[Form:Daily_Cleaning_Sanitising_Log|Daily Cleaning & Sanitising Log]] - Record daily cleaning and sanitisation activities
* [[Form:Waste_Rubbish_Management|Waste & Rubbish Management]] - Track waste generation, disposal method, and contractor
* [[Form:Premises_Condition_Inspection|Premises Condition Inspection]] - Daily facility inspection (pests, structure, cleanliness, ventilation, water)

=== Specialist Foods ===

=== Teal Section (5 forms) ===

* [[Form:Sushi_pH_Record|Sushi pH Record]] - Record pH measurements, cooling methods, and storage for sushi rice
* [[Form:Roast_Duck_Temperature_Log|Roast Duck Temperature Log]] - Track internal temperature during drying (must not exceed 25°C)
* [[Form:Doner_Kebab_Cooking_Log|Doner Kebab Cooking Log]] - Document cooking times and temperature verification (75°C minimum)
* [[Form:Sous_Vide_Cooking_Log|Sous Vide Cooking Log]] - Record vacuum seal verification, water bath calibration, time/temp combinations
* [[Form:Raw_Meat_Decontamination_Log|Raw Meat Decontamination Log]] - Track surface decontamination method, 48-hour use limit

=== Official MPI Diary Forms (3 forms) ===

* [[Form:Opening_Check_Form|Opening Check Form]] - Document facility readiness at start of business (staff fitness, cleanliness, hand washing)
* [[Form:Closing_Check_Form|Closing Check Form]] - Document end-of-day compliance (contamination prevention, temperature, cleaning, waste)
* [[Form:Temperature_Recording_Form|Temperature Recording Form]] - Daily equipment temperature monitoring (morning and evening)

[[Category:Food Control Records]]
[[Category:Daily_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (348, 2094, '', 1, 'tt:348');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1124, 230, 1, 1, NOW(), 0, 0, 2094, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1124, 1, 348, 1124);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (230, 0, 'Daily_Records', 0, 1, RANDOM(), NOW(), 1124, 2094);

-- ============================================================================
-- PAGE 2: Weekly_Records (9 forms)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (349, '= Weekly Records =

This page provides access to weekly maintenance, monitoring, and compliance forms. These forms document weekly checks, maintenance schedules, and periodic reviews.

== Weekly Maintenance ==

=== Purple Section (4 forms) ===

* [[Form:Equipment_Maintenance_Log|Equipment Maintenance Log]] - Document equipment maintenance, repairs, and issues
* [[Form:Calibration_Record|Calibration Record]] - Track calibration of thermometers, scales, pH meters, temperature loggers
* [[Form:Water_System_Maintenance|Water System Maintenance]] - Maintenance logs for water tanks, pipes, filters, connections
* [[Form:Roof_Water_Supply_Checklist|Roof Water Supply Checklist]] - Inspection of roof-collected water systems (condition, testing, treatment)

=== Periodic Reviews ===

=== Orange Section (2 forms) ===

* [[Form:IngredientAllergenRegister|Ingredient and Allergen Register]] - Track ingredients, allergens, and food additives in stock
* [[Form:FoodLabelSpecifications|Food Label Specifications]] - Verify product labels have all required elements

=== Specialist Foods ===

=== Teal Section (1 form) ===

* [[Form:Biltong_Production_Record|Biltong Production Record]] - Monitor marinade (salt/vinegar), drying conditions, final water activity (<0.85)

=== Official MPI Diary Forms (2 forms) ===

* [[Form:Weekly_Checklist_Form|Weekly Checklist Form]] - Summary of weekly compliance (cleaning, maintenance, pest activity, manager signature)
* [[Form:Poultry_Meat_Cooking_Verification|Poultry/Meat Cooking Verification]] - Document high-risk cooking procedures (poultry, meat temperature verification)

[[Category:Food Control Records]]
[[Category:Weekly_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (349, 1769, '', 1, 'tt:349');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1125, 231, 1, 1, NOW(), 0, 0, 1769, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1125, 1, 349, 1125);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (231, 0, 'Weekly_Records', 0, 1, RANDOM(), NOW(), 1125, 1769);

-- ============================================================================
-- PAGE 3: Monthly_Records (4 forms)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (350, '= Monthly Records =

This page provides access to monthly archival, compliance, and review forms. These forms document monthly transactions, audits, and management reviews required for regulatory compliance.

== Transaction Records ==

=== Orange Section (1 form) ===

* [[Form:B2BCustomerSupplyRegister|B2B Customer and Supply Register]] - Document wholesale food supply transactions

== Periodic Audits ==

=== Purple Section (1 form) ===

* [[Form:Maintenance_Chemical_Safety|Maintenance Chemical Safety]] - Audit of chemical storage, labelling, SDS availability, staff training

== Monthly Management Review ==

=== Official MPI Diary Forms (3 forms) ===

* [[Form:Four_Week_Review_Form|Four-Week Review Form]] - Management review of previous 4 weeks (recurring problems, corrective actions, business changes, staff training, Food Control Plan updates)
* [[Form:Equipment_Registry|Equipment Registry]] - Inventory of temperature control equipment (unit number, type, location, purpose, installation date)
* [[Form:Thermometer_Calibration_Record|Thermometer Calibration Record]] - Temperature measurement accuracy verification (calibration date, ice/boiling point readings, next calibration due)

[[Category:Food Control Records]]
[[Category:Monthly_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (350, 1471, '', 1, 'tt:350');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1126, 232, 1, 1, NOW(), 0, 0, 1471, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1126, 1, 350, 1126);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (232, 0, 'Monthly_Records', 0, 1, RANDOM(), NOW(), 1126, 1471);

-- ============================================================================
-- PAGE 4: Incident_Records (8 forms)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (351, '= Incident Records =

This page provides access to incident investigation and resolution forms. These forms are used when problems occur, customer complaints are received, or food safety issues need to be documented and resolved.

== Problem Documentation ==

=== Red Section (8 forms) ===

* [[Form:Incident_Report|Incident Report]] - Document operational incidents with severity classification
* [[Form:Complaint_Log|Complaint Log]] - Record customer complaints with investigation status and resolution
* [[Form:Food_Traceability_Record|Food Traceability Record]] - Trace products from supplier through storage, use, to distribution
* [[Form:Recall_Notification|Recall Notification]] - Document product recalls with quantity tracking
* [[Form:Corrective_Action_Plan|Corrective Action Plan]] - Link issues to root causes and corrective actions with timelines
* [[Form:Regulatory_Report|Regulatory Report]] - Track notifications to regulatory bodies (MPI, Council, Health, WorkSafe)
* [[Form:Root_Cause_Analysis|Root Cause Analysis]] - Systematic analysis of incidents using methods like 5 Whys
* [[Form:Investigation_Log|Investigation Log]] - Track incident investigations with findings and evidence

[[Category:Food Control Records]]
[[Category:Incident_Records]]
[[Category:Red:Troubleshooting]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (351, 1597, '', 1, 'tt:351');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1127, 233, 1, 1, NOW(), 0, 0, 1597, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1127, 1, 351, 1127);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (233, 0, 'Incident_Records', 0, 1, RANDOM(), NOW(), 1127, 1597);

COMMIT;

-- ============================================================================
-- SUMMARY
-- ============================================================================
-- Created 4 Record Management Pages:
-- 1. Daily_Records (page_id: 230) - 16 forms
-- 2. Weekly_Records (page_id: 231) - 9 forms
-- 3. Monthly_Records (page_id: 232) - 4 forms
-- 4. Incident_Records (page_id: 233) - 8 forms
-- Total: 37 form links across 4 pages
--
-- Sequences used:
-- old_id: 348-351 (4 pages)
-- rev_id: 1124-1127 (4 revisions)
-- page_id: 230-233 (4 pages)
