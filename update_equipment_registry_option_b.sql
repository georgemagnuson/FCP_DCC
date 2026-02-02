-- Equipment Registry System - Option B: Equipment Unit Pages with Direct References
-- Creates Equipment namespace pages and updates forms to use SMW page references
-- This enables semantic linking between Equipment Registry and Temperature Records

BEGIN;

-- ============================================================================
-- CREATE SMW PROPERTY: References_Equipment (Page reference)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (416, $$[[Has type::Page]]
[[Allows value::Equipment]]

This property links records (temperature readings, maintenance logs, etc.) to specific equipment units.
It creates a semantic reference to the Equipment namespace page for that unit.$$ , 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (416, 280, '', 1, 'tt:416');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1216, 321, 1, 1, NOW(), 0, 0, 280, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1216, 1, 416, 1216);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (321, 102, 'Property:References_Equipment', 0, 1, RANDOM(), NOW(), 1216, 280);

-- ============================================================================
-- UPDATE TEMPLATE: EquipmentRegistry to include SMW property
-- ============================================================================

UPDATE mediawiki.text
SET old_text = $$<noinclude>
This is a template for the Equipment Registry form tracking all temperature control equipment in the facility.
Stores semantic data for linking with temperature records and maintenance logs.
</noinclude>

{{#set: References_Equipment = {{{unit_number|}}} }}

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

__NOTOC__$$
WHERE old_id = 413;

-- ============================================================================
-- CREATE EQUIPMENT NAMESPACE PAGES (Common restaurant equipment)
-- ============================================================================

-- Equipment:FRIDGE-01
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (417, $$== Equipment Unit ==
* '''Unit Number:''' FRIDGE-01
* '''Equipment Type:''' Refrigerator
* '''Purpose:''' Cold holding (0-4°C)

[[Category:Equipment]] [[Category:Temperature_Control]] [[Category:Cold_Holding]]

== Linked Records ==
{{#ask: [[References_Equipment::Equipment:FRIDGE-01]] [[Has_temperature::+]] | limit=50 | sort=Has_submission_date | order=desc }}$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (417, 350, '', 1, 'tt:417');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1217, 322, 1, 1, NOW(), 0, 0, 350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1217, 1, 417, 1217);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (322, 100, 'Equipment:FRIDGE-01', 0, 1, RANDOM(), NOW(), 1217, 350);

-- Equipment:FREEZER-01
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (418, $$== Equipment Unit ==
* '''Unit Number:''' FREEZER-01
* '''Equipment Type:''' Freezer
* '''Purpose:''' Frozen food storage (-18°C or below)

[[Category:Equipment]] [[Category:Temperature_Control]] [[Category:Cold_Holding]]

== Linked Records ==
{{#ask: [[References_Equipment::Equipment:FREEZER-01]] [[Has_temperature::+]] | limit=50 | sort=Has_submission_date | order=desc }}$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (418, 350, '', 1, 'tt:418');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1218, 323, 1, 1, NOW(), 0, 0, 350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1218, 1, 418, 1218);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (323, 100, 'Equipment:FREEZER-01', 0, 1, RANDOM(), NOW(), 1218, 350);

-- Equipment:HOTBOX-01 (Hot holding equipment)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (419, $$== Equipment Unit ==
* '''Unit Number:''' HOTBOX-01
* '''Equipment Type:''' Hot Food Display/Holding Cabinet
* '''Purpose:''' Hot holding (65°C or above)

[[Category:Equipment]] [[Category:Temperature_Control]] [[Category:Hot_Holding]]

== Linked Records ==
{{#ask: [[References_Equipment::Equipment:HOTBOX-01]] [[Has_temperature::+]] | limit=50 | sort=Has_submission_date | order=desc }}$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (419, 350, '', 1, 'tt:419');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1219, 324, 1, 1, NOW(), 0, 0, 350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1219, 1, 419, 1219);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (324, 100, 'Equipment:HOTBOX-01', 0, 1, RANDOM(), NOW(), 1219, 350);

-- Equipment:DISPLAY-01 (Refrigerated display case)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (420, $$== Equipment Unit ==
* '''Unit Number:''' DISPLAY-01
* '''Equipment Type:''' Refrigerated Display Case
* '''Purpose:''' Cold display of ready-to-eat food (0-4°C)

[[Category:Equipment]] [[Category:Temperature_Control]] [[Category:Cold_Holding]]

== Linked Records ==
{{#ask: [[References_Equipment::Equipment:DISPLAY-01]] [[Has_temperature::+]] | limit=50 | sort=Has_submission_date | order=desc }}$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (420, 350, '', 1, 'tt:420');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1220, 325, 1, 1, NOW(), 0, 0, 350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1220, 1, 420, 1220);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (325, 100, 'Equipment:DISPLAY-01', 0, 1, RANDOM(), NOW(), 1220, 350);

-- ============================================================================
-- CREATE TEMPLATE: TemperatureRecording (Updated for Equipment references)
-- This template is used by Temperature Recording forms
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (421, $$<noinclude>
This is a template for the Temperature Recording form used in daily temperature monitoring.
Records are linked to specific equipment units via SMW references.
</noinclude>

{{#set: References_Equipment = {{{equipment_unit|}}} }}
{{#set: Has_submission_date = {{{date|}}} }}
{{#set: Has_temperature = {{{morning_temp|}}}, {{{evening_temp|}}} }}
{{#set: Has_temperature_unit = °C }}

{| class="wikitable"
|-
! Date
! Equipment Unit
! Morning Temperature (°C)
! Evening Temperature (°C)
! Action if Out of Range
|-
| {{{date|}}}
| {{{equipment_unit|}}}
| {{{morning_temp|}}}
| {{{evening_temp|}}}
| {{{action_if_out_of_range|}}}
|}

__NOTOC__$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (421, 600, '', 1, 'tt:421');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1221, 326, 1, 1, NOW(), 0, 0, 600, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1221, 1, 421, 1221);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (326, 10, 'Template:TemperatureRecording', 0, 1, RANDOM(), NOW(), 1221, 600);

-- ============================================================================
-- CREATE FORM: Temperature_Recording (Updated for Equipment references)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (422, $$<form>
{{{for template|TemperatureRecording}}}
! Date:
| <input type="date" name="date" required />
|-
! Equipment Unit:
| <select name="equipment_unit" required>
<option value="">Select Equipment Unit</option>
<option value="Equipment:FRIDGE-01">FRIDGE-01 - Main Refrigerator</option>
<option value="Equipment:FREEZER-01">FREEZER-01 - Main Freezer</option>
<option value="Equipment:HOTBOX-01">HOTBOX-01 - Hot Display Cabinet</option>
<option value="Equipment:DISPLAY-01">DISPLAY-01 - Refrigerated Display Case</option>
</select>
|-
! Morning Temperature (°C):
| <input type="number" name="morning_temp" step="0.1" required />
|-
! Evening Temperature (°C):
| <input type="number" name="evening_temp" step="0.1" required />
|-
! Action if Out of Range:
| <textarea name="action_if_out_of_range" rows="2" cols="40"></textarea>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Temperature_Records]] [[Category:Daily_Monitoring]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (422, 900, '', 1, 'tt:422');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1222, 327, 1, 1, NOW(), 0, 0, 900, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1222, 1, 422, 1222);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (327, 0, 'Form:Temperature_Recording', 0, 1, RANDOM(), NOW(), 1222, 900);

-- ============================================================================
-- CREATE MAIN EQUIPMENT NAMESPACE PAGE
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (423, $$== Equipment Registry ==

This namespace contains all registered temperature control equipment units at The Jitsu restaurant.

=== Current Equipment Units ===

* [[Equipment:FRIDGE-01]] - Main Refrigerator (0-4°C)
* [[Equipment:FREEZER-01]] - Main Freezer (-18°C or below)
* [[Equipment:HOTBOX-01]] - Hot Display Cabinet (65°C or above)
* [[Equipment:DISPLAY-01]] - Refrigerated Display Case (0-4°C)

=== Adding New Equipment ===

To add a new equipment unit:
1. Use [[Form:Equipment_Registry]] to record the equipment details
2. A new page will be created in this namespace automatically
3. Temperature records will automatically link to this equipment page

=== Equipment Records ===

All temperature monitoring records that reference specific equipment units will appear on the equipment page's "Linked Records" section, allowing you to:
* View all temperature readings for a specific unit
* Track equipment performance over time
* Identify temperature compliance issues
* Generate equipment-specific reports

[[Category:Equipment]]$$, 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (423, 1000, '', 1, 'tt:423');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1223, 328, 1, 1, NOW(), 0, 0, 1000, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1223, 1, 423, 1223);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (328, 100, 'Equipment', 0, 1, RANDOM(), NOW(), 1223, 1000);

COMMIT;
