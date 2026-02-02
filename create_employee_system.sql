-- =====================================================================
-- FCP_DCC Employee System - Complete Implementation
-- Date: 2026-02-02
-- Status: Ready for Deployment
-- Purpose: Create Employee Registry with accountability tracking
-- =====================================================================

-- Page IDs to use: 357-361 (consecutive, following max 356)
-- Text IDs (old_id): 357-361
-- Revision IDs (rev_id): 1133-1137

BEGIN;

-- =====================================================================
-- 1. CREATE TEMPLATE:EMPLOYEE (Template namespace: 10, page_id: 357)
-- =====================================================================

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_touched, page_random, page_latest, page_len)
VALUES (357, 10, 'Employee', 0, 1, now(), 0.5, 1133, 3500);

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_text_id, rev_comment, rev_user, rev_user_text, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format)
VALUES (1133, 357, 357, 'Create Employee template', 1, 'MediaWiki default', now(), 0, 0, 3500, 0, 'template_hash', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (357, '<noinclude>This is a template for employee records. Used by Form:Employee to display employee information and create accountability records.</noinclude>

== Employee Information ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name
| {{{employee_name|}}}
|-
| Employee ID
| {{{employee_id|}}}
|-
| Position/Role
| {{{position_role|}}}
|-
| Department
| {{{department|}}}
|-
| Start Date
| {{{start_date|}}}
|}

== Contact Information ==

{| class="wikitable"
|-
! Field !! Value
|-
| Email
| {{{email|}}}
|-
| Phone
| {{{phone|}}}
|}

== Compliance & Authorization ==

{| class="wikitable"
|-
! Field !! Value
|-
| Food Safety Training Completed
| {{{training_completed|}}}
|-
| Training Date
| {{{training_date|}}}
|-
| Authorized to Sign Off
| {{{authorized_sign_off|}}}
|}

== MediaWiki Integration ==

{| class="wikitable"
|-
! Field !! Value
|-
| MediaWiki Username
| {{{mediawiki_username|}}}
|-
| User Role/Group
| {{{user_role_group|}}}
|-
| Permissions Assigned
| {{{permissions_assigned|}}}
|}

== Accountability Record ==

[[Has_employee_name::{{{employee_name|}}}]]
[[Has_employee_id::{{{employee_id|}}}]]
[[Has_employee_role::{{{position_role|}}}]]
[[Has_training_status::{{{training_completed|}}}]]
[[Has_authorization_level::{{{authorized_sign_off|}}}]]
[[Has_mediawiki_username::{{{mediawiki_username|}}}]]
[[Has_form_name::Employee]]
[[Has_record_type::Employee Directory]]

[[Category:Employee]]

__NOTOC__', 'utf-8');

-- =====================================================================
-- 2. CREATE FORM:EMPLOYEE (Form namespace: 106, page_id: 358)
-- =====================================================================

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_touched, page_random, page_latest, page_len)
VALUES (358, 106, 'Employee', 0, 1, now(), 0.5, 1134, 4200);

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_text_id, rev_comment, rev_user, rev_user_text, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format)
VALUES (1134, 358, 358, 'Create Employee form', 1, 'MediaWiki default', now(), 0, 0, 4200, 0, 'form_hash', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (358, '{{{for template|Employee|label=Employee Record}}}

== Basic Information ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name (required)
| {{{field|employee_name|input type=text|size=50|mandatory}}}
|-
| Employee ID (required)
| {{{field|employee_id|input type=text|size=20|mandatory}}}
|-
| Position/Role (required)
| {{{field|position_role|input type=dropdown|values=Manager,Food Prep Staff,Cleaning Staff,Cashier,Owner,Other|mandatory}}}
|-
| Department
| {{{field|department|input type=text|size=30}}}
|-
| Start Date
| {{{field|start_date|input type=date}}}
|}

== Contact Information ==

{| class="wikitable"
|-
! Field !! Value
|-
| Email
| {{{field|email|input type=text|size=50}}}
|-
| Phone
| {{{field|phone|input type=text|size=20}}}
|}

== Compliance & Authorization ==

{| class="wikitable"
|-
! Field !! Value
|-
| Food Safety Training Completed
| {{{field|training_completed|input type=dropdown|values=Yes,No}}}
|-
| Training Date
| {{{field|training_date|input type=date}}}
|-
| Authorized to Sign Off
| {{{field|authorized_sign_off|input type=dropdown|values=Yes,No}}}
|}

== MediaWiki Integration ==

{| class="wikitable"
|-
! Field !! Value
|-
| MediaWiki Username
| {{{field|mediawiki_username|input type=text|size=30}}}
|-
| User Role/Group
| {{{field|user_role_group|input type=dropdown|values=data-entry-staff,manager,inspector,sysop,none}}}
|-
| Permissions Assigned
| {{{field|permissions_assigned|input type=textarea|rows=3|cols=50}}}
|}

{{{end template}}}

{{{standard input|summary}}}
{{{standard input|preview}}}
{{{standard input|save}}}
{{{standard input|cancel}}}', 'utf-8');

-- =====================================================================
-- 3. CREATE CATEGORY:EMPLOYEE (Category namespace: 14, page_id: 359)
-- =====================================================================

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_touched, page_random, page_latest, page_len)
VALUES (359, 14, 'Employee', 0, 1, now(), 0.5, 1135, 800);

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_text_id, rev_comment, rev_user, rev_user_text, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format)
VALUES (1135, 359, 359, 'Create Employee category', 1, 'MediaWiki default', now(), 0, 0, 800, 0, 'category_hash', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (359, 'This category contains all employee records for the Food Control Plan Diary system. Employee records are used for accountability tracking across all daily checks, temperature monitoring, incident reporting, and compliance records.

== Related Categories ==

[[Category:Setting Up]]', 'utf-8');

-- =====================================================================
-- 4. CREATE EMPLOYEE_DIRECTORY (Main namespace: 0, page_id: 360)
-- =====================================================================

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_touched, page_random, page_latest, page_len)
VALUES (360, 0, 'Employee_Directory', 0, 1, now(), 0.5, 1136, 2500);

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_text_id, rev_comment, rev_user, rev_user_text, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format)
VALUES (1136, 360, 360, 'Create Employee Directory portal', 1, 'MediaWiki default', now(), 0, 0, 2500, 0, 'portal_hash', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (360, '= Employee Directory =

This is the central hub for managing employee records in the Food Control Plan Diary system. All employees must be registered here to enable accountability tracking on daily checklists, temperature records, incident reports, and all compliance documentation.

== Existing Employees ==

Click on any employee name below to view or edit their record:

<categorytree mode=pages>Employee</categorytree>

----

== Register New Employee ==

Enter employee name and ID below to create a new employee record:

{{#forminput:form=Employee|default form=Employee:|button text=Add or Edit Employee}}

----

== Employee Administration ==

* [[Employee_Directory/Permissions|Manage User Permissions]] - Assign MediaWiki access and roles
* [[Employee_Directory/Training|Training Status]] - Track food safety training
* [[Employee_Directory/Accountability|Accountability Reports]] - View employee action records

[[Category:Setting Up]]', 'utf-8');

-- =====================================================================
-- 5. UPDATE PAGE COUNTERS AND COMMIT
-- =====================================================================

-- Update MediaWiki page stats
UPDATE mediawiki.site_stats SET ss_total_pages = ss_total_pages + 4 WHERE ss_row_id = 1;

-- Commit transaction
COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Pages created: 357-360
-- Revisions: 1133-1136
-- Text entries: 357-360
-- Category: Employee (page 359)
-- Portal: Employee_Directory (page 360)
--
-- Next steps:
-- 1. SSH to MediaWiki server: ssh 192.168.2.10
-- 2. Clear cache: php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Run jobs: php /usr/local/www/mediawiki/maintenance/runJobs.php
-- 4. Hard refresh browser: Cmd+Shift+R
-- 5. Navigate to: http://192.168.1.18/mediawiki/index.php/Employee_Directory
-- 6. Test creating new employee entry
-- =====================================================================
