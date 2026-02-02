-- =====================================================================
-- Update Main_Page - Add Food Control Records Hub Link
-- Date: 2026-02-02
-- Purpose: Add navigation to Food Control Records hub on main page
-- =====================================================================

BEGIN;

-- Update Main_Page with link to Food Control Records
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (372, '= MediaWiki Installation =

Welcome to MediaWiki!

== Food Control Plan Diary System ==

The Food Control Plan Diary System provides centralized management of food safety records and compliance documentation.

* [[Food_Control_Records|📋 Food Control Records Hub]] - Central hub for all daily operations, records archive, and compliance
* [[Daily_Records|Daily Records]] - Quick access to daily forms and checklists
* [[Employee_Directory|Staff Directory]] - Manage employees and track accountability
* [[Records_Archive|Records Archive]] - View and search submitted records

For more information on how to use this system, visit: [[Food_Control_Records|Food Control Records Hub]]

----

* navigation
** mainpage|Main page
** Testing Area|Testing Area
** recentchanges-url|Recent changes
** randompage-url|Random page
** helppage|Help about MediaWiki', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (372, 1200, '', 1, 'tt:372');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1153, 1, 1, 1, NOW(), 0, 0, 1200, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1153, 1, 372, 1153);

-- Update page stats
UPDATE mediawiki.page SET page_latest = 1153, page_touched = NOW(), page_len = 1200 WHERE page_id = 1;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Updated page: Main_Page (page 1)
-- New revision: 1153
-- Changes: Added Food Control Records Hub navigation section
--
-- New links:
-- - Food_Control_Records (main hub with emoji)
-- - Daily_Records
-- - Employee_Directory
-- - Records_Archive
--
-- Navigation structure now:
-- Main_Page
--   -> Food_Control_Records (hub)
--       -> Daily_Records
--       -> Records_Archive
--       -> Employee_Directory
--       -> Equipment_Registry
--
-- Next steps:
-- 1. ssh 192.168.2.10
-- 2. php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Navigate to: http://192.168.1.18/mediawiki/index.php/Main_Page
-- 4. Verify Food Control Records section appears
-- 5. Click links to verify navigation works
-- =====================================================================
