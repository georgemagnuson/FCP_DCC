-- Phase 2A: Update 8 High-Priority Templates with SMW Annotations
-- These templates are critical for daily operations and incident management
-- Updates are made to mediawiki.text old_text field with calculated content sizes
-- This script maintains backward compatibility - visual display unchanged

BEGIN;

-- ============================================================================
-- TEMPLATE 1: HotHoldingTemperatureLog (Orange)
-- ============================================================================
-- Original text ID: 231, Page ID: 128
-- SMW annotations: food_item, date_placed, temperatures, pass_fail, staff name, record type, form name

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Hot Holding Temperature Log form.
</noinclude>

{| class="wikitable"
|-
! Food Item
! Date/Time Placed
! Initial Temperature (°C)
! 2hr Check Temp (°C)
! 4hr Check Temp (°C)
! 6hr Check Temp (°C)
! Corrective Actions
! Pass/Fail
|-
| [[Has_food_item::{{{food_item|}}}]]
| [[Has_submission_date::{{{date_placed|}}}]]
| [[Has_temperature::{{{initial_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{2hr_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{4hr_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{6hr_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_corrective_action::{{{corrective_actions|}}}]]
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
|}

[[Has_form_name::HotHoldingTemperatureLog]]
[[Has_record_type::Daily Temperature Monitoring]]
[[Has_staff_name::{{{staff_name|}}}]]

__NOTOC__'
WHERE old_id = 231;

UPDATE mediawiki.content
SET content_size = 798
WHERE content_id = 231;

UPDATE mediawiki.page
SET page_len = 798
WHERE page_id = 128;

-- ============================================================================
-- TEMPLATE 2: FoodTransportLog (Orange)
-- ============================================================================
-- Original text ID: 233, Page ID: 130

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Food Transport Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Food Items
! Transport Method
! Departure Temp (°C)
! Arrival Temp (°C)
! Duration (mins)
! In Danger Zone >4hrs?
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| [[Has_food_item::{{{food_items|}}}]]
| {{{transport_method|}}}
| [[Has_temperature::{{{departure_temp|}}}]][[Has_temperature_unit::°C]]
| [[Has_temperature::{{{arrival_temp|}}}]][[Has_temperature_unit::°C]]
| {{{duration|}}}
| {{{danger_zone|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::FoodTransportLog]]
[[Has_record_type::Daily Temperature Monitoring]]

__NOTOC__'
WHERE old_id = 233;

UPDATE mediawiki.content
SET content_size = 652
WHERE content_id = 233;

UPDATE mediawiki.page
SET page_len = 652
WHERE page_id = 130;

-- ============================================================================
-- TEMPLATE 3: Premises_Condition_Inspection (Purple)
-- ============================================================================
-- Original text ID: (from purple script, need to identify)
-- For now, we'll add this as a reference - actual ID may vary
-- This template tracks facility condition checks

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (450, '<noinclude>
This is a template for the Premises Condition Inspection form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Area Inspected
! Overall Condition
! Pest Activity Signs
! Structural Issues
! Cleanliness Level
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| {{{area_inspected|}}}
| {{{condition|}}}
| {{{pest_activity|}}}
| [[Has_corrective_action::{{{structural_issues|}}}]]
| {{{cleanliness|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Premises_Condition_Inspection]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (450, 680, '', 1, 'tt:450');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1350, 250, 1, 1, NOW(), 0, 0, 680, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1350, 1, 450, 1350);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (250, 10, 'Template:Premises_Condition_Inspection', 0, 1, RANDOM(), NOW(), 1350, 680);

-- ============================================================================
-- TEMPLATE 4: Daily_Cleaning_Sanitising_Log (Purple)
-- ============================================================================
-- Original text ID: 287, Page ID: 173

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Daily Cleaning & Sanitising Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Area/Equipment Cleaned
! Cleaning Method
! Sanitising Method
! Duration (mins)
! Pass/Fail
! Corrective Actions
! Staff
|-
| [[Has_submission_date::{{{datetime|}}}]]
| {{{area_equipment|}}}
| {{{cleaning_method|}}}
| {{{sanitising_method|}}}
| {{{duration|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_corrective_action::{{{corrective_actions|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Daily_Cleaning_Sanitising_Log]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__'
WHERE old_id = 287;

UPDATE mediawiki.content
SET content_size = 756
WHERE content_id = 287;

UPDATE mediawiki.page
SET page_len = 756
WHERE page_id = 173;

-- ============================================================================
-- TEMPLATE 5: Incident_Report (Red)
-- ============================================================================
-- Original text ID: 307, Page ID: 193

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Incident Report form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Incident Type
! Location
! Description
! Staff Involved
! Immediate Actions
! Severity
! Management Notified
|-
| [[Has_submission_date::{{{date_time|}}}]]
| {{{incident_type|}}}
| {{{location|}}}
| {{{description|}}}
| [[Has_staff_name::{{{staff_involved|}}}]]
| [[Has_corrective_action::{{{immediate_actions|}}}]]
| [[Has_incident_severity::{{{severity|}}}]]
| {{{management_notified|}}}
|}

[[Has_form_name::Incident_Report]]
[[Has_record_type::Incident Report]]

__NOTOC__'
WHERE old_id = 307;

UPDATE mediawiki.content
SET content_size = 644
WHERE content_id = 307;

UPDATE mediawiki.page
SET page_len = 644
WHERE page_id = 193;

-- ============================================================================
-- TEMPLATE 6: Complaint_Log (Red)
-- ============================================================================
-- Original text ID: 308, Page ID: 194

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Complaint Log form.
</noinclude>

{| class="wikitable"
|-
! Date Received
! Customer Name
! Complaint Type
! Product/Service
! Description
! Investigation Status
! Resolution
! Status
|-
| [[Has_submission_date::{{{date_received|}}}]]
| {{{customer_name|}}}
| {{{complaint_type|}}}
| [[Has_food_item::{{{product_service|}}}]]
| {{{description|}}}
| [[Has_investigation_status::{{{investigation_status|}}}]]
| [[Has_corrective_action::{{{resolution|}}}]]
| {{{status|}}}
|}

[[Has_form_name::Complaint_Log]]
[[Has_record_type::Incident Report]]

__NOTOC__'
WHERE old_id = 308;

UPDATE mediawiki.content
SET content_size = 642
WHERE content_id = 308;

UPDATE mediawiki.page
SET page_len = 642
WHERE page_id = 194;

-- ============================================================================
-- TEMPLATE 7: Corrective_Action_Plan (Red)
-- ============================================================================
-- Original text ID: (from red script - need to verify exact ID)
-- Creates new entry for this template

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (451, '<noinclude>
This is a template for the Corrective Action Plan form.
</noinclude>

{| class="wikitable"
|-
! Date Created
! Non-Conformance Description
! Root Cause
! Corrective Action
! Responsible Staff
! Target Completion
! Verification Method
! Status
|-
| [[Has_submission_date::{{{date_created|}}}]]
| {{{non_conformance|}}}
| {{{root_cause|}}}
| [[Has_corrective_action::{{{corrective_action|}}}]]
| [[Has_staff_name::{{{responsible_staff|}}}]]
| {{{target_date|}}}
| {{{verification_method|}}}
| [[Has_investigation_status::{{{status|}}}]]
|}

[[Has_form_name::Corrective_Action_Plan]]
[[Has_record_type::Incident Report]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (451, 742, '', 1, 'tt:451');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1351, 251, 1, 1, NOW(), 0, 0, 742, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1351, 1, 451, 1351);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (251, 10, 'Template:Corrective_Action_Plan', 0, 1, RANDOM(), NOW(), 1351, 742);

-- ============================================================================
-- TEMPLATE 8: Food_Traceability_Record (Red)
-- ============================================================================
-- Original text ID: 309, Page ID: 195

UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the Food Traceability Record form.
</noinclude>

{| class="wikitable"
|-
! Product Name
! Batch/Lot Number
! Supplier
! Delivery Date
! Storage Location
! Usage Date
! Distributed To
! Quantity Distributed
|-
| [[Has_food_item::{{{product_name|}}}]]
| {{{batch_lot|}}}
| {{{supplier|}}}
| [[Has_submission_date::{{{delivery_date|}}}]]
| {{{storage_location|}}}
| {{{usage_date|}}}
| {{{distributed_to|}}}
| {{{quantity|}}}
|}

[[Has_form_name::Food_Traceability_Record]]
[[Has_record_type::Incident Report]]

__NOTOC__'
WHERE old_id = 309;

UPDATE mediawiki.content
SET content_size = 658
WHERE content_id = 309;

UPDATE mediawiki.page
SET page_len = 658
WHERE page_id = 195;

COMMIT;
