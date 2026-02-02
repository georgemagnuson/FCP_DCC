-- Equipment Registry Form - MPI Food Control Plan Diary
-- Creates Template:EquipmentRegistry and Form:Equipment_Registry
-- Purpose: Inventory of temperature control equipment for FCP compliance

BEGIN;

-- ============================================================================
-- EQUIPMENT REGISTRY FORM
-- ============================================================================

-- Template for Equipment Registry
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (413, '<noinclude>
This is a template for the Equipment Registry form tracking all temperature control equipment in the facility.
</noinclude>

{| class="wikitable"
|-
! Unit Number
! Equipment Type
! Location
! Purpose
! Installation Date
|-
| {{{unit_number|}}}
| {{{equipment_type|}}}
| {{{location|}}}
| {{{purpose|}}}
| {{{installation_date|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (413, 320, '', 1, 'tt:413');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1213, 318, 1, 1, NOW(), 0, 0, 320, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1213, 1, 413, 1213);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (318, 10, 'Template:EquipmentRegistry', 0, 1, RANDOM(), NOW(), 1213, 320);

-- Form Page for Equipment Registry
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (414, '<form>
{{{for template|EquipmentRegistry}}}
! Unit Number:
| <input type="text" name="unit_number" size="20" />
|-
! Equipment Type:
| <input type="text" name="equipment_type" size="30" />
|-
! Location in Facility:
| <textarea name="location" rows="2" cols="40"></textarea>
|-
! Purpose:
| <select name="purpose">
<option>Cold Holding</option>
<option>Hot Holding</option>
<option>Freezer</option>
<option>Refrigerator</option>
<option>Display Case</option>
<option>Other</option>
</select>
|-
! Installation Date:
| <input type="date" name="installation_date" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Equipment]] [[Category:MPI_Diary_Forms]] [[Category:Temperature_Control]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (414, 750, '', 1, 'tt:414');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1214, 319, 1, 1, NOW(), 0, 0, 750, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1214, 1, 414, 1214);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (319, 0, 'Form:Equipment_Registry', 0, 1, RANDOM(), NOW(), 1214, 750);

-- ============================================================================
-- SMW PROPERTY PAGES (for Phase 3 integration)
-- ============================================================================

-- Property: Has_equipment_unit
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (415, '[[Has type::Text]]
[[Allows value::Text]]

This property stores the equipment unit number/identifier.', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (415, 90, '', 1, 'tt:415');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1215, 320, 1, 1, NOW(), 0, 0, 90, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1215, 1, 415, 1215);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (320, 102, 'Property:Has_equipment_unit', 0, 1, RANDOM(), NOW(), 1215, 90);

-- ============================================================================
-- MONTHLY RECORDS PAGE UPDATE
-- ============================================================================

-- Add Equipment Registry form link to Monthly_Records page
-- This updates the existing Monthly_Records page to include the Equipment Registry form

UPDATE mediawiki.text
SET old_text = REPLACE(
  old_text,
  '4. Equipment Registry (as needed)',
  '4. [[Form:Equipment_Registry|Equipment Registry]] (as needed)'
)
WHERE old_id IN (
  SELECT slot_content_id
  FROM mediawiki.slots
  WHERE slot_revision_id = (
    SELECT rev_id FROM mediawiki.revision
    WHERE rev_page = (
      SELECT page_id FROM mediawiki.page
      WHERE page_title = 'Monthly_Records' AND page_namespace = 0
    )
    ORDER BY rev_timestamp DESC LIMIT 1
  )
);

COMMIT;
