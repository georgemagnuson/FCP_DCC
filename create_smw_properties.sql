-- Phase 2: Create 12 SMW (Semantic MediaWiki) Properties
-- These properties enable semantic queries for the Records Archive (Phase 3)
-- Page IDs: 301-312 (Property namespace = 102)
-- Text IDs: 401-412
-- Revision IDs: 1201-1212

BEGIN;

-- ============================================================================
-- PROPERTY 1: Has_submission_date
-- ============================================================================
-- Stores the date when a food control form was submitted
-- Type: Date
-- Used in: ALL 30 templates

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (401, '[[Has type::Date]]

This property stores the date when a food control form was submitted to the system.

== Usage ==
Use this property to record the submission date of any food safety form:
<nowiki>[[Has_submission_date::2026-01-30]]</nowiki>

== Format ==
Dates should be in ISO 8601 format: YYYY-MM-DD

== Used In ==
All 30 food control form templates (daily, weekly, monthly, and incident reporting)

[[Category:Form Properties]]
[[Category:Core Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (401, 380, '', 1, 'tt:401');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1201, 301, 1, 1, NOW(), 0, 0, 380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1201, 1, 401, 1201);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (301, 102, 'Property:Has submission date', 0, 1, RANDOM(), NOW(), 1201, 380);

-- ============================================================================
-- PROPERTY 2: Has_record_type
-- ============================================================================
-- Stores the type/category of food control record
-- Type: Text
-- Values: Daily Temperature Monitoring, Weekly Inspection, Monthly Audit, Incident Report, etc.

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (402, '[[Has type::Text]]

This property stores the type or category of food safety record being documented.

== Usage ==
Identifies the broad category of the food control form:
<nowiki>[[Has_record_type::Daily Temperature Monitoring]]</nowiki>
<nowiki>[[Has_record_type::Weekly Inspection]]</nowiki>
<nowiki>[[Has_record_type::Incident Report]]</nowiki>

== Allowed Values ==
* Daily Temperature Monitoring - Temperature checks, transport logs
* Weekly Inspection - General facility checks, cleaning logs
* Monthly Audit - Stock audits, compliance reviews
* Incident Report - Problems, failures, complaints
* Specialist Procedures - Specialist food handling (sushi, roasts, etc.)
* Maintenance - Equipment maintenance and calibration
* Regulatory - Recalls, regulatory communications

== Used In ==
All 30 food control form templates

[[Category:Form Properties]]
[[Category:Classification Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (402, 580, '', 1, 'tt:402');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1202, 302, 1, 1, NOW(), 0, 0, 580, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1202, 1, 402, 1202);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (302, 102, 'Property:Has record type', 0, 1, RANDOM(), NOW(), 1202, 580);

-- ============================================================================
-- PROPERTY 3: Has_staff_name
-- ============================================================================
-- Stores the name of staff member completing the form
-- Type: Text

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (403, '[[Has type::Text]]

This property records the name of the staff member who completed and submitted the food control form.

== Usage ==
Record the staff member responsible:
<nowiki>[[Has_staff_name::John Smith]]</nowiki>
<nowiki>[[Has_staff_name::Sarah Johnson]]</nowiki>

== Purpose ==
Enables accountability and traceability of food safety records. Helps identify patterns if specific staff members have higher rates of failures or issues.

== Used In ==
All 30 food control form templates

[[Category:Form Properties]]
[[Category:Staff Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (403, 420, '', 1, 'tt:403');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1203, 303, 1, 1, NOW(), 0, 0, 420, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1203, 1, 403, 1203);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (303, 102, 'Property:Has staff name', 0, 1, RANDOM(), NOW(), 1203, 420);

-- ============================================================================
-- PROPERTY 4: Has_form_name
-- ============================================================================
-- Stores the template/form identifier
-- Type: Text

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (404, '[[Has type::Text]]

This property stores the template name that was used to create this food control record.

== Usage ==
Identifies which form template was used:
<nowiki>[[Has_form_name::HotHoldingTemperatureLog]]</nowiki>
<nowiki>[[Has_form_name::IncidentReport]]</nowiki>

== Purpose ==
Enables filtering records by form type for archive and analysis purposes. Useful for phase 3 Records Archive.

== Used In ==
All 30 food control form templates

[[Category:Form Properties]]
[[Category:Core Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (404, 400, '', 1, 'tt:404');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1204, 304, 1, 1, NOW(), 0, 0, 400, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1204, 1, 404, 1204);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (304, 102, 'Property:Has form name', 0, 1, RANDOM(), NOW(), 1204, 400);

-- ============================================================================
-- PROPERTY 5: Has_temperature
-- ============================================================================
-- Stores temperature readings in numeric format
-- Type: Number
-- Unit: Celsius (always)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (405, '[[Has type::Number]]

This property stores temperature readings from food control monitoring activities.

== Usage ==
Record temperature values:
<nowiki>[[Has_temperature::62.5]]</nowiki>
<nowiki>[[Has_temperature::-18.2]]</nowiki>

== Unit ==
All temperatures are in Celsius (°C). Use Has_temperature_unit property to document unit.

== Range ==
* Cold storage: -25 to 5°C
* Cool storage: 5 to 10°C
* Ambient: 15 to 25°C
* Hot holding: 60°C and above
* Cooking: 75°C and above

== Used In ==
9 temperature monitoring templates:
* Template:HotHoldingTemperatureLog
* Template:FoodTransportLog
* Template:LiveShellfishDisplayLog
* Template:Sushi_pH_Record (pH as number)
* Template:Roast_Duck_Temperature_Log
* Template:Doner_Kebab_Cooking_Log
* Template:Sous_Vide_Cooking_Log
* Template:Raw_Meat_Decontamination_Log
* Template:Biltong_Production_Record

[[Category:Form Properties]]
[[Category:Temperature Properties]]
[[Category:Numeric Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (405, 730, '', 1, 'tt:405');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1205, 305, 1, 1, NOW(), 0, 0, 730, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1205, 1, 405, 1205);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (305, 102, 'Property:Has temperature', 0, 1, RANDOM(), NOW(), 1205, 730);

-- ============================================================================
-- PROPERTY 6: Has_temperature_unit
-- ============================================================================
-- Documents the unit of temperature measurement
-- Type: Text
-- Always: °C for this system

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (406, '[[Has type::Text]]

This property documents the unit of temperature measurement used in the form.

== Usage ==
Always use Celsius in this system:
<nowiki>[[Has_temperature_unit::°C]]</nowiki>

== Purpose ==
Ensures clarity that all temperatures are in Celsius (not Fahrenheit or Kelvin).

== Used In ==
All temperature monitoring templates that also use Has_temperature property

[[Category:Form Properties]]
[[Category:Temperature Properties]]
[[Category:Metadata Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (406, 380, '', 1, 'tt:406');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1206, 306, 1, 1, NOW(), 0, 0, 380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1206, 1, 406, 1206);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (306, 102, 'Property:Has temperature unit', 0, 1, RANDOM(), NOW(), 1206, 380);

-- ============================================================================
-- PROPERTY 7: Has_equipment_unit
-- ============================================================================
-- Stores equipment identifier (e.g., FRIDGE-01)
-- Type: Text

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (407, '[[Has type::Text]]

This property identifies which piece of equipment was checked or monitored in the form.

== Usage ==
Record the equipment ID:
<nowiki>[[Has_equipment_unit::FRIDGE-01]]</nowiki>
<nowiki>[[Has_equipment_unit::HOTCOUNTER-A]]</nowiki>
<nowiki>[[Has_equipment_unit::FREEZER-STORAGE]]</nowiki>

== Format ==
Use facility naming convention: EQUIPMENT-LOCATION or EQUIPMENT-NUMBER

== Purpose ==
Enables tracking of temperature patterns for specific equipment, identifying equipment that may need maintenance or calibration.

== Used In ==
Temperature and equipment maintenance templates:
* Template:HotHoldingTemperatureLog
* Template:FoodTransportLog
* Template:Calibration_Record
* Template:Equipment_Maintenance_Log

[[Category:Form Properties]]
[[Category:Equipment Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (407, 600, '', 1, 'tt:407');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1207, 307, 1, 1, NOW(), 0, 0, 600, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1207, 1, 407, 1207);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (307, 102, 'Property:Has equipment unit', 0, 1, RANDOM(), NOW(), 1207, 600);

-- ============================================================================
-- PROPERTY 8: Has_food_item
-- ============================================================================
-- Stores the name of food product being handled/checked
-- Type: Text

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (408, '[[Has type::Text]]

This property records the specific food item or product being documented in the form.

== Usage ==
Record the food item name:
<nowiki>[[Has_food_item::Chicken breast fillet]]</nowiki>
<nowiki>[[Has_food_item::Roasted vegetables]]</nowiki>
<nowiki>[[Has_food_item::Live oysters]]</nowiki>

== Purpose ==
Enables tracking of specific food items through the supply chain and quality control process. Useful for identifying patterns with particular products.

== Used In ==
15 food handling and temperature monitoring templates:
* Template:HotHoldingTemperatureLog
* Template:FoodTransportLog
* Template:LiveShellfishDisplayLog
* Template:SelfServiceDisplayChecklist
* Template:Sushi_pH_Record
* Template:Roast_Duck_Temperature_Log
* Template:Doner_Kebab_Cooking_Log
* Template:Sous_Vide_Cooking_Log
* Template:Raw_Meat_Decontamination_Log
* Template:Biltong_Production_Record
* Plus additional food handling templates

[[Category:Form Properties]]
[[Category:Food Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (408, 680, '', 1, 'tt:408');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1208, 308, 1, 1, NOW(), 0, 0, 680, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1208, 1, 408, 1208);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (308, 102, 'Property:Has food item', 0, 1, RANDOM(), NOW(), 1208, 680);

-- ============================================================================
-- PROPERTY 9: Has_pass_fail_status
-- ============================================================================
-- Stores the outcome of quality/safety checks
-- Type: Text
-- Values: Pass, Fail, Partial - Corrective action taken

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (409, '[[Has type::Text]]

This property records the pass/fail outcome of a food safety check or quality assurance activity.

== Usage ==
Record the outcome:
<nowiki>[[Has_pass_fail_status::Pass]]</nowiki>
<nowiki>[[Has_pass_fail_status::Fail]]</nowiki>
<nowiki>[[Has_pass_fail_status::Partial - Corrective action taken]]</nowiki>

== Allowed Values ==
* Pass - All criteria met, no action needed
* Fail - Critical criteria not met, corrective action required
* Partial - Corrective action taken - Minor issues corrected during inspection

== Purpose ==
Enables rapid identification of forms with failures or issues requiring corrective action. Critical for regulatory compliance tracking.

== Used In ==
12 templates with QC checks:
* Template:HotHoldingTemperatureLog
* Template:LiveShellfishDisplayLog
* Template:SelfServiceDisplayChecklist
* Template:Daily_Cleaning_Sanitising_Log
* Plus additional quality control templates

[[Category:Form Properties]]
[[Category:Quality Control Properties]]
[[Category:Outcome Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (409, 740, '', 1, 'tt:409');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1209, 309, 1, 1, NOW(), 0, 0, 740, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1209, 1, 409, 1209);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (309, 102, 'Property:Has pass fail status', 0, 1, RANDOM(), NOW(), 1209, 740);

-- ============================================================================
-- PROPERTY 10: Has_corrective_action
-- ============================================================================
-- Stores corrective actions taken when issues found
-- Type: Text

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (410, '[[Has type::Text]]

This property records the corrective actions taken in response to identified issues or failures in food safety checks.

== Usage ==
Document actions taken:
<nowiki>[[Has_corrective_action::Re-heated chicken to 75°C, rechecked with calibrated thermometer]]</nowiki>
<nowiki>[[Has_corrective_action::Re-cleaned equipment using hot water and sanitiser, conducted second inspection]]</nowiki>

== Purpose ==
Demonstrates that issues have been addressed and provides evidence of corrective action for regulatory compliance.

== Used In ==
20+ food control templates, including:
* Template:HotHoldingTemperatureLog
* Template:Daily_Cleaning_Sanitising_Log
* Template:Incident_Report
* Template:Corrective_Action_Plan
* Template:Food_Traceability_Record
* Plus additional templates

[[Category:Form Properties]]
[[Category:Corrective Action Properties]]
[[Category:Compliance Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (410, 700, '', 1, 'tt:410');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1210, 310, 1, 1, NOW(), 0, 0, 700, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1210, 1, 410, 1210);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (310, 102, 'Property:Has corrective action', 0, 1, RANDOM(), NOW(), 1210, 700);

-- ============================================================================
-- PROPERTY 11: Has_incident_severity
-- ============================================================================
-- Stores the severity level of an incident
-- Type: Text
-- Values: Low, Medium, High, Critical

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (411, '[[Has type::Text]]

This property records the severity level of a food safety incident, complaint, or problem.

== Usage ==
Record the incident severity:
<nowiki>[[Has_incident_severity::Low]]</nowiki>
<nowiki>[[Has_incident_severity::Critical]]</nowiki>

== Severity Levels ==
* Low - Minor operational issue, no food safety impact (equipment malfunction quickly fixed, minor spillage)
* Medium - Operational impact or potential food safety concern requiring investigation (temperature excursion quickly corrected, cleaning failure detected and addressed)
* High - Significant food safety risk requiring immediate investigation (product held at wrong temperature for extended time, contamination suspected)
* Critical - Immediate food safety threat requiring emergency response (product consumed that may cause illness, confirmed contamination, equipment failure affecting food safety)

== Response Time ==
* Critical: Immediate action required, notify management and customers if necessary
* High: Respond within 30 minutes, begin investigation
* Medium: Log and investigate same day
* Low: Log and monitor for patterns

== Used In ==
8 Red (Troubleshooting) section templates:
* Template:Incident_Report
* Template:Complaint_Log
* Template:Corrective_Action_Plan
* Template:Food_Traceability_Record
* Template:Recall_Notification
* Template:Regulatory_Report
* Template:Root_Cause_Analysis
* Template:Investigation_Log

[[Category:Form Properties]]
[[Category:Incident Properties]]
[[Category:Severity Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (411, 1180, '', 1, 'tt:411');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1211, 311, 1, 1, NOW(), 0, 0, 1180, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1211, 1, 411, 1211);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (311, 102, 'Property:Has incident severity', 0, 1, RANDOM(), NOW(), 1211, 1180);

-- ============================================================================
-- PROPERTY 12: Has_investigation_status
-- ============================================================================
-- Stores the status of incident investigation
-- Type: Text
-- Values: Open, In Progress, Resolved, Closed

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (412, '[[Has type::Text]]

This property records the current status of an incident investigation.

== Usage ==
Record the investigation status:
<nowiki>[[Has_investigation_status::Open]]</nowiki>
<nowiki>[[Has_investigation_status::Resolved]]</nowiki>

== Status Values ==
* Open - Incident reported but investigation not yet started
* In Progress - Investigation underway, root cause being determined
* Resolved - Root cause identified and corrective actions implemented
* Closed - Investigation complete, all actions taken, file archived

== Workflow ==
1. Incident occurs → Status: Open
2. Investigation begins → Status: In Progress
3. Root cause found, actions implemented → Status: Resolved
4. Verification complete → Status: Closed

== Purpose ==
Tracks incident management workflow and identifies outstanding investigations requiring follow-up.

== Used In ==
8 Red (Troubleshooting) section templates:
* Template:Incident_Report
* Template:Complaint_Log
* Template:Corrective_Action_Plan
* Template:Food_Traceability_Record
* Template:Recall_Notification
* Template:Regulatory_Report
* Template:Root_Cause_Analysis
* Template:Investigation_Log

[[Category:Form Properties]]
[[Category:Incident Properties]]
[[Category:Status Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (412, 920, '', 1, 'tt:412');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1212, 312, 1, 1, NOW(), 0, 0, 920, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1212, 1, 412, 1212);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (312, 102, 'Property:Has investigation status', 0, 1, RANDOM(), NOW(), 1212, 920);

COMMIT;
