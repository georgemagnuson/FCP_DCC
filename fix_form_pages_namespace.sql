-- Fix Form Pages - Move to correct namespace (106)

BEGIN;

-- Update Form:Equipment_Registry from namespace 0 to 106
UPDATE mediawiki.page
SET page_namespace = 106
WHERE page_id = 319 AND page_title = 'Form:Equipment_Registry';

-- Update Form:Temperature_Recording from namespace 0 to 106
UPDATE mediawiki.page
SET page_namespace = 106
WHERE page_id = 327 AND page_title = 'Form:Temperature_Recording';

-- Verify the updates
SELECT page_id, page_namespace, page_title FROM mediawiki.page
WHERE page_id IN (319, 327, 321);

COMMIT;
