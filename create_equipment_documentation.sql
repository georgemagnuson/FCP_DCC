-- Equipment Registry Documentation and Navigation Pages
-- Creates documentation pages and links to Property:References_Equipment
-- Provides access to the equipment tracking system from Diary pages

BEGIN;

-- ============================================================================
-- CREATE: Equipment Registry Documentation Page
-- ============================================================================
-- This page serves as the hub for understanding how equipment is tracked
-- and how it links to temperature records and the diary system

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (424, $$== Equipment Registry System ==

This page documents how The Jitsu restaurant tracks temperature control equipment and links it to daily monitoring records through the [[Food Control Plan Diary]].

=== Quick Access ===

* [[Form:Equipment_Registry|Add or Update Equipment]] - Register new equipment units
* [[Form:Temperature_Recording|Record Daily Temperatures]] - Log temperature readings
* [[Property:References_Equipment|Equipment Reference Property]] - SMW property documentation
* [[Equipment|Equipment Namespace]] - View all registered equipment units

=== How It Works ===

==== Step 1: Register Equipment ====
Use [[Form:Equipment_Registry]] to create an entry for each piece of temperature-control equipment:
* Unit Number (e.g., FRIDGE-01)
* Equipment Type (Refrigerator, Freezer, Display Case, etc.)
* Location in the facility
* Purpose (Cold/Hot holding)
* Installation date

==== Step 2: Link Daily Temperature Records ====
When recording daily temperatures via [[Form:Temperature_Recording]]:
1. Select the equipment unit from the dropdown
2. Enter the morning and evening temperatures
3. The form automatically links the record to the equipment unit via [[Property:References_Equipment]]

==== Step 3: View Equipment Records ====
Each equipment page (e.g., [[Equipment:FRIDGE-01]]) displays:
* Equipment details and specifications
* All linked temperature readings (automatically sorted by date)
* Temperature compliance history
* Performance trends

=== Equipment Units Currently in Use ===

* [[Equipment:FRIDGE-01]] - Main Refrigerator (0-4°C)
* [[Equipment:FREEZER-01]] - Main Freezer (-18°C or below)
* [[Equipment:HOTBOX-01]] - Hot Display Cabinet (65°C or above)
* [[Equipment:DISPLAY-01]] - Refrigerated Display Case (0-4°C)

=== Adding New Equipment Units ===

When you register new equipment through the [[Form:Equipment_Registry]]:
1. A new page is created in the [[Equipment]] namespace automatically
2. Enter the unit number exactly as it will be used in daily monitoring forms
3. The temperature recording form will include the new unit in its dropdown

=== Semantic Data Structure ===

The equipment tracking system uses [[Property:References_Equipment]], a semantic property that:
* Creates a link from temperature records to equipment units
* Enables queries across all readings for a specific unit
* Powers the "Linked Records" section on equipment pages
* Supports Phase 3 Records Archive reporting and analytics

=== For Food Safety Inspectors ===

Inspectors can:
* View the complete [[Equipment|Equipment Registry]]
* Check temperature compliance for any piece of equipment
* Verify equipment maintenance and calibration records
* Generate equipment-specific compliance reports

[[Category:Equipment]] [[Category:Documentation]] [[Category:Food_Control_Diary]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (424, 3500, '', 1, 'tt:424');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1224, 329, 1, 1, NOW(), 0, 0, 3500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1224, 1, 424, 1224);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (329, 0, 'Equipment_Registry_Documentation', 0, 1, RANDOM(), NOW(), 1224, 3500);

-- ============================================================================
-- CREATE: Sidebar Navigation Page (for linking to equipment system)
-- ============================================================================
-- This page can be transcluded in sidebars to provide quick access to equipment system

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (425, $$== Equipment Management ==

* [[Equipment_Registry_Documentation|Equipment Registry Guide]]
* [[Form:Equipment_Registry|Register Equipment]]
* [[Form:Temperature_Recording|Daily Temperature Log]]
* [[Equipment|View All Equipment]]
* [[Property:References_Equipment|Equipment Reference Property]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (425, 350, '', 1, 'tt:425');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1225, 330, 1, 1, NOW(), 0, 0, 350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1225, 1, 425, 1225);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (330, 0, 'Template:Equipment_Navigation', 0, 1, RANDOM(), NOW(), 1225, 350);

-- ============================================================================
-- CREATE: Food Control Diary - Equipment Integration Page
-- ============================================================================
-- Explains the connection between the official MPI diary and the equipment system

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (426, $$== Food Control Plan Diary - Equipment Integration ==

This page documents how the '''Food Control Plan Diary''' (as defined by the Ministry for Primary Industries) integrates with The Jitsu's equipment tracking system.

=== Connection to Equipment Registry ===

Section 1 of the official MPI Food Control Plan Diary requires maintaining an '''equipment registry''' that lists all temperature control equipment. This is implemented through:

* [[Form:Equipment_Registry]] - The electronic form for documenting equipment
* [[Equipment|Equipment Namespace]] - Digital record storage for each equipment unit
* [[Property:References_Equipment]] - The semantic link connecting equipment to temperature records

=== Daily Diary Entries and Equipment ===

When completing daily diary checks (Section 2):
* Opening checks may verify equipment is operational
* Temperature recording specifically references which equipment unit was measured
* Each temperature entry is automatically linked to its equipment unit via [[Property:References_Equipment]]

=== Four-Week Review and Equipment ===

During the four-week management review (Section 5):
* Equipment changes are documented
* New equipment can be registered via [[Form:Equipment_Registry]]
* Equipment-specific temperature trends are reviewed via each equipment page
* Maintenance records are tracked with reference to specific units

=== Compliance Documentation ===

The integrated system provides:
* Complete equipment inventory (as required by MPI)
* Historical temperature data linked to specific equipment
* Maintenance and calibration records per unit
* Automatic compliance reporting by equipment

=== Accessing the Equipment System ===

* [[Equipment_Registry_Documentation|Equipment Registry Guide]] - Complete documentation
* [[Equipment|Browse All Equipment Units]] - View registered equipment
* [[Form:Equipment_Registry|Add/Update Equipment]] - Register new equipment
* [[Form:Temperature_Recording|Record Temperatures]] - Daily monitoring entry
* [[Property:References_Equipment|Property Documentation]] - Technical details

[[Category:Food_Control_Diary]] [[Category:Equipment]] [[Category:Documentation]] [[Category:Compliance]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (426, 2200, '', 1, 'tt:426');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1226, 331, 1, 1, NOW(), 0, 0, 2200, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1226, 1, 426, 1226);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (331, 0, 'Food_Control_Diary_Equipment_Integration', 0, 1, RANDOM(), NOW(), 1226, 2200);

-- ============================================================================
-- CREATE: Direct Link to Property:References_Equipment
-- ============================================================================
-- A simple redirect/reference page for easy access

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (427, $$#REDIRECT [[Property:References_Equipment]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (427, 45, '', 1, 'tt:427');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1227, 332, 1, 1, NOW(), 0, 0, 45, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1227, 1, 427, 1227);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (332, 0, 'Equipment_Reference_Property', 0, 1, RANDOM(), NOW(), 1227, 45);

COMMIT;
