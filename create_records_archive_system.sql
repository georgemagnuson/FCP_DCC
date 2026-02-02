-- =====================================================================
-- Phase 4: Records Archive System - Complete Deployment
-- Date: 2026-02-02
-- Status: Ready for Deployment
-- Purpose: Dynamic record retrieval using SMW queries for compliance review
-- Schema: MediaWiki 1.43.5 with slots/content model
-- =====================================================================

BEGIN;

-- =====================================================================
-- 1. RECORDS_ARCHIVE MAIN HUB (page 370, namespace 0)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (370, '= Records Archive =

This is the central hub for accessing submitted food control records organized by time period and record type. All records are dynamically queried from the database using Semantic MediaWiki.

== Quick Navigation ==

* [[Records_Archive/Daily|Today''s Records]] - All submissions from today
* [[Records_Archive/Weekly|This Week''s Records]] - Last 7 days of submissions
* [[Records_Archive/Monthly|This Month''s Records]] - Last 30 days of submissions
* [[Records_Archive/Search|Advanced Search]] - Custom date ranges and filters

== Archive Statistics ==

=== Records Submitted Today ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]]
 |?Has_form_name
 |format=count
}}

=== This Week (Last 7 Days) ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_form_name
 |format=count
}}

=== This Month (Last 30 Days) ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_form_name
 |format=count
}}

== By Record Type ==

=== Daily Operations ===

* [[Form:Daily_Opening_Checklist|Opening Checklists]]
* [[Form:Daily_Closing_Checklist|Closing Checklists]]
* [[Form:Temperature_Recording|Temperature Monitoring]]

=== Incidents & Issues ===

* [[Form:Daily_Problem_Report|Problem Reports]]
* [[Form:Incident_Report|Incident Reports]]

=== Management ===

* [[Form:Weekly_Supervision|Weekly Supervision]]
* [[Form:Equipment_Maintenance_Log|Equipment Maintenance]]

== Staff Accountability ==

Browse records by employee:

* [[Employee_Directory|Employee Directory]] - View employee details
* [[Records_Archive/Search|Search by Staff Member]] - Find all records submitted by specific staff member

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (370, 1800, '', 1, 'tt:370');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1146, 370, 1, 1, NOW(), 0, 0, 1800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1146, 1, 370, 1146);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (370, 0, 'Records_Archive', 0, 1, RANDOM(), NOW(), 1146, 1800);

-- =====================================================================
-- 2. RECORDS_ARCHIVE/DAILY - Today's Records (page 371, namespace 0)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (371, '= Today''s Records =

All records submitted today, organized by type and status.

== Record Summary ==

Total records submitted today: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]] |format=count}}

== Daily Operational Records ==

=== Opening Checklists ===

{{#ask: [[Has_form_name::Daily_Opening_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
}}

No opening checklists submitted today.

=== Closing Checklists ===

{{#ask: [[Has_form_name::Daily_Closing_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
}}

No closing checklists submitted today.

=== Temperature Monitoring ===

{{#ask: [[Has_form_name::Temperature_Recording]]
       [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]]
 |?Has_equipment_unit
 |?Has_temperature
 |?Has_pass_fail_status
 |?Has_staff_name
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
}}

No temperature records submitted today.

== Incidents & Problems ==

=== Problem Reports ===

{{#ask: [[Has_form_name::Daily_Problem_Report]]
       [[Has_submission_date::>{{#time:Y-m-d|now -1 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |?Has_corrective_action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
}}

No problem reports submitted today.

== Navigation ==

* [[Records_Archive|Back to Archive Hub]]
* [[Records_Archive/Weekly|This Week''s Records]]
* [[Records_Archive/Monthly|This Month''s Records]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (371, 2200, '', 1, 'tt:371');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1147, 371, 1, 1, NOW(), 0, 0, 2200, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1147, 1, 371, 1147);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (371, 0, 'Records_Archive/Daily', 0, 1, RANDOM(), NOW(), 1147, 2200);

-- =====================================================================
-- 3. RECORDS_ARCHIVE/WEEKLY - Last 7 Days (page 372, namespace 0)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (372, '= This Week''s Records =

All records from the last 7 days, organized by record type.

== Record Summary ==

Records submitted this week: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]] |format=count}}

== Daily Operational Records ==

=== All Opening Checklists (Last 7 Days) ===

{{#ask: [[Has_form_name::Daily_Opening_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

=== All Closing Checklists (Last 7 Days) ===

{{#ask: [[Has_form_name::Daily_Closing_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

=== Temperature Records (Last 7 Days) ===

{{#ask: [[Has_form_name::Temperature_Recording]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_equipment_unit
 |?Has_temperature
 |?Has_pass_fail_status
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

== Staff Accountability ==

=== Records by Staff Member (This Week) ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_staff_name
 |?Has_form_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_staff_name
}}

== Issues & Incidents ==

=== Problem Reports (Last 7 Days) ===

{{#ask: [[Has_form_name::Daily_Problem_Report]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |?Has_corrective_action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

== Navigation ==

* [[Records_Archive|Back to Archive Hub]]
* [[Records_Archive/Daily|Today''s Records]]
* [[Records_Archive/Monthly|This Month''s Records]]
* [[Records_Archive/Search|Advanced Search]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (372, 2400, '', 1, 'tt:372');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1148, 372, 1, 1, NOW(), 0, 0, 2400, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1148, 1, 372, 1148);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (372, 0, 'Records_Archive/Weekly', 0, 1, RANDOM(), NOW(), 1148, 2400);

-- =====================================================================
-- 4. RECORDS_ARCHIVE/MONTHLY - Last 30 Days (page 373, namespace 0)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (373, '= This Month''s Records =

All records from the last 30 days, organized by record type and compliance status.

== Record Summary ==

Records submitted this month: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]] |format=count}}

== Compliance Status ==

=== Passing Records (This Month) ===

{{#ask: [[Has_pass_fail_status::Pass]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_form_name
 |?Has_staff_name
 |?Has_submission_date
 |format=count
}}

=== Failing Records (This Month) ===

{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_form_name
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

== Daily Operational Records ==

=== Opening Checklists (Last 30 Days) ===

{{#ask: [[Has_form_name::Daily_Opening_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=count
}}

=== Closing Checklists (Last 30 Days) ===

{{#ask: [[Has_form_name::Daily_Closing_Checklist]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |format=count
}}

=== Temperature Records (Last 30 Days) ===

{{#ask: [[Has_form_name::Temperature_Recording]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_equipment_unit
 |?Has_pass_fail_status
 |?Has_submission_date
 |format=count
}}

== Incidents & Issues ==

=== Problem Reports (Last 30 Days) ===

{{#ask: [[Has_form_name::Daily_Problem_Report]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name
 |?Has_submission_date
 |?Has_corrective_action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

== Staff Performance ==

=== Records by Staff (Last 30 Days) ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name
 |?Has_form_name
 |format=count
}}

== Navigation ==

* [[Records_Archive|Back to Archive Hub]]
* [[Records_Archive/Daily|Today''s Records]]
* [[Records_Archive/Weekly|This Week''s Records]]
* [[Records_Archive/Search|Advanced Search]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (373, 2600, '', 1, 'tt:373');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1149, 373, 1, 1, NOW(), 0, 0, 2600, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1149, 1, 373, 1149);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (373, 0, 'Records_Archive/Monthly', 0, 1, RANDOM(), NOW(), 1149, 2600);

-- =====================================================================
-- 5. RECORDS_ARCHIVE/SEARCH - Advanced Search (page 374, namespace 0)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (374, '= Advanced Records Search =

Use this page to search records with custom filters for date ranges, record types, staff members, and compliance status.

== Search Examples ==

=== All Temperature Failures (Last 14 Days) ===

{{#ask: [[Has_form_name::Temperature_Recording]]
       [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -14 days}}]]
 |?Has_equipment_unit
 |?Has_temperature
 |?Has_staff_name
 |?Has_submission_date
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

=== High-Severity Incidents (Last 14 Days) ===

{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -14 days}}]]
 |?Has_form_name
 |?Has_staff_name
 |?Has_investigation_status
 |?Has_corrective_action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

=== All Records by Specific Staff Member (Replace ''STAFF_NAME'') ===

Use this query structure: [[Has_staff_name::STAFF_NAME]]

Example: [[Has_staff_name::John Smith]]

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name
 |?Has_form_name
 |?Has_submission_date
 |format=broadtable
}}

=== Equipment-Specific Temperature Trends (FRIDGE-01) ===

{{#ask: [[Has_equipment_unit::FRIDGE-01]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_temperature
 |?Has_submission_date
 |?Has_pass_fail_status
 |?Has_staff_name
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}

== Search Strategies ==

=== By Date ===

* This week: {{#time:Y-m-d|now -7 days}}
* This month: {{#time:Y-m-d|now -30 days}}
* This quarter: {{#time:Y-m-d|now -90 days}}
* All: Remove the date filter

=== By Form Type ===

* Daily_Opening_Checklist
* Daily_Closing_Checklist
* Temperature_Recording
* Daily_Problem_Report
* Weekly_Supervision
* Incident_Report

=== By Status ===

* Pass/Fail: Add [[Has_pass_fail_status::Pass]] or [[Has_pass_fail_status::Fail]]
* Severity: Add [[Has_incident_severity::High]] or [[Has_incident_severity::Critical]]

=== By Staff ===

* Replace STAFF_NAME with employee name from Employee_Directory

== Navigation ==

* [[Records_Archive|Back to Archive Hub]]
* [[Records_Archive/Daily|Today''s Records]]
* [[Records_Archive/Weekly|This Week''s Records]]
* [[Records_Archive/Monthly|This Month''s Records]]
* [[Employee_Directory|Employee Directory]]

== Query Reference ==

All queries use these SMW properties:
* Has_submission_date - Record submission date
* Has_staff_name - Staff member who submitted
* Has_form_name - Type of form submitted
* Has_pass_fail_status - Compliance status (Pass/Fail)
* Has_temperature - Temperature values
* Has_equipment_unit - Equipment identifier
* Has_corrective_action - Corrective action taken
* Has_incident_severity - Incident severity level

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (374, 3000, '', 1, 'tt:374');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1150, 374, 1, 1, NOW(), 0, 0, 3000, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1150, 1, 374, 1150);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (374, 0, 'Records_Archive/Search', 0, 1, RANDOM(), NOW(), 1150, 3000);

-- =====================================================================
-- 6. UPDATE PAGE COUNTERS AND COMMIT
-- =====================================================================

UPDATE mediawiki.site_stats SET ss_total_pages = ss_total_pages + 5 WHERE ss_row_id = 1;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Pages created: 370-374 (5 total)
-- Revisions: 1146-1150
-- Content IDs: 370-374
-- Text IDs: 370-374
--
-- Pages breakdown:
-- 370: Records_Archive (main hub with overview statistics)
-- 371: Records_Archive/Daily (today''s submissions)
-- 372: Records_Archive/Weekly (last 7 days)
-- 373: Records_Archive/Monthly (last 30 days)
-- 374: Records_Archive/Search (advanced search with examples)
--
-- Features:
-- - Dynamic SMW queries for record retrieval
-- - Date-based filtering (today, 7 days, 30 days)
-- - Status filtering (Pass/Fail)
-- - Severity filtering (High/Critical)
-- - Form type filtering
-- - Staff accountability tracking
-- - Equipment-specific trends
-- - Default messages when no data exists
--
-- Next steps:
-- 1. SSH to MediaWiki server: ssh 192.168.2.10
-- 2. Clear cache: php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Run jobs: php /usr/local/www/mediawiki/maintenance/runJobs.php
-- 4. Navigate to: http://192.168.1.18/mediawiki/index.php/Records_Archive
-- 5. Test queries by submitting test records
-- =====================================================================
