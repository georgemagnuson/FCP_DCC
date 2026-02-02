-- =====================================================================
-- Employee Directory Portal & Category - Final Deployment
-- Date: 2026-02-02
-- Status: Ready for Deployment
-- Note: Template:Employee and Form:Employee already exist (pages 61-62)
-- Schema: MediaWiki 1.43.5 with slots/content model
-- =====================================================================

BEGIN;

-- =====================================================================
-- 1. CREATE CATEGORY:EMPLOYEE (Category namespace: 14, page_id: 359)
-- =====================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (359, 'This category contains all employee records for the Food Control Plan Diary system. Employee records are used for accountability tracking across all daily checks, temperature monitoring, incident reporting, and compliance records.

== Related Categories ==

[[Category:Setting Up]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (359, 400, '', 1, 'tt:359');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1135, 359, 1, 1, NOW(), 0, 0, 400, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1135, 1, 359, 1135);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (359, 14, 'Employee', 0, 1, RANDOM(), NOW(), 1135, 400);

-- =====================================================================
-- 2. CREATE EMPLOYEE_DIRECTORY (Main namespace: 0, page_id: 360)
-- =====================================================================

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

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (360, 1000, '', 1, 'tt:360');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1136, 360, 1, 1, NOW(), 0, 0, 1000, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1136, 1, 360, 1136);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (360, 0, 'Employee_Directory', 0, 1, RANDOM(), NOW(), 1136, 1000);

-- =====================================================================
-- 3. UPDATE PAGE COUNTERS AND COMMIT
-- =====================================================================

-- Update MediaWiki page stats
UPDATE mediawiki.site_stats SET ss_total_pages = ss_total_pages + 2 WHERE ss_row_id = 1;

-- Commit transaction
COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Pages created: 359-360
-- Revisions: 1135-1136
-- Content IDs: 359-360
-- Text entries: 359-360
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
