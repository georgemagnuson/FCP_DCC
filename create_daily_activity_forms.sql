-- =====================================================================
-- Daily Activity Record Forms - Complete Deployment
-- Date: 2026-02-02
-- Status: Ready for Deployment
-- Purpose: Daily opening/closing checklists, problem reporting, manager supervision
-- Schema: MediaWiki 1.43.5 with slots/content model
-- =====================================================================

BEGIN;

-- =====================================================================
-- 1. DAILY OPENING CHECKLIST
-- =====================================================================
-- Template:Daily_Opening_Checklist (page 361, namespace 10)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (361, '<noinclude>Template for daily opening checklist records. Used by Form:Daily_Opening_Checklist to record opening procedures compliance.</noinclude>

== Daily Opening Checklist ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date
| {{{date|}}}
|-
| Staff Member
| {{{staff_member|}}}
|-
| Staff Fitness Check
| {{{staff_fitness|}}}
|-
| Food Prep Area Clean
| {{{area_clean|}}}
|-
| Hand Washing Materials Available
| {{{hand_wash_materials|}}}
|-
| Additional Checks
| {{{additional_checks|}}}
|-
| Staff Signature
| {{{staff_signature|}}}
|}

[[Has_submission_date::{{{date|}}}]]
[[Has_staff_name::{{{staff_member|}}}]]
[[Has_form_name::Daily_Opening_Checklist]]
[[Has_record_type::Daily Operations]]
[[Has_pass_fail_status::Pass]]
[[Category:Daily_Records]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (361, 1500, '', 1, 'tt:361');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1137, 361, 1, 1, NOW(), 0, 0, 1500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1137, 1, 361, 1137);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (361, 10, 'Daily_Opening_Checklist', 0, 1, RANDOM(), NOW(), 1137, 1500);

-- Form:Daily_Opening_Checklist (page 362, namespace 106)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (362, '{{{for template|Daily_Opening_Checklist|label=Daily Opening Checklist}}}

== Opening Checklist ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date (auto-populated to today)
| {{{field|date|input type=text|size=20}}}
|-
| Staff Member (required)
| {{{field|staff_member|input type=combobox|cargo table=Employee|cargo field=employee_name|mandatory}}}
|-
| Staff Fitness Check
| {{{field|staff_fitness|input type=dropdown|values=Yes,No}}}
|-
| Food Prep Area Cleanliness
| {{{field|area_clean|input type=dropdown|values=Yes,No}}}
|-
| Hand Washing Materials Available
| {{{field|hand_wash_materials|input type=dropdown|values=Yes,No}}}
|-
| Additional Opening Checks/Notes
| {{{field|additional_checks|input type=textarea|rows=3|cols=50}}}
|-
| Staff Signature
| {{{field|staff_signature|input type=text|size=30}}}
|}

{{{end template}}}

{{{standard input|summary}}}
{{{standard input|preview}}}
{{{standard input|save}}}
{{{standard input|cancel}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (362, 1800, '', 1, 'tt:362');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1138, 362, 1, 1, NOW(), 0, 0, 1800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1138, 1, 362, 1138);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (362, 106, 'Daily_Opening_Checklist', 0, 1, RANDOM(), NOW(), 1138, 1800);

-- =====================================================================
-- 2. DAILY CLOSING CHECKLIST
-- =====================================================================
-- Template:Daily_Closing_Checklist (page 363, namespace 10)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (363, '<noinclude>Template for daily closing checklist records. Used by Form:Daily_Closing_Checklist to record closing procedures compliance.</noinclude>

== Daily Closing Checklist ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date
| {{{date|}}}
|-
| Staff Member
| {{{staff_member|}}}
|-
| Food Protected from Contamination
| {{{food_protected|}}}
|-
| Perishable Food Stored at Correct Temperature
| {{{temp_correct|}}}
|-
| Expired Food Disposed
| {{{expired_disposed|}}}
|-
| Cleaning Completed
| {{{cleaning_completed|}}}
|-
| Waste Removed, Fresh Bags Installed
| {{{waste_managed|}}}
|-
| Additional Closing Checks
| {{{additional_checks|}}}
|-
| Staff Signature
| {{{staff_signature|}}}
|}

[[Has_submission_date::{{{date|}}}]]
[[Has_staff_name::{{{staff_member|}}}]]
[[Has_form_name::Daily_Closing_Checklist]]
[[Has_record_type::Daily Operations]]
[[Has_pass_fail_status::Pass]]
[[Category:Daily_Records]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (363, 1600, '', 1, 'tt:363');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1139, 363, 1, 1, NOW(), 0, 0, 1600, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1139, 1, 363, 1139);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (363, 10, 'Daily_Closing_Checklist', 0, 1, RANDOM(), NOW(), 1139, 1600);

-- Form:Daily_Closing_Checklist (page 364, namespace 106)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (364, '{{{for template|Daily_Closing_Checklist|label=Daily Closing Checklist}}}

== Closing Checklist ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date (auto-populated to today)
| {{{field|date|input type=text|size=20}}}
|-
| Staff Member (required)
| {{{field|staff_member|input type=combobox|cargo table=Employee|cargo field=employee_name|mandatory}}}
|-
| Food Protected from Contamination
| {{{field|food_protected|input type=dropdown|values=Yes,No}}}
|-
| Perishable Food Stored at Correct Temperature
| {{{field|temp_correct|input type=dropdown|values=Yes,No}}}
|-
| Expired Food Disposed
| {{{field|expired_disposed|input type=dropdown|values=Yes,No}}}
|-
| Cleaning Completed (Per Schedule)
| {{{field|cleaning_completed|input type=dropdown|values=Yes,No}}}
|-
| Waste Removed, Fresh Bags Installed
| {{{field|waste_managed|input type=dropdown|values=Yes,No}}}
|-
| Additional Closing Checks/Notes
| {{{field|additional_checks|input type=textarea|rows=3|cols=50}}}
|-
| Staff Signature
| {{{field|staff_signature|input type=text|size=30}}}
|}

{{{end template}}}

{{{standard input|summary}}}
{{{standard input|preview}}}
{{{standard input|save}}}
{{{standard input|cancel}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (364, 1900, '', 1, 'tt:364');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1140, 364, 1, 1, NOW(), 0, 0, 1900, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1140, 1, 364, 1140);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (364, 106, 'Daily_Closing_Checklist', 0, 1, RANDOM(), NOW(), 1140, 1900);

-- =====================================================================
-- 3. DAILY PROBLEM REPORT
-- =====================================================================
-- Template:Daily_Problem_Report (page 365, namespace 10)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (365, '<noinclude>Template for daily problem/incident reports. Used by Form:Daily_Problem_Report to record issues and corrective actions.</noinclude>

== Daily Problem Report ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date
| {{{date|}}}
|-
| Time
| {{{time|}}}
|-
| Staff Member
| {{{staff_member|}}}
|-
| Problem Description
| {{{problem_description|}}}
|-
| Food Safety Impact
| {{{food_safety_impact|}}}
|-
| Corrective Action Taken
| {{{corrective_action|}}}
|-
| Prevention Measures
| {{{prevention_measures|}}}
|-
| Manager Notification
| {{{manager_notification|}}}
|-
| Staff Signature
| {{{staff_signature|}}}
|}

[[Has_submission_date::{{{date|}}}]]
[[Has_staff_name::{{{staff_member|}}}]]
[[Has_form_name::Daily_Problem_Report]]
[[Has_record_type::Incident]]
[[Has_corrective_action::{{{corrective_action|}}}]]
[[Category:Daily_Records]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (365, 1400, '', 1, 'tt:365');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1141, 365, 1, 1, NOW(), 0, 0, 1400, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1141, 1, 365, 1141);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (365, 10, 'Daily_Problem_Report', 0, 1, RANDOM(), NOW(), 1141, 1400);

-- Form:Daily_Problem_Report (page 366, namespace 106)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (366, '{{{for template|Daily_Problem_Report|label=Daily Problem Report}}}

== Problem/Incident Report ==

{| class="wikitable"
|-
! Field !! Value
|-
| Date (required)
| {{{field|date|input type=date|mandatory}}}
|-
| Time (required)
| {{{field|time|input type=text|size=10|mandatory}}}
|-
| Staff Member (required)
| {{{field|staff_member|input type=combobox|cargo table=Employee|cargo field=employee_name|mandatory}}}
|-
| Problem Description (required)
| {{{field|problem_description|input type=textarea|rows=4|cols=50|mandatory}}}
|-
| Food Safety Impact
| {{{field|food_safety_impact|input type=dropdown|values=Yes,No}}}
|-
| Corrective Action Taken (required)
| {{{field|corrective_action|input type=textarea|rows=3|cols=50|mandatory}}}
|-
| Prevention Measures
| {{{field|prevention_measures|input type=textarea|rows=3|cols=50}}}
|-
| Manager Notification
| {{{field|manager_notification|input type=dropdown|values=Yes,No}}}
|-
| Staff Signature
| {{{field|staff_signature|input type=text|size=30}}}
|}

{{{end template}}}

{{{standard input|summary}}}
{{{standard input|preview}}}
{{{standard input|save}}}
{{{standard input|cancel}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (366, 1700, '', 1, 'tt:366');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1142, 366, 1, 1, NOW(), 0, 0, 1700, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1142, 1, 366, 1142);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (366, 106, 'Daily_Problem_Report', 0, 1, RANDOM(), NOW(), 1142, 1700);

-- =====================================================================
-- 4. WEEKLY SUPERVISION
-- =====================================================================
-- Template:Weekly_Supervision (page 367, namespace 10)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (367, '<noinclude>Template for weekly manager supervision attestations. Used by Form:Weekly_Supervision for manager sign-off on weekly compliance.</noinclude>

== Weekly Supervision ==

{| class="wikitable"
|-
! Field !! Value
|-
| Week Starting
| {{{week_starting|}}}
|-
| Manager Name
| {{{manager_name|}}}
|-
| Procedures Followed This Week
| {{{procedures_followed|}}}
|-
| Effective Supervision Applied
| {{{effective_supervision|}}}
|-
| Cleaning/Maintenance Tasks Completed
| {{{cleaning_maintenance|}}}
|-
| Pest Activity Signs Observed
| {{{pest_activity|}}}
|-
| Issues Recorded and Addressed
| {{{issues_recorded|}}}
|-
| Manager Attestation
| FCP procedures were followed and effectively supervised this week.
|-
| Manager Signature
| {{{manager_signature|}}}
|-
| Signature Date
| {{{signature_date|}}}
|}

[[Has_submission_date::{{{week_starting|}}}]]
[[Has_staff_name::{{{manager_name|}}}]]
[[Has_form_name::Weekly_Supervision]]
[[Has_record_type::Management Oversight]]
[[Category:Daily_Records]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (367, 1500, '', 1, 'tt:367');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1143, 367, 1, 1, NOW(), 0, 0, 1500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1143, 1, 367, 1143);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (367, 10, 'Weekly_Supervision', 0, 1, RANDOM(), NOW(), 1143, 1500);

-- Form:Weekly_Supervision (page 368, namespace 106)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (368, '{{{for template|Weekly_Supervision|label=Weekly Supervision & Manager Attestation}}}

== Weekly Management Supervision ==

{| class="wikitable"
|-
! Field !! Value
|-
| Week Starting (required)
| {{{field|week_starting|input type=date|mandatory}}}
|-
| Manager Name (required)
| {{{field|manager_name|input type=combobox|cargo table=Employee|cargo field=employee_name|mandatory}}}
|-
| Procedures Followed This Week
| {{{field|procedures_followed|input type=dropdown|values=Yes,No}}}
|-
| Effective Supervision Applied
| {{{field|effective_supervision|input type=dropdown|values=Yes,No}}}
|-
| Cleaning/Maintenance Tasks Completed
| {{{field|cleaning_maintenance|input type=dropdown|values=Yes,No}}}
|-
| Pest Activity Signs Observed
| {{{field|pest_activity|input type=dropdown|values=Yes,No}}}
|-
| If Yes, Details:
| {{{field|pest_details|input type=textarea|rows=2|cols=50}}}
|-
| Issues Recorded and Addressed
| {{{field|issues_recorded|input type=dropdown|values=Yes,No}}}
|-
| If Yes, Details:
| {{{field|issues_details|input type=textarea|rows=2|cols=50}}}
|-
| Manager Attestation
| colspan="2" | The procedures in our Food Control Plan were followed and effectively supervised this week.
|}

{| class="wikitable"
|-
! Field !! Value
|-
| Manager Signature (required)
| {{{field|manager_signature|input type=text|size=30|mandatory}}}
|-
| Signature Date (required)
| {{{field|signature_date|input type=date|mandatory}}}
|}

{{{end template}}}

{{{standard input|summary}}}
{{{standard input|preview}}}
{{{standard input|save}}}
{{{standard input|cancel}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (368, 2000, '', 1, 'tt:368');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1144, 368, 1, 1, NOW(), 0, 0, 2000, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1144, 1, 368, 1144);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (368, 106, 'Weekly_Supervision', 0, 1, RANDOM(), NOW(), 1144, 2000);

-- =====================================================================
-- 5. DAILY ACTIVITY RECORDS PORTAL PAGE
-- =====================================================================
-- Daily_Activity_Records (page 369, namespace 0)

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (369, '= Daily Activity Records =

This page provides access to daily operational checklists, problem reporting, and weekly manager supervision records.

== Daily Staff Records ==

=== Opening Procedures ===

* [[Form:Daily_Opening_Checklist|Daily Opening Checklist]] - Verify facility readiness at start of business (staff fitness, cleanliness, hand washing materials)

=== Closing Procedures ===

* [[Form:Daily_Closing_Checklist|Daily Closing Checklist]] - Verify end-of-day compliance (contamination prevention, temperature, cleaning, waste)

=== Problem Reporting ===

* [[Form:Daily_Problem_Report|Daily Problem Report]] - Record problems, food safety impacts, corrective actions, and prevention measures

== Management Records ==

=== Weekly Manager Oversight ===

* [[Form:Weekly_Supervision|Weekly Supervision]] - Manager attestation that FCP procedures were followed and effectively supervised

== Entry Methods ==

{{#forminput:form=Daily_Opening_Checklist|default form=Opening:|button text=Create Opening Checklist}}

{{#forminput:form=Daily_Closing_Checklist|default form=Closing:|button text=Create Closing Checklist}}

{{#forminput:form=Daily_Problem_Report|default form=Problem:|button text=Create Problem Report}}

{{#forminput:form=Weekly_Supervision|default form=Supervision:|button text=Create Weekly Supervision}}

== Related Pages ==

* [[Daily_Records]] - Quick access to all form types
* [[Employee_Directory]] - Staff member directory
* [[Records_Archive]] - Archive of submitted records (when deployed)

[[Category:Food Control Records]]
[[Category:Daily_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (369, 1800, '', 1, 'tt:369');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1145, 369, 1, 1, NOW(), 0, 0, 1800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1145, 1, 369, 1145);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (369, 0, 'Daily_Activity_Records', 0, 1, RANDOM(), NOW(), 1145, 1800);

-- =====================================================================
-- 6. UPDATE PAGE COUNTERS AND COMMIT
-- =====================================================================

UPDATE mediawiki.site_stats SET ss_total_pages = ss_total_pages + 9 WHERE ss_row_id = 1;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Pages created: 361-369
-- Revisions: 1137-1145
-- Content IDs: 361-369
-- Text IDs: 361-369
--
-- Pages breakdown:
-- 361-362: Daily Opening Checklist (template + form)
-- 363-364: Daily Closing Checklist (template + form)
-- 365-366: Daily Problem Report (template + form)
-- 367-368: Weekly Supervision (template + form)
-- 369: Daily Activity Records portal page
--
-- All forms use:
-- - Employee dropdown (combobox) for staff member selection
-- - SMW properties for accountability tracking
-- - Standardized PageForms pattern with prefixes
-- - Standard input buttons for form submission
--
-- Next steps:
-- 1. SSH to MediaWiki server: ssh 192.168.2.10
-- 2. Clear cache: php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Run jobs: php /usr/local/www/mediawiki/maintenance/runJobs.php
-- 4. Navigate to: http://192.168.1.18/mediawiki/index.php/Daily_Activity_Records
-- 5. Test creating records via each form
-- =====================================================================
