-- Phase 2B: Update 12 Medium-Priority Templates with SMW Annotations
-- Specialist Foods (Teal: 6) + Maintenance (Purple: 4) + Additional Orange (2)
-- These templates cover specialist food handling procedures and equipment maintenance

BEGIN;

-- ============================================================================
-- SPECIALIST FOODS - TEAL SECTION (6 templates)
-- ============================================================================

-- TEMPLATE 1: Sushi_pH_Record (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (452, '<noinclude>
This is a template for the Sushi pH Record form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Rice Batch
! Rice Type (Acidified/Non-Acidified)
! pH Measurement
! pH Meter Calibration Date
! Cooling Method
! Temperature After Cooling
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| {{{rice_batch|}}}
| {{{rice_type|}}}
| [[Has_temperature::{{{ph_measurement|}}}]]
| {{{calibration_date|}}}
| {{{cooling_method|}}}
| [[Has_temperature::{{{temp_after_cooling|}}}]][[Has_temperature_unit::°C]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Sushi_pH_Record]]
[[Has_record_type::Specialist Procedures]]
[[Has_food_item::Sushi Rice]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (452, 696, '', 1, 'tt:452');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1352, 252, 1, 1, NOW(), 0, 0, 696, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1352, 1, 452, 1352);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (252, 10, 'Template:Sushi_pH_Record', 0, 1, RANDOM(), NOW(), 1352, 696);

-- TEMPLATE 2: Roast_Duck_Temperature_Log (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (453, '<noinclude>
This is a template for the Roast Duck Temperature Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Duck Batch
! Pre-Drying Temperature
! Start Drying Temperature
! Mid-Drying Temperature
! Final Temperature
! Drying Duration (mins)
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| {{{duck_batch|}}}
| [[Has_temperature::{{{pre_dry_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{start_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{mid_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{final_temp|}}}]][[Has_temperature_unit::°C]]
| {{{duration|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Roast_Duck_Temperature_Log]]
[[Has_record_type::Specialist Procedures]]
[[Has_food_item::Roasted Duck]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (453, 720, '', 1, 'tt:453');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1353, 253, 1, 1, NOW(), 0, 0, 720, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1353, 1, 453, 1353);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (253, 10, 'Template:Roast_Duck_Temperature_Log', 0, 1, RANDOM(), NOW(), 1353, 720);

-- TEMPLATE 3: Doner_Kebab_Cooking_Log (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (454, '<noinclude>
This is a template for the Doner Kebab Cooking Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Meat Type
! Start Temperature
! Final Temperature (Internal)
! Cooking Duration (mins)
! Service Temperature
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| [[Has_food_item::{{{meat_type|}}}]]
| [[Has_temperature::{{{start_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{final_temp|}}}]][[Has_temperature_unit::°C]]
| {{{duration|}}}
| [[Has_temperature::{{{service_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Doner_Kebab_Cooking_Log]]
[[Has_record_type::Specialist Procedures]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (454, 672, '', 1, 'tt:454');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1354, 254, 1, 1, NOW(), 0, 0, 672, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1354, 1, 454, 1354);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (254, 10, 'Template:Doner_Kebab_Cooking_Log', 0, 1, RANDOM(), NOW(), 1354, 672);

-- TEMPLATE 4: Sous_Vide_Cooking_Log (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (455, '<noinclude>
This is a template for the Sous Vide Cooking Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Meat Type
! Meat Weight (kg)
! Water Bath Temperature
! Cooking Duration (mins)
! Actual Temperature Maintained
! Thermometer Calibration
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| [[Has_food_item::{{{meat_type|}}}]]
| {{{weight|}}}
| [[Has_temperature::{{{water_temp|}}}]][[Has_temperature_unit::°C]]
| {{{duration|}}}
| [[Has_temperature::{{{actual_temp|}}}]][[Has_temperature_unit::°C]]
| {{{calibration_date|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Sous_Vide_Cooking_Log]]
[[Has_record_type::Specialist Procedures]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (455, 744, '', 1, 'tt:455');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1355, 255, 1, 1, NOW(), 0, 0, 744, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1355, 1, 455, 1355);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (255, 10, 'Template:Sous_Vide_Cooking_Log', 0, 1, RANDOM(), NOW(), 1355, 744);

-- TEMPLATE 5: Raw_Meat_Decontamination_Log (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (456, '<noinclude>
This is a template for the Raw Meat Decontamination Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Meat Type
! Decontamination Method
! Method Temperature/Details
! Duration (mins)
! Post-Treatment Temperature
! Decontamination Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| [[Has_food_item::{{{meat_type|}}}]]
| {{{method|}}}
| {{{method_details|}}}
| {{{duration|}}}
| [[Has_temperature::{{{post_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_pass_fail_status::{{{decontam_result|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Raw_Meat_Decontamination_Log]]
[[Has_record_type::Specialist Procedures]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (456, 680, '', 1, 'tt:456');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1356, 256, 1, 1, NOW(), 0, 0, 680, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1356, 1, 456, 1356);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (256, 10, 'Template:Raw_Meat_Decontamination_Log', 0, 1, RANDOM(), NOW(), 1356, 680);

-- TEMPLATE 6: Biltong_Production_Record (Teal)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (457, '<noinclude>
This is a template for the Biltong Production Record form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Meat Supplier
! Meat Weight (kg)
! Marinating Duration (hours)
! Drying Equipment
! Drying Temperature
! Drying Duration (hours)
! Final Water Activity
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| {{{supplier|}}}
| {{{weight|}}}
| {{{marinate_duration|}}}
| {{{drying_equipment|}}}
| [[Has_temperature::{{{drying_temp|}}}]][[Has_temperature_unit::°C]]
| {{{drying_duration|}}}
| {{{water_activity|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Biltong_Production_Record]]
[[Has_record_type::Specialist Procedures]]
[[Has_food_item::Biltong]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (457, 712, '', 1, 'tt:457');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1357, 257, 1, 1, NOW(), 0, 0, 712, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1357, 1, 457, 1357);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (257, 10, 'Template:Biltong_Production_Record', 0, 1, RANDOM(), NOW(), 1357, 712);

-- ============================================================================
-- MAINTENANCE - PURPLE SECTION (4 templates)
-- ============================================================================

-- TEMPLATE 7: Equipment_Maintenance_Log (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (458, '<noinclude>
This is a template for the Equipment Maintenance Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Equipment ID
! Maintenance Type
! Maintenance Description
! Issues Identified
! Corrective Actions
! Next Maintenance Date
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| [[Has_equipment_unit::{{{equipment_id|}}}]]
| {{{maintenance_type|}}}
| {{{description|}}}
| {{{issues_identified|}}}
| [[Has_corrective_action::{{{corrective_actions|}}}]]
| {{{next_date|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Equipment_Maintenance_Log]]
[[Has_record_type::Maintenance]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (458, 628, '', 1, 'tt:458');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1358, 258, 1, 1, NOW(), 0, 0, 628, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1358, 1, 458, 1358);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (258, 10, 'Template:Equipment_Maintenance_Log', 0, 1, RANDOM(), NOW(), 1358, 628);

-- TEMPLATE 8: Calibration_Record (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (459, '<noinclude>
This is a template for the Calibration Record form.
</noinclude>

{| class="wikitable"
|-
! Date
! Equipment ID
! Equipment Type
! Calibration Method
! Standard Used
! Before Calibration Reading
! After Calibration Reading
! Tolerance Pass/Fail
! Next Calibration Due
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| [[Has_equipment_unit::{{{equipment_id|}}}]]
| {{{equipment_type|}}}
| {{{calibration_method|}}}
| {{{standard_used|}}}
| {{{before_reading|}}}
| {{{after_reading|}}}
| [[Has_pass_fail_status::{{{tolerance_result|}}}]]
| {{{next_calibration|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Calibration_Record]]
[[Has_record_type::Maintenance]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (459, 696, '', 1, 'tt:459');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1359, 259, 1, 1, NOW(), 0, 0, 696, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1359, 1, 459, 1359);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (259, 10, 'Template:Calibration_Record', 0, 1, RANDOM(), NOW(), 1359, 696);

-- TEMPLATE 9: Water_System_Maintenance (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (460, '<noinclude>
This is a template for the Water System Maintenance form.
</noinclude>

{| class="wikitable"
|-
! Date
! Water System Component
! Maintenance Activity
! Chlorine Level Test (ppm)
! pH Test Result
! Temperature (°C)
! Issues Found
! Corrective Actions
! Next Maintenance
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| {{{component|}}}
| {{{activity|}}}
| {{{chlorine_level|}}}
| {{{ph_test|}}}
| [[Has_temperature::{{{temperature|}}}]][[Has_temperature_unit::°C]]
| {{{issues|}}}
| [[Has_corrective_action::{{{corrective_actions|}}}]]
| {{{next_maintenance|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Water_System_Maintenance]]
[[Has_record_type::Maintenance]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (460, 724, '', 1, 'tt:460');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1360, 260, 1, 1, NOW(), 0, 0, 724, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1360, 1, 460, 1360);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (260, 10, 'Template:Water_System_Maintenance', 0, 1, RANDOM(), NOW(), 1360, 724);

-- TEMPLATE 10: Roof_Water_Supply_Checklist (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (461, '<noinclude>
This is a template for the Roof Water Supply Checklist form.
</noinclude>

{| class="wikitable"
|-
! Date
! Tank Condition
! Inlet Filter Status
! Water Clarity
! Pest Entry Points Sealed?
! Maintenance Required
! Actions Taken
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| {{{tank_condition|}}}
| {{{filter_status|}}}
| {{{water_clarity|}}}
| {{{pest_sealed|}}}
| {{{maintenance_required|}}}
| [[Has_corrective_action::{{{actions_taken|}}}]]
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Roof_Water_Supply_Checklist]]
[[Has_record_type::Maintenance]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (461, 664, '', 1, 'tt:461');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1361, 261, 1, 1, NOW(), 0, 0, 664, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1361, 1, 461, 1361);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (261, 10, 'Template:Roof_Water_Supply_Checklist', 0, 1, RANDOM(), NOW(), 1361, 664);

-- ============================================================================
-- ADDITIONAL ORANGE SECTION (2 templates)
-- ============================================================================

-- TEMPLATE 11: LiveShellfishDisplayLog (Orange) - Already exists, update it
UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Live Shellfish Display Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Temperature (°C)
! Salinity (%)
! Water Changed
! Foreign Matter Removed
! Dead/Broken Removed
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| [[Has_temperature::{{{temperature|}}}]][[Has_temperature_unit::°C]]
| {{{salinity|}}}
| {{{water_changed|}}}
| {{{foreign_matter|}}}
| {{{dead_removed|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::LiveShellfishDisplayLog]]
[[Has_record_type::Daily Temperature Monitoring]]
[[Has_food_item::Live Shellfish]]

__NOTOC__'
WHERE old_id = 235;

UPDATE mediawiki.content
SET content_size = 614
WHERE content_id = 235;

UPDATE mediawiki.page
SET page_len = 614
WHERE page_id = 132;

-- TEMPLATE 12: SelfServiceDisplayChecklist (Orange)
UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Self-Service Display Checklist form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Food Items
! Use-By Date OK?
! Sneeze Guards OK?
! Utensils Clean?
! Temperature OK?
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| [[Has_food_item::{{{food_items|}}}]]
| {{{usebydate|}}}
| {{{sneeze_guards|}}}
| {{{utensils|}}}
| {{{temperature|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::SelfServiceDisplayChecklist]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__'
WHERE old_id = 237;

UPDATE mediawiki.content
SET content_size = 610
WHERE content_id = 237;

UPDATE mediawiki.page
SET page_len = 610
WHERE page_id = 134;

COMMIT;
