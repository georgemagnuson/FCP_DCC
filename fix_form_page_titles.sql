-- Fix Form Page Titles - Remove "Form:" prefix since namespace 106 adds it automatically

BEGIN;

-- Update Form:Equipment_Registry page title
UPDATE mediawiki.page
SET page_title = 'Equipment_Registry'
WHERE page_id = 319 AND page_namespace = 106;

-- Update Form:Temperature_Recording page title
UPDATE mediawiki.page
SET page_title = 'Temperature_Recording'
WHERE page_id = 327 AND page_namespace = 106;

-- Verify the changes
SELECT page_id, page_namespace, page_title FROM mediawiki.page
WHERE page_id IN (319, 327)
ORDER BY page_id;

COMMIT;
