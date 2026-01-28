-- Update Main Page to include Blue, Green, Magenta, and Orange sections
-- This replaces the current Main_Page with links to all FCP sections

BEGIN;

-- Get the current page info
-- Main_Page has page_id = 1, so we'll create a new revision

-- Insert updated Main Page content
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (245, '=Contents=

==Dark Blue Cards: Setting up==

====[[FCP:Setting Up:Day cycle|02 Day cycle]]====

====[[FCP:Setting Up:Instructions|05 Instructions]]====

====[[FCP:Setting Up:Business details|07 Business details]]====

====[[FCP:Setting Up:Business layout|11 Business layout]]====

====[[FCP:Setting Up:Understanding and managing risks from nearby activities|14 Understanding and managing risks from nearby activities]]====

====[[FCP:Setting Up:Taking responsibility|15 Taking responsibility]]====

====[[FCP:Setting Up:Checking the plan is working well|20 Checking the plan is working well]]====

====[[FCP:Setting Up:Training and competency|24 Training and competency]]====

====[[FCP:Setting Up:Managing places and equipment|27 Managing places and equipment]]====

====[[FCP:Setting Up:Managing water supply provided by a registered drinking water supplier|30 Managing water supply provided by a registered drinking water supplier]]====

====[[FCP:Setting Up:Managing self-supply water|32 Managing self-supply water]]====

----

==Blue Cards: Starting==

====[[FCP:Starting:Hazard analysis|01 Hazard analysis]]====

====[[FCP:Starting:Control measures|02 Control measures]]====

----

==Green Cards: Preparing==

====[[FCP:Preparing:Food_safely|Preparing food safely]]====

====[[FCP:Preparing:Separating_food|Separating food]]====

====[[FCP:Preparing:Sourcing_receiving_storing|Sourcing, receiving and storing food]]====

====[[FCP:Preparing:Keeping_food_cold|Keeping food cold]]====

----

==Magenta Cards: Making + Cooking==

====[[FCP:Making_Cooking:Thoroughly_cooking_food|Thoroughly cooking food]]====

====[[FCP:Making_Cooking:Cooking_poultry_minced_liver|Cooking poultry, minced meat and liver]]====

====[[FCP:Making_Cooking:Proving_method|Proving the method you use works every time]]====

====[[FCP:Making_Cooking:Reheating_food|Reheating food]]====

====[[FCP:Making_Cooking:Cooling_freshly_cooked|Cooling freshly cooked food]]====

====[[FCP:Making_Cooking:Defrosting_food|Defrosting food]]====

====[[FCP:Making_Cooking:Water_activity|Using water activity to control bugs]]====

====[[FCP:Making_Cooking:Acid_control|Using acid to control bugs]]====

====[[FCP:Making_Cooking:Hot_smoking|Hot-smoking to control bugs]]====

----

==Orange Cards: Serving + Selling==

====[[FCP:Serving:Keeping_food_hot|Keeping food hot]]====

====[[FCP:Serving:Transporting_food|Transporting food]]====

====[[FCP:Serving:Displaying_food|Displaying food]]====

====[[FCP:Serving:Allergens|Knowing allergens]]====

====[[FCP:Serving:Labelling|Labelling food]]====

====[[FCP:Serving:B2B_Sales|B2B sales]]====

----

[[Template:SectionColors|Section Colors Reference]]

Consult the [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents User''s Guide] for information on using the wiki software.', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (245, 2850, '', 1, 'tt:245');

-- Create new revision for Main_Page
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1020, 1, 1, 1, NOW(), 0, 0, 2850, 187, '');

-- Create slot linking revision to content
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1020, 1, 245, 1020);

-- Update page record to point to new revision
UPDATE mediawiki.page
SET page_latest = 1020,
    page_len = 2850,
    page_touched = NOW()
WHERE page_id = 1;

COMMIT;

-- Verify
SELECT 'Main Page updated with all FCP sections' as result;
SELECT page_id, page_title, page_latest FROM mediawiki.page WHERE page_id = 1;
SELECT rev_id, rev_page FROM mediawiki.revision WHERE rev_id = 1020;
