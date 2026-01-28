-- Simple Orange Page Insertion - Test with one page
-- Keeping Food Hot (Orange Page 1)

BEGIN;

-- Insert text content
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (225, 'FCP:Serving:Keeping food hot

== Know ==
* Food in danger zone (5-60°C) can cause illness
* Hot food must be kept above 60°C
* Check temperature every 2 hours
* Thermometers must be calibrated and accurate

== Do ==
* Use calibrated thermometer (probe, infrared, or automated)
* Follow manufacturer temperature recommendations
* If food drops below 60°C, reheat to 75°C or throw out
* Keep hot food in heated containers
* Maintain continuous heat source

== Show ==
* Temperature checking procedures
* Thermometer calibration records
* Food holding equipment specifications
* Staff training on hot food handling', 'utf-8');

-- Insert content record
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (225, 550, '', 1, 'tt:225');

-- Insert revision record (using existing comment_id = 1)
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1000, 122, 1, 1, NOW(), 0, 0, 550, NULL, '');

-- Insert slot (links revision to content)
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1000, 1, 225, 1000);

-- Insert page record
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (122, 0, 'FCP:Serving:Keeping_food_hot', 0, 1, RANDOM(), NOW(), 1000, 550);

COMMIT;

-- Verify
SELECT 'Page created' as result;
SELECT page_id, page_title, page_latest FROM mediawiki.page WHERE page_id = 122;
SELECT rev_id, rev_page FROM mediawiki.revision WHERE rev_id = 1000;
SELECT old_id, LENGTH(old_text) as text_length FROM mediawiki.text WHERE old_id = 225;
