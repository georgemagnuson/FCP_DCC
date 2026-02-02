-- =====================================================================
-- Update Daily_Records Page - Add Employee Directory Link
-- Date: 2026-02-02
-- Purpose: Add Employee_Directory link to Daily_Records page
-- =====================================================================

BEGIN;

-- Get the current content and add Employee Directory section
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (370, '= Daily Records =

This page provides quick access to all daily data entry forms. Staff use these forms to record daily operational checks, temperatures, and procedures.

== Staff & Accountability ==

Before entering any records, ensure all staff are registered in the employee directory:

* [[Employee_Directory|Employee Directory]] - Manage staff members and track accountability
* [[Employee_Directory/Training|Training Status]] - Verify food safety training completion
* [[Employee_Directory/Permissions|User Permissions]] - Assign MediaWiki access levels

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
[[Category:Daily_Records]]

== Equipment Temperature Monitoring ==

Before recording temperatures, ensure all equipment is registered via [[Equipment_Registry]].

* [[Form:Equipment_Registry|Register New Equipment]] - Add new temperature control equipment
* [[Form:Temperature_Recording|Record Daily Temperatures]] - Log morning and evening readings
* [[Equipment|View All Equipment Units]] - See registered equipment inventory

For equipment-specific guidance, see: [[Food_Control_Diary_Equipment_Integration]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (370, 3800, '', 1, 'tt:370');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1151, 230, 1, 1, NOW(), 0, 0, 3800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1151, 1, 370, 1151);

-- Update page stats
UPDATE mediawiki.page SET page_latest = 1151, page_touched = NOW(), page_len = 3800 WHERE page_id = 230;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Updated page: Daily_Records (page 230)
-- New revision: 1151
-- Changes: Added "Staff & Accountability" section with Employee_Directory links
--
-- Links added:
-- - Employee_Directory (main hub)
-- - Employee_Directory/Training (training status)
-- - Employee_Directory/Permissions (user access)
--
-- Next steps:
-- 1. ssh 192.168.2.10
-- 2. php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Navigate to: http://192.168.1.18/mediawiki/index.php/Daily_Records
-- 4. Verify new section appears at top
-- =====================================================================
