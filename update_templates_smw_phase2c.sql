-- Phase 2C: Update 10 Remaining Templates with SMW Annotations
-- Purple (3) + Orange (3) + Red (4)
-- Final batch of templates to complete SMW property coverage for all 30 forms

BEGIN;

-- ============================================================================
-- PURPLE SECTION - REMAINING (3 templates)
-- ============================================================================

-- TEMPLATE 1: End_of_Day_Stock_Control (Purple) - Already exists, update it
UPDATE mediawiki.text
SET old_text = '<noinclude>
This is a template for the End-of-Day Stock Control form.
</noinclude>

{| class="wikitable"
|-
! Date
! Item Name
! Opening Stock
! Stock Used/Sold
! Waste Disposed
! Closing Stock
! Expiry Status
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| [[Has_food_item::{{{item_name|}}}]]
| {{{opening_stock|}}}
| {{{used_sold|}}}
| {{{waste_disposed|}}}
| {{{closing_stock|}}}
| {{{expiry_status|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::End_of_Day_Stock_Control]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__'
WHERE old_id = 285;

UPDATE mediawiki.content
SET content_size = 608
WHERE content_id = 285;

UPDATE mediawiki.page
SET page_len = 608
WHERE page_id = 171;

-- TEMPLATE 2: Waste_Rubbish_Management (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (462, '<noinclude>
This is a template for the Waste & Rubbish Management form.
</noinclude>

{| class="wikitable"
|-
! Date
! Waste Type
! Quantity/Volume
! Disposal Method
! Destination
! Disposal Date
! Disposal Company/Location
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| {{{waste_type|}}}
| {{{quantity|}}}
| {{{disposal_method|}}}
| {{{destination|}}}
| {{{disposal_date|}}}
| {{{disposal_company|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Waste_Rubbish_Management]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (462, 660, '', 1, 'tt:462');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1362, 262, 1, 1, NOW(), 0, 0, 660, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1362, 1, 462, 1362);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (262, 10, 'Template:Waste_Rubbish_Management', 0, 1, RANDOM(), NOW(), 1362, 660);

-- TEMPLATE 3: Maintenance_Chemical_Safety (Purple)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (463, '<noinclude>
This is a template for the Maintenance Chemical Safety form.
</noinclude>

{| class="wikitable"
|-
! Date
! Chemical Name
! Storage Location
! Container Condition
! Label Present?
! Safety Data Sheet Present?
! Lock/Seal Condition
! Pass/Fail
! Staff
|-
| [[Has_submission_date::{{{date|}}}]]
| {{{chemical_name|}}}
| {{{storage_location|}}}
| {{{container_condition|}}}
| {{{label_present|}}}
| {{{sds_present|}}}
| {{{lock_condition|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Maintenance_Chemical_Safety]]
[[Has_record_type::Weekly Inspection]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (463, 668, '', 1, 'tt:463');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1363, 263, 1, 1, NOW(), 0, 0, 668, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1363, 1, 463, 1363);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (263, 10, 'Template:Maintenance_Chemical_Safety', 0, 1, RANDOM(), NOW(), 1363, 668);

-- ============================================================================
-- ORANGE SECTION - REMAINING (3 templates)
-- ============================================================================

-- TEMPLATE 4: IngredientAllergenRegister (Orange)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (464, '<noinclude>
This is a template for the Ingredient Allergen Register form.
</noinclude>

{| class="wikitable"
|-
! Ingredient Name
! Supplier
! Allergens Present
! Date Added to Register
! Last Updated
! Update By
! Contact Supplier?
! Pass/Fail
|-
| [[Has_food_item::{{{ingredient_name|}}}]]
| {{{supplier|}}}
| {{{allergens|}}}
| [[Has_submission_date::{{{date_added|}}}]]
| {{{last_updated|}}}
| [[Has_staff_name::{{{updated_by|}}}]]
| {{{contact_supplier|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
|}

[[Has_form_name::IngredientAllergenRegister]]
[[Has_record_type::Monthly Audit]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (464, 632, '', 1, 'tt:464');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1364, 264, 1, 1, NOW(), 0, 0, 632, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1364, 1, 464, 1364);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (264, 10, 'Template:IngredientAllergenRegister', 0, 1, RANDOM(), NOW(), 1364, 632);

-- TEMPLATE 5: FoodLabelSpecifications (Orange)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (465, '<noinclude>
This is a template for the Food Label Specifications form.
</noinclude>

{| class="wikitable"
|-
! Product Name
! Label Content Accurate?
! Ingredient List Present?
! Allergen Declaration Present?
! Nutritional Information Present?
! Best Before Date Present?
! Storage Instructions Present?
! Pass/Fail
! Staff
|-
| [[Has_food_item::{{{product_name|}}}]]
| {{{content_accurate|}}}
| {{{ingredient_present|}}}
| {{{allergen_declared|}}}
| {{{nutrition_present|}}}
| {{{date_present|}}}
| {{{storage_present|}}}
| [[Has_pass_fail_status::{{{pass_fail|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::FoodLabelSpecifications]]
[[Has_record_type::Monthly Audit]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (465, 700, '', 1, 'tt:465');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1365, 265, 1, 1, NOW(), 0, 0, 700, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1365, 1, 465, 1365);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (265, 10, 'Template:FoodLabelSpecifications', 0, 1, RANDOM(), NOW(), 1365, 700);

-- TEMPLATE 6: B2BCustomerSupplyRegister (Orange)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (466, '<noinclude>
This is a template for the B2B Customer Supply Register form.
</noinclude>

{| class="wikitable"
|-
! Date Added
! Customer Name
! Products Supplied
! Supply Frequency
! Contact Person
! Last Contact Date
! Supply Current?
! Staff
|-
| [[Has_submission_date::{{{date_added|}}}]]
| {{{customer_name|}}}
| [[Has_food_item::{{{products|}}}]]
| {{{supply_frequency|}}}
| {{{contact_person|}}}
| {{{last_contact|}}}
| {{{supply_current|}}}
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::B2BCustomerSupplyRegister]]
[[Has_record_type::Monthly Audit]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (466, 616, '', 1, 'tt:466');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1366, 266, 1, 1, NOW(), 0, 0, 616, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1366, 1, 466, 1366);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (266, 10, 'Template:B2BCustomerSupplyRegister', 0, 1, RANDOM(), NOW(), 1366, 616);

-- ============================================================================
-- RED SECTION - REMAINING (4 templates)
-- ============================================================================

-- TEMPLATE 7: Recall_Notification (Red)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (467, '<noinclude>
This is a template for the Recall Notification form.
</noinclude>

{| class="wikitable"
|-
! Recall Date
! Product Name
! Batch/Lot Numbers
! Reason for Recall
! Severity Level
! Affected Customers
! Notification Method
! Response Status
! Staff
|-
| [[Has_submission_date::{{{recall_date|}}}]]
| [[Has_food_item::{{{product_name|}}}]]
| {{{batch_lot|}}}
| {{{reason|}}}
| [[Has_incident_severity::{{{severity|}}}]]
| {{{affected_customers|}}}
| {{{notification_method|}}}
| [[Has_investigation_status::{{{response_status|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Recall_Notification]]
[[Has_record_type::Incident Report]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (467, 660, '', 1, 'tt:467');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1367, 267, 1, 1, NOW(), 0, 0, 660, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1367, 1, 467, 1367);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (267, 10, 'Template:Recall_Notification', 0, 1, RANDOM(), NOW(), 1367, 660);

-- TEMPLATE 8: Regulatory_Report (Red)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (468, '<noinclude>
This is a template for the Regulatory Report form.
</noinclude>

{| class="wikitable"
|-
! Report Date
! Regulatory Authority
! Issue/Concern
! Severity
! Investigation Required?
! Response Due Date
! Response Sent?
! Status
! Staff
|-
| [[Has_submission_date::{{{report_date|}}}]]
| {{{authority|}}}
| {{{issue|}}}
| [[Has_incident_severity::{{{severity|}}}]]
| {{{investigation_required|}}}
| {{{due_date|}}}
| {{{response_sent|}}}
| [[Has_investigation_status::{{{status|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Regulatory_Report]]
[[Has_record_type::Incident Report]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (468, 628, '', 1, 'tt:468');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1368, 268, 1, 1, NOW(), 0, 0, 628, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1368, 1, 468, 1368);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (268, 10, 'Template:Regulatory_Report', 0, 1, RANDOM(), NOW(), 1368, 628);

-- TEMPLATE 9: Root_Cause_Analysis (Red)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (469, '<noinclude>
This is a template for the Root Cause Analysis form.
</noinclude>

{| class="wikitable"
|-
! Analysis Date
! Incident Reference
! Problem Statement
! Root Cause Identified
! Contributing Factors
! Preventive Actions
! Responsible Staff
! Target Completion
! Status
|-
| [[Has_submission_date::{{{analysis_date|}}}]]
| {{{incident_ref|}}}
| {{{problem_statement|}}}
| {{{root_cause|}}}
| {{{factors|}}}
| [[Has_corrective_action::{{{preventive_actions|}}}]]
| [[Has_staff_name::{{{responsible_staff|}}}]]
| {{{target_date|}}}
| [[Has_investigation_status::{{{status|}}}]]
|}

[[Has_form_name::Root_Cause_Analysis]]
[[Has_record_type::Incident Report]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (469, 672, '', 1, 'tt:469');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1369, 269, 1, 1, NOW(), 0, 0, 672, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1369, 1, 469, 1369);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (269, 10, 'Template:Root_Cause_Analysis', 0, 1, RANDOM(), NOW(), 1369, 672);

-- TEMPLATE 10: Investigation_Log (Red)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (470, '<noinclude>
This is a template for the Investigation Log form.
</noinclude>

{| class="wikitable"
|-
! Investigation Date
! Incident Reference
! Investigation Type
! Findings
! Evidence Collected
! Interviews Conducted
! Next Steps
! Investigation Status
! Staff
|-
| [[Has_submission_date::{{{investigation_date|}}}]]
| {{{incident_ref|}}}
| {{{investigation_type|}}}
| {{{findings|}}}
| {{{evidence|}}}
| {{{interviews|}}}
| [[Has_corrective_action::{{{next_steps|}}}]]
| [[Has_investigation_status::{{{investigation_status|}}}]]
| [[Has_staff_name::{{{staff|}}}]]
|}

[[Has_form_name::Investigation_Log]]
[[Has_record_type::Incident Report]]

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (470, 680, '', 1, 'tt:470');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1370, 270, 1, 1, NOW(), 0, 0, 680, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1370, 1, 470, 1370);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (270, 10, 'Template:Investigation_Log', 0, 1, RANDOM(), NOW(), 1370, 680);

COMMIT;
