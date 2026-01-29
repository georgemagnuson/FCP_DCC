-- Purple (Closing) Section - 20 Pages Total (CORRECTED ID ALLOCATIONS)
-- 2 Content Pages (169-170) + 9 Templates (171-179 namespace 10) + 9 Forms (180-188 namespace 0)
-- Text IDs: 283-302 (20 entries)
-- Revision IDs: 1058-1077 (20 entries)
-- Categories: Purple:Closing

BEGIN;

-- ============================================================================
-- CONTENT PAGES (2 pages)
-- ============================================================================

-- ============================================================================
-- PAGE 169: FCP:Closing:Cleaning_up (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (283, 'FCP:Closing:Cleaning_up

== Know ==
* Cleaning and sanitising at the end of the day is crucial to prevent cross-contamination and the growth of harmful microorganisms
* Stock disposal must follow food safety protocols - waste food must be disposed of properly to prevent pest infestations and environmental contamination
* There is a difference between cleaning (removing dirt and food residues) and sanitising (killing harmful microorganisms)
* Surface cleaning requires appropriate chemicals and contact times to be effective
* Waste management includes segregation of different types of waste and proper disposal routes
* Clean laundry is essential for food safety - cloths and uniforms can harbor harmful bacteria
* Cleaning schedules and records demonstrate compliance with food safety requirements

== Do ==
* Conduct daily end-of-day stock checks and dispose of any expired, damaged or spoiled food items safely
* Segregate waste into appropriate categories: general waste, recyclable materials, and hazardous waste
* Remove large food residues from equipment and surfaces before washing
* Use appropriate cleaning agents and follow manufacturer instructions for dilution and contact time
* Sanitise all food contact surfaces with appropriate sanitiser (chemical, heat, or UV as applicable)
* Ensure all cleaning equipment (cloths, mops, brushes) is stored in clean, designated areas
* Launder food contact cloths daily and uniforms regularly in hot water
* Maintain a cleaning schedule showing what is cleaned, when, by whom, and how
* Keep records of all cleaning activities, including date, time, and person responsible
* Follow waste management regulations for your local area

== Show ==
* Daily cleaning logs showing what was cleaned, when, and by whom
* Stock disposal records for out-of-date or unsuitable food items
* Waste management records including segregation and disposal methods
* Records of cleaning product inventory and usage
* Evidence of staff training in cleaning and sanitising procedures', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (283, 1987, '', 1, 'tt:283');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1058, 169, 1, 1, NOW(), 0, 0, 1987, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1058, 1, 283, 1058);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (169, 0, 'FCP:Closing:Cleaning_up', 0, 1, RANDOM(), NOW(), 1058, 1987);

-- ============================================================================
-- PAGE 170: FCP:Closing:Equipment_facilities (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (284, 'FCP:Closing:Equipment_facilities

== Know ==
* Regular equipment and facilities maintenance is essential for food safety and prevents breakdowns
* Premises checks identify potential hazards such as pest entry points, structural damage, or hygiene issues
* Water systems require regular maintenance, testing, and documentation to ensure safe water supply
* Equipment calibration ensures that temperature and measurement controls are accurate
* Maintenance chemicals must be stored safely away from food and food contact surfaces
* Poor maintenance can lead to cross-contamination, equipment failure, and inability to control food safety hazards
* Documentation of maintenance activities provides evidence of compliance with food safety requirements
* Preventive maintenance is more cost-effective than reactive repairs

== Do ==
* Conduct daily end-of-day premises checks for:
  * Signs of pest activity (droppings, damage, entry points)
  * Structural integrity (cracks, holes, gaps)
  * Condition of floors, walls, and ceilings
  * Functionality of doors and seals
  * Proper functioning of ventilation systems
  * Water leaks or staining
* Establish a regular equipment maintenance schedule covering all food handling equipment
* Calibrate temperature monitoring equipment (thermometers, probes, cold storage monitoring) regularly
* Check water systems for integrity and contamination risk
* Inspect and maintain cleaning equipment regularly
* Ensure all maintenance chemicals are stored in locked cabinets away from food and food contact areas
* Label all maintenance chemicals clearly with contents and safety information
* Keep maintenance logs documenting:
  * Type of equipment maintained
  * Date and time of maintenance
  * Person who performed maintenance
  * Any issues identified and corrective actions taken
  * Calibration records and next calibration date
* Arrange for professional maintenance of specialized equipment according to manufacturer recommendations
* Keep equipment manuals and maintenance procedures readily accessible

== Show ==
* Daily premises inspection records
* Equipment maintenance schedules and logs
* Calibration records for measuring and monitoring equipment
* Water system maintenance and testing records
* Documentation of maintenance chemical inventory and storage
* Evidence of staff training in equipment operation and maintenance procedures', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (284, 2340, '', 1, 'tt:284');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1059, 170, 1, 1, NOW(), 0, 0, 2340, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1059, 1, 284, 1059);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (170, 0, 'FCP:Closing:Equipment_facilities', 0, 1, RANDOM(), NOW(), 1059, 2340);

-- ============================================================================
-- FORM PAGES (9 form pairs = 18 pages, IDs 171-188)
-- ============================================================================

-- ============================================================================
-- FORM 1: End_of_Day_Stock_Control
-- PAGE 171: Template:End_of_Day_Stock_Control (namespace 10)
-- PAGE 172: Form:End_of_Day_Stock_Control (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (285, '<noinclude>
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
| {{{date|}}}
| {{{item_name|}}}
| {{{opening_stock|}}}
| {{{used_sold|}}}
| {{{waste_disposed|}}}
| {{{closing_stock|}}}
| {{{expiry_status|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (285, 426, '', 1, 'tt:285');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1060, 171, 1, 1, NOW(), 0, 0, 426, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1060, 1, 285, 1060);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (171, 10, 'Template:End_of_Day_Stock_Control', 0, 1, RANDOM(), NOW(), 1060, 426);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (286, '<form>
{{{for template|End_of_Day_Stock_Control}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Item Name:
| <input type="text" name="item_name" size="30" />
|-
! Opening Stock Quantity:
| <input type="number" name="opening_stock" step="0.01" />
|-
! Stock Used/Sold:
| <input type="number" name="used_sold" step="0.01" />
|-
! Waste Disposed (quantity/weight):
| <input type="text" name="waste_disposed" size="30" />
|-
! Closing Stock Quantity:
| <input type="number" name="closing_stock" step="0.01" />
|-
! Expiry/Use-By Status:
| <select name="expiry_status"><option>Within date</option><option>Expired - Disposed</option><option>Damaged - Disposed</option><option>Unsuitable - Disposed</option></select>
|-
! Staff Member Conducting Count:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Stock_Control]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (286, 945, '', 1, 'tt:286');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1061, 172, 1, 1, NOW(), 0, 0, 945, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1061, 1, 286, 1061);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (172, 0, 'Form:End_of_Day_Stock_Control', 0, 1, RANDOM(), NOW(), 1061, 945);

-- ============================================================================
-- FORM 2: Daily_Cleaning_Sanitising_Log
-- PAGE 173: Template:Daily_Cleaning_Sanitising_Log (namespace 10)
-- PAGE 174: Form:Daily_Cleaning_Sanitising_Log (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (287, '<noinclude>
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
| {{{datetime|}}}
| {{{area_equipment|}}}
| {{{cleaning_method|}}}
| {{{sanitising_method|}}}
| {{{duration|}}}
| {{{pass_fail|}}}
| {{{corrective_actions|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (287, 500, '', 1, 'tt:287');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1062, 173, 1, 1, NOW(), 0, 0, 500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1062, 1, 287, 1062);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (173, 10, 'Template:Daily_Cleaning_Sanitising_Log', 0, 1, RANDOM(), NOW(), 1062, 500);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (288, '<form>
{{{for template|Daily_Cleaning_Sanitising_Log}}}
|-
! Date and Time:
| <input type="datetime-local" name="datetime" />
|-
! Area/Equipment Cleaned:
| <textarea name="area_equipment" rows="2" cols="40"></textarea>
|-
! Cleaning Method Used:
| <select name="cleaning_method"><option>Water and detergent</option><option>Degreaser</option><option>Acid cleaner</option><option>Other - specify</option></select>
|-
! Sanitising Method Used:
| <select name="sanitising_method"><option>Chemical sanitiser</option><option>Hot water (>82°C)</option><option>Steam</option><option>UV light</option><option>Not required - dry storage only</option></select>
|-
! Duration (minutes):
| <input type="number" name="duration" />
|-
! Result - Pass/Fail:
| <select name="pass_fail"><option>Pass</option><option>Fail</option><option>Partial - Corrective action taken</option></select>
|-
! Corrective Actions (if required):
| <textarea name="corrective_actions" rows="3" cols="40"></textarea>
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Cleaning_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (288, 1075, '', 1, 'tt:288');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1063, 174, 1, 1, NOW(), 0, 0, 1075, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1063, 1, 288, 1063);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (174, 0, 'Form:Daily_Cleaning_Sanitising_Log', 0, 1, RANDOM(), NOW(), 1063, 1075);

-- ============================================================================
-- FORM 3: Waste_Rubbish_Management
-- PAGE 175: Template:Waste_Rubbish_Management (namespace 10)
-- PAGE 176: Form:Waste_Rubbish_Management (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (289, '<noinclude>
This is a template for the Waste & Rubbish Management form.
</noinclude>

{| class="wikitable"
|-
! Date
! Waste Type
! Quantity
! Disposal Method
! Disposal Route
! Date Disposed
! Staff Verified
|-
| {{{date|}}}
| {{{waste_type|}}}
| {{{quantity|}}}
| {{{disposal_method|}}}
| {{{disposal_route|}}}
| {{{date_disposed|}}}
| {{{staff_verified|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (289, 460, '', 1, 'tt:289');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1064, 175, 1, 1, NOW(), 0, 0, 460, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1064, 1, 289, 1064);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (175, 10, 'Template:Waste_Rubbish_Management', 0, 1, RANDOM(), NOW(), 1064, 460);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (290, '<form>
{{{for template|Waste_Rubbish_Management}}}
|-
! Date of Waste Generation:
| <input type="date" name="date" />
|-
! Waste Type:
| <select name="waste_type"><option>General waste</option><option>Food waste</option><option>Recyclable materials</option><option>Hazardous waste</option><option>Cleaning product containers</option><option>Equipment waste</option><option>Other - specify</option></select>
|-
! Quantity Generated (kg or volume):
| <input type="text" name="quantity" size="30" />
|-
! Disposal Method:
| <select name="disposal_method"><option>Landfill</option><option>Recycling</option><option>Composting</option><option>Incineration</option><option>Licensed waste contractor</option><option>Other - specify</option></select>
|-
! Disposal Route/Contractor:
| <input type="text" name="disposal_route" size="40" />
|-
! Date Actually Disposed:
| <input type="date" name="date_disposed" />
|-
! Staff Member Verifying Disposal:
| <input type="text" name="staff_verified" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Waste_Management]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (290, 1020, '', 1, 'tt:290');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1065, 176, 1, 1, NOW(), 0, 0, 1020, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1065, 1, 290, 1065);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (176, 0, 'Form:Waste_Rubbish_Management', 0, 1, RANDOM(), NOW(), 1065, 1020);

-- ============================================================================
-- FORM 4: Equipment_Maintenance_Log
-- PAGE 177: Template:Equipment_Maintenance_Log (namespace 10)
-- PAGE 178: Form:Equipment_Maintenance_Log (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (291, '<noinclude>
This is a template for the Equipment Maintenance Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Equipment Name
! Model/Serial
! Maintenance Type
! Issues Identified
! Corrective Actions
! Next Maintenance Due
! Technician
|-
| {{{date|}}}
| {{{equipment_name|}}}
| {{{model_serial|}}}
| {{{maintenance_type|}}}
| {{{issues_identified|}}}
| {{{corrective_actions|}}}
| {{{next_maintenance|}}}
| {{{technician|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (291, 490, '', 1, 'tt:291');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1066, 177, 1, 1, NOW(), 0, 0, 490, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1066, 1, 291, 1066);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (177, 10, 'Template:Equipment_Maintenance_Log', 0, 1, RANDOM(), NOW(), 1066, 490);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (292, '<form>
{{{for template|Equipment_Maintenance_Log}}}
|-
! Date of Maintenance:
| <input type="date" name="date" />
|-
! Equipment Name:
| <input type="text" name="equipment_name" size="40" />
|-
! Model/Serial Number:
| <input type="text" name="model_serial" size="30" />
|-
! Maintenance Type:
| <select name="maintenance_type"><option>Preventive (scheduled)</option><option>Corrective (repair)</option><option>Calibration</option><option>Cleaning</option><option>Professional service</option><option>Other - specify</option></select>
|-
! Issues Identified:
| <textarea name="issues_identified" rows="3" cols="40"></textarea>
|-
! Corrective Actions Taken:
| <textarea name="corrective_actions" rows="3" cols="40"></textarea>
|-
! Next Maintenance Due Date:
| <input type="date" name="next_maintenance" />
|-
! Technician/Staff Member:
| <input type="text" name="technician" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Equipment_Maintenance]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (292, 1115, '', 1, 'tt:292');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1067, 178, 1, 1, NOW(), 0, 0, 1115, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1067, 1, 292, 1067);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (178, 0, 'Form:Equipment_Maintenance_Log', 0, 1, RANDOM(), NOW(), 1067, 1115);

-- ============================================================================
-- FORM 5: Premises_Condition_Inspection
-- PAGE 179: Template:Premises_Condition_Inspection (namespace 10)
-- PAGE 180: Form:Premises_Condition_Inspection (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (293, '<noinclude>
This is a template for the Premises Condition Inspection form.
</noinclude>

{| class="wikitable"
|-
! Date
! Pest Signs
! Structural Issues
! Cleanliness Assessment
! Ventilation Status
! Water Systems Status
! Corrective Actions
! Pass/Fail
! Inspector
|-
| {{{date|}}}
| {{{pest_signs|}}}
| {{{structural_issues|}}}
| {{{cleanliness|}}}
| {{{ventilation|}}}
| {{{water_systems|}}}
| {{{corrective_actions|}}}
| {{{pass_fail|}}}
| {{{inspector|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (293, 530, '', 1, 'tt:293');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1068, 179, 1, 1, NOW(), 0, 0, 530, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1068, 1, 293, 1068);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (179, 10, 'Template:Premises_Condition_Inspection', 0, 1, RANDOM(), NOW(), 1068, 530);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (294, '<form>
{{{for template|Premises_Condition_Inspection}}}
|-
! Date of Inspection:
| <input type="date" name="date" />
|-
! Signs of Pests (droppings, damage, entry points):
| <select name="pest_signs"><option>None observed</option><option>Possible entry points - Action required</option><option>Evidence of pest activity - Urgent action</option></select>
|-
! Structural Issues (cracks, holes, gaps, damage):
| <textarea name="structural_issues" rows="3" cols="40">Describe any structural concerns found...</textarea>
|-
! Overall Cleanliness Assessment:
| <select name="cleanliness"><option>Good - Acceptable</option><option>Fair - Minor issues to address</option><option>Poor - Significant cleaning required</option></select>
|-
! Ventilation System Status:
| <select name="ventilation"><option>Operational - Good air flow</option><option>Partially operational - Maintenance needed</option><option>Non-operational - Urgent repair</option></select>
|-
! Water Systems Status (pipes, taps, seals):
| <select name="water_systems"><option>Good condition - No leaks</option><option>Minor issues - Monitoring</option><option>Significant issues - Repair required</option></select>
|-
! Corrective Actions Required:
| <textarea name="corrective_actions" rows="3" cols="40"></textarea>
|-
! Overall Assessment - Pass/Fail:
| <select name="pass_fail"><option>Pass - Premises acceptable</option><option>Pass with actions - Monitor</option><option>Fail - Corrections required</option></select>
|-
! Inspector Name:
| <input type="text" name="inspector" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Premises_Inspection]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (294, 1365, '', 1, 'tt:294');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1069, 180, 1, 1, NOW(), 0, 0, 1365, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1069, 1, 294, 1069);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (180, 0, 'Form:Premises_Condition_Inspection', 0, 1, RANDOM(), NOW(), 1069, 1365);

-- ============================================================================
-- FORM 6: Calibration_Record
-- PAGE 181: Template:Calibration_Record (namespace 10)
-- PAGE 182: Form:Calibration_Record (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (295, '<noinclude>
This is a template for the Calibration Record form.
</noinclude>

{| class="wikitable"
|-
! Date
! Equipment Type
! Equipment ID
! Calibration Method
! Result - In/Out Tolerance
! Reference Standard Used
! Next Calibration Due
! Technician
|-
| {{{date|}}}
| {{{equipment_type|}}}
| {{{equipment_id|}}}
| {{{calibration_method|}}}
| {{{result|}}}
| {{{reference_standard|}}}
| {{{next_calibration|}}}
| {{{technician|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (295, 480, '', 1, 'tt:295');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1070, 181, 1, 1, NOW(), 0, 0, 480, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1070, 1, 295, 1070);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (181, 10, 'Template:Calibration_Record', 0, 1, RANDOM(), NOW(), 1070, 480);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (296, '<form>
{{{for template|Calibration_Record}}}
|-
! Date of Calibration:
| <input type="date" name="date" />
|-
! Equipment Type:
| <select name="equipment_type"><option>Thermometer (probe)</option><option>Thermometer (digital)</option><option>Thermometer (infrared)</option><option>Temperature data logger</option><option>Scales/Balances</option><option>pH meter</option><option>Other - specify</option></select>
|-
! Equipment ID/Serial Number:
| <input type="text" name="equipment_id" size="30" />
|-
! Calibration Method Used:
| <select name="calibration_method"><option>Two-point calibration</option><option>Single-point calibration</option><option>Professional laboratory calibration</option><option>Manufacturer calibration check</option><option>Other - specify</option></select>
|-
! Result - In or Out of Tolerance:
| <select name="result"><option>In tolerance - Acceptable</option><option>Out of tolerance - Adjusted</option><option>Out of tolerance - Equipment removed from service</option></select>
|-
! Reference Standard Used:
| <input type="text" name="reference_standard" size="40" />
|-
! Next Calibration Due Date:
| <input type="date" name="next_calibration" />
|-
! Technician/Person Conducting Calibration:
| <input type="text" name="technician" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Calibration_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (296, 1215, '', 1, 'tt:296');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1071, 182, 1, 1, NOW(), 0, 0, 1215, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1071, 1, 296, 1071);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (182, 0, 'Form:Calibration_Record', 0, 1, RANDOM(), NOW(), 1071, 1215);

-- ============================================================================
-- FORM 7: Water_System_Maintenance
-- PAGE 183: Template:Water_System_Maintenance (namespace 10)
-- PAGE 184: Form:Water_System_Maintenance (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (297, '<noinclude>
This is a template for the Water System Maintenance form.
</noinclude>

{| class="wikitable"
|-
! Date
! System Component
! Maintenance Type
! Findings
! Action Taken
! Water Quality OK?
! Next Maintenance Due
! Technician
|-
| {{{date|}}}
| {{{system_component|}}}
| {{{maintenance_type|}}}
| {{{findings|}}}
| {{{action_taken|}}}
| {{{water_quality|}}}
| {{{next_maintenance|}}}
| {{{technician|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (297, 460, '', 1, 'tt:297');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1072, 183, 1, 1, NOW(), 0, 0, 460, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1072, 1, 297, 1072);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (183, 10, 'Template:Water_System_Maintenance', 0, 1, RANDOM(), NOW(), 1072, 460);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (298, '<form>
{{{for template|Water_System_Maintenance}}}
|-
! Date of Maintenance:
| <input type="date" name="date" />
|-
! System Component Being Maintained:
| <select name="system_component"><option>Water tank</option><option>Inlet pipes</option><option>Distribution pipes</option><option>Filtration system</option><option>Taps/Dispensers</option><option>Hoses</option><option>Connections</option><option>Other - specify</option></select>
|-
! Type of Maintenance:
| <select name="maintenance_type"><option>Inspection</option><option>Cleaning</option><option>Filter replacement</option><option>Leak repair</option><option>Testing</option><option>Flushing/Disinfection</option><option>Professional service</option></select>
|-
! Findings:
| <textarea name="findings" rows="3" cols="40"></textarea>
|-
! Action Taken:
| <textarea name="action_taken" rows="3" cols="40"></textarea>
|-
! Water Quality - Acceptable for Food Use:
| <select name="water_quality"><option>Yes - Safe water</option><option>No - Further action needed</option><option>Requires boiling</option><option>Requires disinfection</option></select>
|-
! Next Maintenance Due Date:
| <input type="date" name="next_maintenance" />
|-
! Technician/Staff Member:
| <input type="text" name="technician" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Water_Systems]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (298, 1065, '', 1, 'tt:298');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1073, 184, 1, 1, NOW(), 0, 0, 1065, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1073, 1, 298, 1073);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (184, 0, 'Form:Water_System_Maintenance', 0, 1, RANDOM(), NOW(), 1073, 1065);

-- ============================================================================
-- FORM 8: Roof_Water_Supply_Checklist
-- PAGE 185: Template:Roof_Water_Supply_Checklist (namespace 10)
-- PAGE 186: Form:Roof_Water_Supply_Checklist (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (299, '<noinclude>
This is a template for the Roof Water Supply Checklist form.
</noinclude>

{| class="wikitable"
|-
! Date
! Roof Condition
! Guttering Condition
! Debris in Tank
! Water Discoloration
! Microbial Testing Done
! Treatment Applied
! Safe to Use?
! Inspector
|-
| {{{date|}}}
| {{{roof_condition|}}}
| {{{guttering_condition|}}}
| {{{debris_in_tank|}}}
| {{{discoloration|}}}
| {{{microbial_testing|}}}
| {{{treatment_applied|}}}
| {{{safe_to_use|}}}
| {{{inspector|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (299, 490, '', 1, 'tt:299');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1074, 185, 1, 1, NOW(), 0, 0, 490, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1074, 1, 299, 1074);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (185, 10, 'Template:Roof_Water_Supply_Checklist', 0, 1, RANDOM(), NOW(), 1074, 490);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (300, '<form>
{{{for template|Roof_Water_Supply_Checklist}}}
|-
! Date of Inspection:
| <input type="date" name="date" />
|-
! Roof Condition:
| <select name="roof_condition"><option>Good - No damage</option><option>Fair - Minor wear</option><option>Poor - Repairs needed</option><option>Has bird netting</option><option>No bird netting - Action required</option></select>
|-
! Guttering Condition:
| <select name="guttering_condition"><option>Clean and clear</option><option>Some debris - Cleaned</option><option>Blocked - Cleaning required</option><option>Damaged - Repair needed</option></select>
|-
! Debris in Tank:
| <select name="debris_in_tank"><option>None visible</option><option>Minor amount - Acceptable</option><option>Significant - Tank cleaning required</option></select>
|-
! Water Discoloration/Clarity:
| <select name="discoloration"><option>Clear and colorless</option><option>Slight discoloration - Monitor</option><option>Significant discoloration - Treatment</option></select>
|-
! Microbial Testing Completed:
| <select name="microbial_testing"><option>Yes - Results acceptable</option><option>Yes - Results concerning</option><option>Not yet due</option><option>Scheduled</option></select>
|-
! Treatment Applied (if required):
| <textarea name="treatment_applied" rows="2" cols="40"></textarea>
|-
! Water Safe to Use for Food:
| <select name="safe_to_use"><option>Yes - Safe to use</option><option>No - Do not use</option><option>Yes - After treatment only</option></select>
|-
! Inspector Name:
| <input type="text" name="inspector" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Water_Supply]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (300, 1215, '', 1, 'tt:300');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1075, 186, 1, 1, NOW(), 0, 0, 1215, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1075, 1, 300, 1075);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (186, 0, 'Form:Roof_Water_Supply_Checklist', 0, 1, RANDOM(), NOW(), 1075, 1215);

-- ============================================================================
-- FORM 9: Maintenance_Chemical_Safety
-- PAGE 187: Template:Maintenance_Chemical_Safety (namespace 10)
-- PAGE 188: Form:Maintenance_Chemical_Safety (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (301, '<noinclude>
This is a template for the Maintenance Chemical Safety form.
</noinclude>

{| class="wikitable"
|-
! Date
! Chemical Name
! Storage Location
! Quantity in Stock
! Expiry Date
! SDS Available?
! Proper Labeling?
! Staff Trained?
! Pass/Fail
|-
| {{{date|}}}
| {{{chemical_name|}}}
| {{{storage_location|}}}
| {{{quantity|}}}
| {{{expiry_date|}}}
| {{{sds_available|}}}
| {{{proper_labeling|}}}
| {{{staff_trained|}}}
| {{{pass_fail|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (301, 490, '', 1, 'tt:301');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1076, 187, 1, 1, NOW(), 0, 0, 490, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1076, 1, 301, 1076);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (187, 10, 'Template:Maintenance_Chemical_Safety', 0, 1, RANDOM(), NOW(), 1076, 490);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (302, '<form>
{{{for template|Maintenance_Chemical_Safety}}}
|-
! Date of Inspection:
| <input type="date" name="date" />
|-
! Chemical Product Name:
| <input type="text" name="chemical_name" size="40" />
|-
! Storage Location:
| <select name="storage_location"><option>Locked cabinet - Food area separated</option><option>Dedicated storage room</option><option>Outdoor storage shed</option><option>Other location - specify</option></select>
|-
! Quantity Currently in Stock:
| <input type="text" name="quantity" size="30" />
|-
! Expiry/Shelf-Life Date:
| <input type="date" name="expiry_date" />
|-
! Safety Data Sheet (SDS) Available:
| <select name="sds_available"><option>Yes - Available on site</option><option>Yes - Electronic copy stored</option><option>No - Request from supplier</option></select>
|-
! Proper Labeling on Container:
| <select name="proper_labeling"><option>Yes - Clear label</option><option>Partial - Label incomplete</option><option>No - Re-label required</option></select>
|-
! Relevant Staff Trained in Use:
| <select name="staff_trained"><option>Yes - All staff trained</option><option>Partial - Some staff trained</option><option>No - Training required</option></select>
|-
! Overall Assessment - Pass/Fail:
| <select name="pass_fail"><option>Pass - All requirements met</option><option>Fail - Corrective action required</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Purple:Closing]] [[Category:Chemical_Safety]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (302, 1165, '', 1, 'tt:302');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1077, 188, 1, 1, NOW(), 0, 0, 1165, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1077, 1, 302, 1077);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (188, 0, 'Form:Maintenance_Chemical_Safety', 0, 1, RANDOM(), NOW(), 1077, 1165);

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Verify all 20 pages created
SELECT 'Purple Closing Section Created: 20 Pages Total (2 content + 18 form pages)' as result;

-- Count total pages in ID range
SELECT COUNT(*) as total_pages_created FROM mediawiki.page WHERE page_id BETWEEN 169 AND 188;

-- List all created pages with details
SELECT page_id, page_namespace, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 169 AND 188
ORDER BY page_id;

-- Verify text entries
SELECT COUNT(*) as total_text_entries FROM mediawiki.text WHERE old_id BETWEEN 283 AND 302;

-- Verify revision entries
SELECT COUNT(*) as total_revisions FROM mediawiki.revision WHERE rev_id BETWEEN 1058 AND 1077;

-- Verify content entries
SELECT COUNT(*) as total_content_entries FROM mediawiki.content WHERE content_id BETWEEN 283 AND 302;

-- Verify slots entries
SELECT COUNT(*) as total_slots FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1058 AND 1077;

-- Summary statistics
SELECT
  (SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 169 AND 188) as pages,
  (SELECT COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 283 AND 302) as text_entries,
  (SELECT COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1058 AND 1077) as revisions,
  (SELECT COUNT(*) FROM mediawiki.content WHERE content_id BETWEEN 283 AND 302) as content_entries,
  (SELECT COUNT(*) FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1058 AND 1077) as slots
AS creation_summary;

-- Detailed page listing with namespace information
SELECT
  page_id,
  CASE page_namespace
    WHEN 0 THEN 'Article'
    WHEN 10 THEN 'Template'
    ELSE 'Other'
  END as namespace_name,
  page_title,
  page_len,
  page_latest as latest_revision_id
FROM mediawiki.page
WHERE page_id BETWEEN 169 AND 188
ORDER BY page_id;
