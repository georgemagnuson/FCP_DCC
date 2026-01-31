-- Phase 3: Records Archive System Creation
-- Creates 5 Records Archive Pages with SMW queries for dynamic record display
-- These pages enable food control record tracking, filtering, and retrieval
-- by submission date, status, severity, and other criteria

BEGIN;

-- ============================================================================
-- PAGE 1: Records_Archive (Main Hub)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (352, '= Records Archive =

The Records Archive is your central hub for accessing, searching, and reviewing all submitted food control records. Navigate to specific time periods or use advanced search to find exactly what you need.

== Quick Navigation ==

Choose a time period to view submitted records:

* [[Records_Archive/Daily|📅 Today''s Records]] - Forms submitted today
* [[Records_Archive/Weekly|📊 Last 7 Days]] - This week''s submissions
* [[Records_Archive/Monthly|📈 Last 30 Days]] - This month''s records
* [[Records_Archive/Search|🔍 Advanced Search]] - Custom date range and filters

== Summary Statistics ==

=== Today''s Activity ===

Records submitted today:
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
 |format=count
 |default=0
}}

=== Recent Failures (Last 7 Days) ===

Failed checks requiring attention:
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |format=count
 |default=0
}}

=== Critical Incidents (Last 30 Days) ===

High or critical severity incidents:
{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |format=count
 |default=0
}}

== Archive Overview ==

=== Latest Records (Last 5) ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=5
 |default=No recent records available.
}}

== Related Pages ==

* [[Daily_Records|Forms by Schedule (Daily, Weekly, Monthly, Incident)]]
* [[Food_Control_Records|Main Food Control Plan]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (352, 1903, '', 1, 'tt:352');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1128, 313, 1, 1, NOW(), 0, 0, 1903, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1128, 1, 352, 1128);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (313, 0, 'Records_Archive', 0, 1, RANDOM(), NOW(), 1128, 1903);

-- ============================================================================
-- PAGE 2: Records_Archive/Daily
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (353, '= Daily Records Archive =

[[Records_Archive|← Back to Records Archive]]

This page displays all food control records submitted today. Check here for the latest daily operational submissions, temperature logs, and compliance checks.

== Records Submitted Today ==

{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |?Has_temperature=Temperature
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No records submitted today. Records will appear here as forms are submitted.
}}

== Today''s Summary ==

Total forms submitted: {{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]] |format=count |default=0}}

Passed checks: {{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
                       [[Has_pass_fail_status::Pass]]
                |format=count |default=0}}

Failed checks: {{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
                       [[Has_pass_fail_status::Fail]]
                |format=count |default=0}}

== Temperature Monitoring Forms ==

Temperature logs and monitoring records:

{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
       [[Has_temperature::+]]
 |?Has_form_name=Form
 |?Has_food_item=Item
 |?Has_temperature=Temperature
 |?Has_temperature_unit=Unit
 |format=broadtable
 |limit=50
 |default=No temperature logs submitted today.
}}

== Navigation ==

[[Records_Archive/Weekly|→ View Last 7 Days]] | [[Records_Archive/Monthly|→ View Last 30 Days]] | [[Records_Archive/Search|→ Advanced Search]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (353, 1869, '', 1, 'tt:353');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1129, 314, 1, 1, NOW(), 0, 0, 1869, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1129, 1, 353, 1129);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (314, 0, 'Records_Archive/Daily', 0, 1, RANDOM(), NOW(), 1129, 1869);

-- ============================================================================
-- PAGE 3: Records_Archive/Weekly
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (354, '= Weekly Records Archive =

[[Records_Archive|← Back to Records Archive]]

This page displays all food control records from the last 7 days. Review your weekly compliance patterns, temperature trends, and operational performance.

== Records from Last 7 Days ==

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No records from the past 7 days.
}}

== Weekly Summary ==

Total forms submitted (7 days): {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]] |format=count |default=0}}

Passed checks: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
                       [[Has_pass_fail_status::Pass]]
                |format=count |default=0}}

Failed checks: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
                       [[Has_pass_fail_status::Fail]]
                |format=count |default=0}}

== Failed Checks Requiring Attention ==

All failed checks in the past 7 days:

{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |?Has_corrective_action=Action Taken
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No failed checks. Excellent compliance record!
}}

== Temperature Trends ==

Temperature monitoring records from the past week:

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
       [[Has_temperature::+]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_food_item=Item
 |?Has_temperature=Temperature
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No temperature data available.
}}

== Navigation ==

[[Records_Archive/Daily|← View Today]] | [[Records_Archive/Monthly|→ View Last 30 Days]] | [[Records_Archive/Search|→ Advanced Search]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (354, 2162, '', 1, 'tt:354');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1130, 315, 1, 1, NOW(), 0, 0, 2162, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1130, 1, 354, 1130);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (315, 0, 'Records_Archive/Weekly', 0, 1, RANDOM(), NOW(), 1130, 2162);

-- ============================================================================
-- PAGE 4: Records_Archive/Monthly
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (355, '= Monthly Records Archive =

[[Records_Archive|← Back to Records Archive]]

This page displays all food control records from the last 30 days. Use this view for monthly compliance reviews, incident tracking, and regulatory reporting.

== Records from Last 30 Days ==

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=500
 |default=No records from the past 30 days.
}}

== Monthly Summary ==

Total forms submitted (30 days): {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]] |format=count |default=0}}

Passed checks: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
                       [[Has_pass_fail_status::Pass]]
                |format=count |default=0}}

Failed checks: {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
                       [[Has_pass_fail_status::Fail]]
                |format=count |default=0}}

== Incidents & Investigations ==

=== High and Critical Severity Incidents ===

{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_incident_severity=Severity
 |?Has_investigation_status=Investigation Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No high or critical incidents. Facility operating safely.
}}

=== All Incidents (30 days) ===

Complete incident log for the past month:

{{#ask: [[Has_form_name::Incident Report]] OR [[Has_form_name::Complaint Log]] OR [[Has_form_name::Root Cause Analysis]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_incident_severity=Severity
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No incidents recorded.
}}

== Compliance Performance ==

=== Failed Checks by Date ===

{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_corrective_action=Corrective Action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No failed checks recorded.
}}

== Navigation ==

[[Records_Archive/Daily|← View Today]] | [[Records_Archive/Weekly|← View Last 7 Days]] | [[Records_Archive/Search|→ Advanced Search]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (355, 2598, '', 1, 'tt:355');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1131, 316, 1, 1, NOW(), 0, 0, 2598, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1131, 1, 355, 1131);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (316, 0, 'Records_Archive/Monthly', 0, 1, RANDOM(), NOW(), 1131, 2598);

-- ============================================================================
-- PAGE 5: Records_Archive/Search
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (356, '= Advanced Search & Filters =

[[Records_Archive|← Back to Records Archive]]

Use this page to search for records using custom date ranges, form types, status filters, and other criteria. Build queries to find exactly what you need.

== Search by Date Range ==

=== Last 3 Days ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -3 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No records in the past 3 days.
}}

=== Last 14 Days ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -14 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=150
 |default=No records in the past 14 days.
}}

=== Last 60 Days ===

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -60 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=300
 |default=No records in the past 60 days.
}}

== Search by Form Type ==

=== Temperature Monitoring Forms ===

All forms with temperature data:

{{#ask: [[Has_temperature::+]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_food_item=Item
 |?Has_temperature=Temperature
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No temperature records found.
}}

=== Maintenance & Inspection Forms ===

Equipment maintenance and facility inspection records:

{{#ask: [[Has_form_name::Equipment Maintenance Log]] OR [[Has_form_name::Premises Condition Inspection]] OR [[Has_form_name::Calibration Record]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No maintenance records found.
}}

== Search by Status ==

=== All Passed Checks (30 days) ===

Records with passing status:

{{#ask: [[Has_pass_fail_status::Pass]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No passed checks found.
}}

=== All Failed Checks (30 days) ===

Records with failing status requiring corrective action:

{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |?Has_corrective_action=Corrective Action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No failed checks found.
}}

== Search by Severity ==

=== Critical Incidents ===

{{#ask: [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |limit=50
 |default=No critical incidents recorded.
}}

=== High Severity Incidents ===

{{#ask: [[Has_incident_severity::High]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No high severity incidents recorded.
}}

=== Medium Severity Incidents ===

{{#ask: [[Has_incident_severity::Medium]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No medium severity incidents recorded.
}}

== Staff Performance Tracking ==

=== Records by Staff Member ===

Query all records submitted by a specific staff member in the past 30 days:

{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name=Staff
 |?Has_form_name=Form
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_staff_name
 |order=asc
 |limit=300
 |default=No staff records found.
}}

== Tips for Searching ==

* Use the pre-built queries above for common searches
* All queries search the last 30-90 days by default
* Adjust date ranges or click through to specific pages for more details
* Contact your supervisor if you need custom date ranges or filters

== Navigation ==

[[Records_Archive/Daily|← Daily Records]] | [[Records_Archive/Weekly|← Weekly Records]] | [[Records_Archive/Monthly|← Monthly Records]] | [[Records_Archive|← Archive Hub]]

[[Category:Food Control Records]]
[[Category:Records Archive]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (356, 4421, '', 1, 'tt:356');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1132, 317, 1, 1, NOW(), 0, 0, 4421, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1132, 1, 356, 1132);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (317, 0, 'Records_Archive/Search', 0, 1, RANDOM(), NOW(), 1132, 4421);

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
-- Run these queries to verify Phase 3 deployment was successful:
--
-- SELECT page_id, page_title, page_len
-- FROM mediawiki.page
-- WHERE page_id BETWEEN 313 AND 317
-- ORDER BY page_id;
--
-- Should return 5 rows with page_ids 313-317 and titles:
-- 313 | Records_Archive
-- 314 | Records_Archive/Daily
-- 315 | Records_Archive/Weekly
-- 316 | Records_Archive/Monthly
-- 317 | Records_Archive/Search
--
-- Verify revision entries:
-- SELECT rev_id, rev_page, rev_len FROM mediawiki.revision WHERE rev_id BETWEEN 1128 AND 1132;
-- Should return 5 rows with revisions 1128-1132
--
-- ============================================================================
-- SUMMARY
-- ============================================================================
-- Created 5 Records Archive Pages:
-- 1. Records_Archive (page_id: 313) - Main hub with navigation and summary statistics
-- 2. Records_Archive/Daily (page_id: 314) - Today''s submitted forms with SMW queries
-- 3. Records_Archive/Weekly (page_id: 315) - Last 7 days with failure tracking
-- 4. Records_Archive/Monthly (page_id: 316) - Last 30 days with incident tracking
-- 5. Records_Archive/Search (page_id: 317) - Advanced search with multiple filter options
--
-- Total: 5 pages with 40+ SMW queries for comprehensive record retrieval
--
-- Sequences used:
-- old_id: 352-356 (5 pages)
-- rev_id: 1128-1132 (5 revisions)
-- page_id: 313-317 (5 pages)
--
-- All pages use SMW properties created in Phase 2:
-- - Has_submission_date (Date queries for time filtering)
-- - Has_form_name (Form type filtering)
-- - Has_staff_name (Staff tracking)
-- - Has_pass_fail_status (Compliance checking)
-- - Has_temperature (Temperature monitoring)
-- - Has_incident_severity (Incident classification)
-- - Has_investigation_status (Incident tracking)
-- - Has_corrective_action (Failure response)
-- - Plus 4 additional properties for complete tracking
-- ============================================================================
