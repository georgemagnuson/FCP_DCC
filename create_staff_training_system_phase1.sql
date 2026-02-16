-- =====================================================================
-- Staff Training System - Phase 1 Implementation
-- Database: PostgreSQL (MediaWiki)
-- Date: 2026-02-16
-- Status: Ready for Deployment
-- Purpose: Role-based staff training management with employee self-completion
--          and supervisor verification workflow
-- =====================================================================
--
-- Page ID Allocation: 370-390 (21 pages total)
-- Text IDs (old_id): 470-490
-- Revision IDs (rev_id): 1256-1276
-- Content IDs: 470-490
--
-- Components:
-- - 10 SMW Properties (370-379)
-- - 3 Category pages (386-388)
-- - 3 Form pages (380, 382, 384)
-- - 3 Template pages (381, 383, 385)
-- - 2 Portal pages (389-390)
--
-- Database: PostgreSQL compatible syntax
-- Tested with: MediaWiki 1.43.5 on PostgreSQL
--
-- =====================================================================

BEGIN;

-- =====================================================================
-- PART 1: SMW PROPERTIES (Pages 370-379)
-- =====================================================================
-- These properties enable semantic tracking of training data

-- PROPERTY 1: Has_employee_name (370)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (470, '[[Has type::Text]]

This property stores the name of the employee for training tracking purposes.

== Usage ==
<nowiki>[[Has_employee_name::John Smith]]</nowiki>

== Purpose ==
Enables queries to filter training records by specific employees and track individual progress.

[[Category:Training Properties]]
[[Category:Employee Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (470, 280, '', 1, 'tt:470');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1256, 370, 1, 1, NOW(), 0, 0, 280, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1256, 1, 470, 1256);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (370, 102, 'Property:Has employee name', 0, 1, RANDOM(), NOW(), 1256, 280);

-- PROPERTY 2: Has_assigned_role (371)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (471, '[[Has type::Text]]

This property stores the role assigned to an employee for training purposes.

== Usage ==
<nowiki>[[Has_assigned_role::Kitchen Staff]]</nowiki>
<nowiki>[[Has_assigned_role::Waitstaff]]</nowiki>
<nowiki>[[Has_assigned_role::Supervisor]]</nowiki>
<nowiki>[[Has_assigned_role::Trainer]]</nowiki>

== Allowed Values ==
* Kitchen Staff - Food preparation and handling roles
* Waitstaff - Customer-facing service roles
* Supervisor - Management and oversight roles
* Trainer - Training delivery roles

[[Category:Training Properties]]
[[Category:Role Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (471, 380, '', 1, 'tt:471');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1257, 371, 1, 1, NOW(), 0, 0, 380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1257, 1, 471, 1257);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (371, 102, 'Property:Has assigned role', 0, 1, RANDOM(), NOW(), 1257, 380);

-- PROPERTY 3: Has_training_section (372)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (472, '[[Has type::Page]]

This property links a training record to a specific FCP (Food Control Plan) section or page.

== Usage ==
<nowiki>[[Has_training_section::Food_Safety_Basics]]</nowiki>
<nowiki>[[Has_training_section::Temperature_Monitoring]]</nowiki>

== Purpose ==
Enables linking training records to the actual FCP documentation being studied. Allows tracking which sections employees have been trained on.

[[Category:Training Properties]]
[[Category:Content Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (472, 380, '', 1, 'tt:472');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1258, 372, 1, 1, NOW(), 0, 0, 380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1258, 1, 472, 1258);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (372, 102, 'Property:Has training section', 0, 1, RANDOM(), NOW(), 1258, 380);

-- PROPERTY 4: Has_completion_status (373)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (473, '[[Has type::Text]]

This property tracks the completion status of an employee training assignment.

== Usage ==
<nowiki>[[Has_completion_status::Not Started]]</nowiki>
<nowiki>[[Has_completion_status::In Progress]]</nowiki>
<nowiki>[[Has_completion_status::Completed]]</nowiki>
<nowiki>[[Has_completion_status::Verified]]</nowiki>

== Allowed Values ==
* Not Started - Training assigned but employee has not begun
* In Progress - Employee has started but not finished reading/study
* Completed - Employee has finished and submitted completion record
* Verified - Supervisor has verified employee understood the material

== Workflow ==
Not Started → In Progress → Completed → Verified

[[Category:Training Properties]]
[[Category:Status Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (473, 520, '', 1, 'tt:473');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1259, 373, 1, 1, NOW(), 0, 0, 520, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1259, 1, 473, 1259);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (373, 102, 'Property:Has completion status', 0, 1, RANDOM(), NOW(), 1259, 520);

-- PROPERTY 5: Has_verification_status (374)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (474, '[[Has type::Text]]

This property tracks whether a completed training has been verified by a supervisor.

== Usage ==
<nowiki>[[Has_verification_status::Not Verified]]</nowiki>
<nowiki>[[Has_verification_status::Verified]]</nowiki>

== Allowed Values ==
* Not Verified - Employee completed but supervisor has not yet verified
* Verified - Supervisor has reviewed and confirmed employee understanding

== Purpose ==
Distinguishes between employee-reported completion and official supervisor verification. Enables tracking of items pending verification.

[[Category:Training Properties]]
[[Category:Status Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (474, 420, '', 1, 'tt:474');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1260, 374, 1, 1, NOW(), 0, 0, 420, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1260, 1, 474, 1260);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (374, 102, 'Property:Has verification status', 0, 1, RANDOM(), NOW(), 1260, 420);

-- PROPERTY 6: Has_supervisor_name (375)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (475, '[[Has type::Text]]

This property records the name of the supervisor who verified employee training completion.

== Usage ==
<nowiki>[[Has_supervisor_name::Sarah Manager]]</nowiki>

== Purpose ==
Provides accountability and enables tracking of which supervisor verified which training. Used to identify patterns if specific supervisors need additional training themselves.

[[Category:Training Properties]]
[[Category:Staff Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (475, 330, '', 1, 'tt:475');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1261, 375, 1, 1, NOW(), 0, 0, 330, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1261, 1, 475, 1261);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (375, 102, 'Property:Has supervisor name', 0, 1, RANDOM(), NOW(), 1261, 330);

-- PROPERTY 7: Has_date_assigned (376)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (476, '[[Has type::Date]]

This property stores the date when training was assigned to an employee.

== Usage ==
<nowiki>[[Has_date_assigned::2026-02-16]]</nowiki>

== Format ==
ISO 8601 date format: YYYY-MM-DD

== Purpose ==
Enables tracking of how long training has been assigned and can help identify training overdue for completion.

[[Category:Training Properties]]
[[Category:Date Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (476, 330, '', 1, 'tt:476');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1262, 376, 1, 1, NOW(), 0, 0, 330, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1262, 1, 476, 1262);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (376, 102, 'Property:Has date assigned', 0, 1, RANDOM(), NOW(), 1262, 330);

-- PROPERTY 8: Has_date_completed (377)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (477, '[[Has type::Date]]

This property stores the date when an employee completed training reading/study.

== Usage ==
<nowiki>[[Has_date_completed::2026-02-20]]</nowiki>

== Format ==
ISO 8601 date format: YYYY-MM-DD

== Purpose ==
Tracks how long it took employee to complete training from assignment date.

[[Category:Training Properties]]
[[Category:Date Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (477, 310, '', 1, 'tt:477');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1263, 377, 1, 1, NOW(), 0, 0, 310, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1263, 1, 477, 1263);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (377, 102, 'Property:Has date completed', 0, 1, RANDOM(), NOW(), 1263, 310);

-- PROPERTY 9: Has_date_verified (378)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (478, '[[Has type::Date]]

This property stores the date when a supervisor verified employee training completion.

== Usage ==
<nowiki>[[Has_date_verified::2026-02-21]]</nowiki>

== Format ==
ISO 8601 date format: YYYY-MM-DD

== Purpose ==
Tracks supervisor verification timeline and enables identification of training records awaiting verification.

[[Category:Training Properties]]
[[Category:Date Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (478, 320, '', 1, 'tt:478');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1264, 378, 1, 1, NOW(), 0, 0, 320, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1264, 1, 478, 1264);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (378, 102, 'Property:Has date verified', 0, 1, RANDOM(), NOW(), 1264, 320);

-- PROPERTY 10: Has_demonstrated_understanding (379)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (479, '[[Has type::Boolean]]

This property records whether the employee demonstrated understanding of the training material during supervisor verification.

== Usage ==
<nowiki>[[Has_demonstrated_understanding::Yes]]</nowiki>
<nowiki>[[Has_demonstrated_understanding::No]]</nowiki>

== Purpose ==
Distinguishes between completion (reading the material) and demonstration of understanding (supervisor confirmed employee grasped the concepts). Enables supervisors to flag when additional training or clarification is needed.

[[Category:Training Properties]]
[[Category:Quality Properties]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (479, 440, '', 1, 'tt:479');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1265, 379, 1, 1, NOW(), 0, 0, 440, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1265, 1, 479, 1265);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (379, 102, 'Property:Has demonstrated understanding', 0, 1, RANDOM(), NOW(), 1265, 440);

-- =====================================================================
-- PART 2: CATEGORY PAGES (Pages 386-388)
-- =====================================================================

-- CATEGORY 1: Category:Training_Assignment (386)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (480, '= Training Assignment Records =

This category contains training assignment records created by supervisors or managers. Each record indicates which training has been assigned to which employee and when.

== Records in This Category ==

All training assignments are automatically categorized here via the Training Assignment template.

== Related Categories ==
* [[Category:Training_Completion|Training Completion Records]]
* [[Category:Training_Verification|Training Verification Records]]

[[Category:Training System]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (480, 340, '', 1, 'tt:480');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1266, 386, 1, 1, NOW(), 0, 0, 340, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1266, 1, 480, 1266);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (386, 14, 'Category:Training Assignment', 0, 1, RANDOM(), NOW(), 1266, 340);

-- CATEGORY 2: Category:Training_Completion (387)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (481, '= Training Completion Records =

This category contains records of employees marking their training sections as complete. Each record indicates an employee has finished reading/studying a specific FCP section.

== Records in This Category ==

All training completion entries are automatically categorized here via the Training Completion template.

== Related Categories ==
* [[Category:Training_Assignment|Training Assignment Records]]
* [[Category:Training_Verification|Training Verification Records]]

[[Category:Training System]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (481, 360, '', 1, 'tt:481');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1267, 387, 1, 1, NOW(), 0, 0, 360, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1267, 1, 481, 1267);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (387, 14, 'Category:Training Completion', 0, 1, RANDOM(), NOW(), 1267, 360);

-- CATEGORY 3: Category:Training_Verification (388)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (482, '= Training Verification Records =

This category contains records of supervisors verifying that employees have completed and understood their assigned training. Each record indicates a supervisor confirmation.

== Records in This Category ==

All training verification entries are automatically categorized here via the Training Verification template.

== Related Categories ==
* [[Category:Training_Assignment|Training Assignment Records]]
* [[Category:Training_Completion|Training Completion Records]]

[[Category:Training System]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (482, 360, '', 1, 'tt:482');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1268, 388, 1, 1, NOW(), 0, 0, 360, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1268, 1, 482, 1268);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (388, 14, 'Category:Training Verification', 0, 1, RANDOM(), NOW(), 1268, 360);

-- =====================================================================
-- PART 3: TEMPLATES (Pages 381, 383, 385)
-- =====================================================================

-- TEMPLATE 1: Template:Training_Assignment (381)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (483, '<noinclude>
This is a template for training assignment records created by supervisors.
Used by [[Form:Training_Assignment]] to display assigned training information.
</noinclude>

== Training Assignment ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name
| {{{employee_name|}}}
|-
| Assigned Roles
| {{{assigned_roles|}}}
|-
| Date Assigned
| {{{date_assigned|}}}
|-
| Assignment Notes
| {{{assignment_notes|}}}
|-
| Status
| {{{assignment_status|}}}
|}

[[Has_employee_name::{{{employee_name|}}}]]
[[Has_assigned_role::{{{assigned_roles|}}}]]
[[Has_date_assigned::{{{date_assigned|}}}]]
[[Has_record_type::Training Assignment]]
[[Category:Training_Assignment]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (483, 560, '', 1, 'tt:483');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1269, 381, 1, 1, NOW(), 0, 0, 560, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1269, 1, 483, 1269);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (381, 10, 'Template:Training_Assignment', 0, 1, RANDOM(), NOW(), 1269, 560);

-- TEMPLATE 2: Template:Training_Completion (383)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (484, '<noinclude>
This is a template for training completion records created by employees.
Used by [[Form:Training_Completion]] to display section completion information.
</noinclude>

== Training Completion ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name
| {{{employee_name|}}}
|-
| Training Section
| {{{section_link|}}}
|-
| Date Completed
| {{{date_completed|}}}
|}

[[Has_employee_name::{{{employee_name|}}}]]
[[Has_training_section::{{{section_link|}}}]]
[[Has_completion_status::Completed]]
[[Has_verification_status::Not Verified]]
[[Has_date_completed::{{{date_completed|}}}]]
[[Has_record_type::Training Completion]]
[[Category:Training_Completion]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (484, 520, '', 1, 'tt:484');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1270, 383, 1, 1, NOW(), 0, 0, 520, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1270, 1, 484, 1270);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (383, 10, 'Template:Training_Completion', 0, 1, RANDOM(), NOW(), 1270, 520);

-- TEMPLATE 3: Template:Training_Verification (385)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (485, '<noinclude>
This is a template for supervisor training verification records.
Used by [[Form:Supervisor_Verification]] to display verification information.
</noinclude>

== Training Verification ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name
| {{{employee_name|}}}
|-
| Training Section
| {{{section_title|}}}
|-
| Date Completed
| {{{date_completed|}}}
|-
| Date Verified
| {{{date_verified|}}}
|-
| Supervisor Name
| {{{supervisor_name|}}}
|-
| Understanding Demonstrated
| {{{understanding_checkbox|}}}
|-
| Supervisor Notes
| {{{supervisor_notes|}}}
|}

[[Has_employee_name::{{{employee_name|}}}]]
[[Has_training_section::{{{section_title|}}}]]
[[Has_completion_status::Verified]]
[[Has_verification_status::Verified]]
[[Has_supervisor_name::{{{supervisor_name|}}}]]
[[Has_date_verified::{{{date_verified|}}}]]
[[Has_demonstrated_understanding::{{{understanding_checkbox|}}}]]
[[Has_record_type::Training Verification]]
[[Category:Training_Verification]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (485, 760, '', 1, 'tt:485');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1271, 385, 1, 1, NOW(), 0, 0, 760, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1271, 1, 485, 1271);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (385, 10, 'Template:Training_Verification', 0, 1, RANDOM(), NOW(), 1271, 760);

-- =====================================================================
-- PART 4: FORMS (Pages 380, 382, 384)
-- =====================================================================

-- FORM 1: Form:Training_Assignment (380)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (486, '{{{for template|Training_Assignment|label=Assign Training to Employee}}}

== Training Assignment ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name (required)
| {{{field|employee_name|input type=combobox|mandatory}}}
|-
| Assigned Roles (select all that apply)
| {{{field|assigned_roles|input type=checkboxes|values=Kitchen Staff,Waitstaff,Supervisor,Trainer}}}
|-
| Date Assigned
| {{{field|date_assigned|input type=date|default={{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}}}}
|-
| Assignment Notes
| {{{field|assignment_notes|input type=textarea|rows=3|cols=50}}}
|-
| Status
| {{{field|assignment_status|input type=dropdown|values=Active,On Hold,Completed}}}
|}

{{{standard input|save}}} {{{standard input|cancel}}}

{{{end template}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (486, 740, '', 1, 'tt:486');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1272, 380, 1, 1, NOW(), 0, 0, 740, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1272, 1, 486, 1272);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (380, 106, 'Form:Training_Assignment', 0, 1, RANDOM(), NOW(), 1272, 740);

-- FORM 2: Form:Training_Completion (382)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (487, '{{{for template|Training_Completion|label=Mark Section Complete}}}

== Training Completion ==

{| class="wikitable"
|-
! Field !! Value
|-
| Training Section (required)
| {{{field|section_link|input type=text|mandatory|size=50}}}
|-
| Employee Name
| {{{field|employee_name|input type=text|size=40}}}
|-
| Completion Date
| {{{field|date_completed|input type=date|default={{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}}}}
|-
| I have completed reading this section
| {{{field|completion_checkbox|input type=checkbox}}}
|}

{{{standard input|save}}} {{{standard input|cancel}}}

{{{end template}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (487, 620, '', 1, 'tt:487');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1273, 382, 1, 1, NOW(), 0, 0, 620, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1273, 1, 487, 1273);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (382, 106, 'Form:Training_Completion', 0, 1, RANDOM(), NOW(), 1273, 620);

-- FORM 3: Form:Supervisor_Verification (384)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (488, '{{{for template|Training_Verification|label=Verify Employee Training}}}

== Supervisor Verification ==

{| class="wikitable"
|-
! Field !! Value
|-
| Employee Name (display only)
| {{{field|employee_name|input type=text|size=40}}}
|-
| Training Section (display only)
| {{{field|section_title|input type=text|size=50}}}
|-
| Date Completed (display only)
| {{{field|date_completed|input type=text|size=20}}}
|-
| Supervisor Name (required)
| {{{field|supervisor_name|input type=text|mandatory|size=40}}}
|-
| Date Verified
| {{{field|date_verified|input type=date|default={{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}}}}
|-
| I verified this training completion
| {{{field|verification_checkbox|input type=checkbox}}}
|-
| Employee demonstrated understanding
| {{{field|understanding_checkbox|input type=checkbox}}}
|-
| Supervisor Notes
| {{{field|supervisor_notes|input type=textarea|rows=3|cols=50}}}
|}

{{{standard input|save}}} {{{standard input|cancel}}}

{{{end template}}}', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (488, 940, '', 1, 'tt:488');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1274, 384, 1, 1, NOW(), 0, 0, 940, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1274, 1, 488, 1274);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (384, 106, 'Form:Supervisor_Verification', 0, 1, RANDOM(), NOW(), 1274, 940);

-- =====================================================================
-- PART 5: PORTAL PAGES (Pages 389-390)
-- =====================================================================

-- PORTAL 1: Employee_Training_Status (389)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (489, '= Your Training Progress =

Welcome to your training dashboard. View your assigned training and mark sections complete here.

== Assigned Training Sections ==

View your assigned training and complete your sections:

{{#ask: [[Category:Training_Assignment]]
       [[Has_employee_name::{{PAGENAME}}]]
 |?Has_assigned_role=Role
 |?Has_date_assigned=Assigned
 |?Has_completion_status=Status
 |format=broadtable
 |sort=Has_date_assigned
 |order=desc
 |default=No training assigned yet.
}}

== Mark Section Complete ==

{{#forminput:form=Training_Completion|button text=Mark Section Complete}}

== Your Completed Training ==

Training you have completed and verified:

{{#ask: [[Category:Training_Completion]]
       [[Has_employee_name::{{PAGENAME}}]]
       [[Has_verification_status::Verified]]
 |?Has_training_section=Section
 |?Has_date_completed=Completed
 |?Has_date_verified=Verified By
 |?Has_supervisor_name=Supervisor
 |format=broadtable
 |limit=50
 |default=No verified training records yet.
}}

== Pending Supervisor Verification ==

Training you completed but is awaiting supervisor verification:

{{#ask: [[Category:Training_Completion]]
       [[Has_employee_name::{{PAGENAME}}]]
       [[Has_verification_status::Not Verified]]
 |?Has_training_section=Section
 |?Has_date_completed=Completed On
 |format=broadtable
 |default=No pending verifications.
}}

[[Category:Training_Portal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (489, 1370, '', 1, 'tt:489');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1275, 389, 1, 1, NOW(), 0, 0, 1370, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1275, 1, 489, 1275);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (389, 0, 'Employee_Training_Status', 0, 1, RANDOM(), NOW(), 1275, 1370);

-- PORTAL 2: Supervisor_Training_Verification (390)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (490, '= Supervisor Training Verification Dashboard =

Review and verify employee training completions. Use this dashboard to manage the staff training verification workflow.

== Pending Verifications ==

Training sections awaiting your verification:

{{#ask: [[Category:Training_Completion]]
       [[Has_verification_status::Not Verified]]
 |?Has_employee_name=Employee
 |?Has_training_section=Section
 |?Has_date_completed=Completed On
 |format=broadtable
 |sort=Has_date_completed
 |order=asc
 |limit=100
 |default=No pending verifications.
}}

== Verify Training ==

{{#forminput:form=Supervisor_Verification|button text=Verify Employee Training}}

== Employee Progress by Role ==

=== Kitchen Staff ===

{{#ask: [[Category:Training_Assignment]]
       [[Has_assigned_role::Kitchen Staff]]
 |?Has_employee_name=Employee
 |?Has_date_assigned=Assigned
 |?Has_completion_status=Status
 |format=broadtable
 |limit=50
 |default=No Kitchen Staff training assigned.
}}

=== Waitstaff ===

{{#ask: [[Category:Training_Assignment]]
       [[Has_assigned_role::Waitstaff]]
 |?Has_employee_name=Employee
 |?Has_date_assigned=Assigned
 |?Has_completion_status=Status
 |format=broadtable
 |limit=50
 |default=No Waitstaff training assigned.
}}

=== Supervisors ===

{{#ask: [[Category:Training_Assignment]]
       [[Has_assigned_role::Supervisor]]
 |?Has_employee_name=Employee
 |?Has_date_assigned=Assigned
 |?Has_completion_status=Status
 |format=broadtable
 |limit=50
 |default=No Supervisor training assigned.
}}

== Recently Verified Training ==

Training you have recently verified:

{{#ask: [[Category:Training_Verification]]
 |?Has_employee_name=Employee
 |?Has_training_section=Section
 |?Has_date_verified=Verified On
 |?Has_supervisor_name=Verified By
 |?Has_demonstrated_understanding=Understanding
 |format=broadtable
 |sort=Has_date_verified
 |order=desc
 |limit=20
 |default=No verified training records.
}}

== Create New Assignment ==

{{#forminput:form=Training_Assignment|button text=Assign Training to Employee}}

[[Category:Training_Portal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (490, 2100, '', 1, 'tt:490');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1276, 390, 1, 1, NOW(), 0, 0, 2100, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1276, 1, 490, 1276);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (390, 0, 'Supervisor_Training_Verification', 0, 1, RANDOM(), NOW(), 1276, 2100);

COMMIT;

-- =====================================================================
-- VERIFICATION QUERIES (PostgreSQL)
-- =====================================================================
-- Run these queries after deployment to verify all pages were created:
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as total_pages FROM mediawiki.page
--    WHERE page_id BETWEEN 370 AND 390;"
-- Expected result: 21
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT page_id, page_namespace, page_title FROM mediawiki.page
--    WHERE page_id BETWEEN 370 AND 390
--    ORDER BY page_id;"
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as properties FROM mediawiki.page
--    WHERE page_namespace = 102
--    AND page_id BETWEEN 370 AND 379;"
-- Expected result: 10 properties
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as forms FROM mediawiki.page
--    WHERE page_namespace = 106
--    AND page_id IN (380, 382, 384);"
-- Expected result: 3 forms
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as templates FROM mediawiki.page
--    WHERE page_namespace = 10
--    AND page_id IN (381, 383, 385);"
-- Expected result: 3 templates
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as categories FROM mediawiki.page
--    WHERE page_namespace = 14
--    AND page_id IN (386, 387, 388);"
-- Expected result: 3 categories
--
-- psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
--   "SELECT COUNT(*) as portals FROM mediawiki.page
--    WHERE page_namespace = 0
--    AND page_id IN (389, 390);"
-- Expected result: 2 portals
