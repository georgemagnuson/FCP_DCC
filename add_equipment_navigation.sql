-- Add Equipment Registry Navigation - Options A + C
-- Option A: Add links to main pages (Daily_Records, Monthly_Records)
-- Option C: Create Equipment_Registry redirect page

BEGIN;

-- ============================================================================
-- OPTION C: Create Equipment_Registry Redirect Page (Simpler Name)
-- ============================================================================
-- Makes it easier for staff to remember and find

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (428, $$#REDIRECT [[Equipment_Registry_Documentation]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (428, 50, '', 1, 'tt:428');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1228, 333, 1, 1, NOW(), 0, 0, 50, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1228, 1, 428, 1228);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (333, 0, 'Equipment_Registry', 0, 1, RANDOM(), NOW(), 1228, 50);

-- ============================================================================
-- OPTION A: Add Equipment Links to Daily_Records (page_id: 230)
-- ============================================================================
-- Add equipment section and links at the end of Daily_Records page

UPDATE mediawiki.text
SET old_text = old_text || '

== Equipment Temperature Monitoring ==

Before recording temperatures, ensure all equipment is registered via [[Equipment_Registry]].

* [[Form:Equipment_Registry|Register New Equipment]] - Add new temperature control equipment
* [[Form:Temperature_Recording|Record Daily Temperatures]] - Log morning and evening readings
* [[Equipment|View All Equipment Units]] - See registered equipment inventory

For equipment-specific guidance, see: [[Food_Control_Diary_Equipment_Integration]]'
WHERE old_id IN (
  SELECT slot_content_id
  FROM mediawiki.slots
  WHERE slot_revision_id = (
    SELECT rev_id FROM mediawiki.revision
    WHERE rev_page = 230
    ORDER BY rev_timestamp DESC LIMIT 1
  )
);

-- ============================================================================
-- OPTION A: Add Equipment Links to Monthly_Records (page_id: 232)
-- ============================================================================
-- Add equipment review section to Monthly_Records page

UPDATE mediawiki.text
SET old_text = old_text || '

== Equipment Registry & Maintenance ==

The [[Equipment_Registry|Equipment Registry]] tracks all temperature control equipment and links to temperature monitoring records.

* [[Equipment_Registry|Equipment Registry Guide]] - Complete documentation
* [[Form:Equipment_Registry|Register Equipment]] - Add new equipment units
* [[Equipment|Equipment Inventory]] - View all registered equipment
* [[Food_Control_Diary_Equipment_Integration|Diary Integration Guide]] - How equipment links to Food Control Diary

During the four-week review, check:
* Any new equipment added to the business
* Equipment maintenance records
* Equipment-specific temperature compliance
* Equipment that needs servicing or replacement

See: [[Food_Control_Diary_Equipment_Integration|Food Control Diary - Equipment Integration]] for details.'
WHERE old_id IN (
  SELECT slot_content_id
  FROM mediawiki.slots
  WHERE slot_revision_id = (
    SELECT rev_id FROM mediawiki.revision
    WHERE rev_page = 232
    ORDER BY rev_timestamp DESC LIMIT 1
  )
);

-- ============================================================================
-- Update Daily_Records Page Metadata (Increment revision)
-- ============================================================================

UPDATE mediawiki.revision
SET rev_timestamp = NOW()
WHERE rev_page = 230 AND rev_id IN (
  SELECT rev_id FROM mediawiki.revision
  WHERE rev_page = 230
  ORDER BY rev_timestamp DESC LIMIT 1
);

UPDATE mediawiki.page
SET page_touched = NOW()
WHERE page_id = 230;

-- ============================================================================
-- Update Monthly_Records Page Metadata (Increment revision)
-- ============================================================================

UPDATE mediawiki.revision
SET rev_timestamp = NOW()
WHERE rev_page = 232 AND rev_id IN (
  SELECT rev_id FROM mediawiki.revision
  WHERE rev_page = 232
  ORDER BY rev_timestamp DESC LIMIT 1
);

UPDATE mediawiki.page
SET page_touched = NOW()
WHERE page_id = 232;

COMMIT;
