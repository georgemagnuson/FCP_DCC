-- Purple (Closing) Section - 20 Pages Total
-- 2 Content Pages (142-143) + 9 Form Templates (144-152) + 9 Form Pages (153-161)
-- Text IDs: 245-264, Revision IDs: 1020-1039
-- Categories: Purple:Closing

BEGIN;

-- ============================================================================
-- CONTENT PAGES (2 pages)
-- ============================================================================

-- ============================================================================
-- PAGE 142: FCP:Closing:Cleaning_up
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (245, 'FCP:Closing:Cleaning_up

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
VALUES (245, 2247, '', 1, 'tt:245');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1020, 142, 1, 1, NOW(), 0, 0, 2247, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1020, 1, 245, 1020);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (142, 0, 'FCP:Closing:Cleaning_up', 0, 1, RANDOM(), NOW(), 1020, 2247);

-- ============================================================================
-- PAGE 143: FCP:Closing:Equipment_facilities
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (246, 'FCP:Closing:Equipment_facilities

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
VALUES (246, 2348, '', 1, 'tt:246');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1021, 143, 1, 1, NOW(), 0, 0, 2348, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1021, 1, 246, 1021);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (143, 0, 'FCP:Closing:Equipment_facilities', 0, 1, RANDOM(), NOW(), 1021, 2348);

-- ============================================================================
-- FORM PAGES (9 form pairs = 18 pages, IDs 144-161)
-- ============================================================================

-- ============================================================================
-- FORM 1: End-of-Day Stock Control
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (247, '<noinclude>
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
VALUES (247, 450, '', 1, 'tt:247');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1022, 144, 1, 1, NOW(), 0, 0, 450, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1022, 1, 247, 1022);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (144, 10, 'Template:EndOfDayStockControl', 0, 1, RANDOM(), NOW(), 1022, 450);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (248, '<form>
{{{for template|EndOfDayStockControl}}}
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
VALUES (248, 900, '', 1, 'tt:248');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1023, 153, 1, 1, NOW(), 0, 0, 900, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1023, 1, 248, 1023);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (153, 0, 'Form:EndOfDayStockControl', 0, 1, RANDOM(), NOW(), 1023, 900);

-- ============================================================================
-- FORM 2: Daily Cleaning & Sanitising Log
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (249, '<noinclude>
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
VALUES (249, 500, '', 1, 'tt:249');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1024, 145, 1, 1, NOW(), 0, 0, 500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1024, 1, 249, 1024);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (145, 10, 'Template:DailyCleaningSanitising', 0, 1, RANDOM(), NOW(), 1024, 500);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (250, '<form>
{{{for template|DailyCleaningSanitising}}}
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
VALUES (250, 1050, '', 1, 'tt:250');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1025, 154, 1, 1, NOW(), 0, 0, 1050, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1025, 1, 250, 1025);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (154, 0, 'Form:DailyCleaningSanitising', 0, 1, RANDOM(), NOW(), 1025, 1050);

-- ============================================================================
-- FORM 3: Waste Management Record
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (251, '<noinclude>
This is a template for the Waste Management Record form.
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
VALUES (251, 450, '', 1, 'tt:251');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1026, 146, 1, 1, NOW(), 0, 0, 450, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1026, 1, 251, 1026);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (146, 10, 'Template:WasteManagementRecord', 0, 1, RANDOM(), NOW(), 1026, 450);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (252, '<form>
{{{for template|WasteManagementRecord}}}
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
VALUES (252, 1000, '', 1, 'tt:252');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1027, 155, 1, 1, NOW(), 0, 0, 1000, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1027, 1, 252, 1027);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (155, 0, 'Form:WasteManagementRecord', 0, 1, RANDOM(), NOW(), 1027, 1000);

-- ============================================================================
-- FORM 4: Equipment Maintenance Log
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (253, '<noinclude>
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
VALUES (253, 480, '', 1, 'tt:253');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1028, 147, 1, 1, NOW(), 0, 0, 480, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1028, 1, 253, 1028);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (147, 10, 'Template:EquipmentMaintenanceLog', 0, 1, RANDOM(), NOW(), 1028, 480);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (254, '<form>
{{{for template|EquipmentMaintenanceLog}}}
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
VALUES (254, 1100, '', 1, 'tt:254');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1029, 156, 1, 1, NOW(), 0, 0, 1100, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1029, 1, 254, 1029);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (156, 0, 'Form:EquipmentMaintenanceLog', 0, 1, RANDOM(), NOW(), 1029, 1100);

-- ============================================================================
-- FORM 5: Premises Condition Inspection
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (255, '<noinclude>
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
VALUES (255, 520, '', 1, 'tt:255');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1030, 148, 1, 1, NOW(), 0, 0, 520, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1030, 1, 255, 1030);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (148, 10, 'Template:PremisesConditionInspection', 0, 1, RANDOM(), NOW(), 1030, 520);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (256, '<form>
{{{for template|PremisesConditionInspection}}}
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
VALUES (256, 1350, '', 1, 'tt:256');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1031, 157, 1, 1, NOW(), 0, 0, 1350, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1031, 1, 256, 1031);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (157, 0, 'Form:PremisesConditionInspection', 0, 1, RANDOM(), NOW(), 1031, 1350);

-- ============================================================================
-- FORM 6: Calibration Record
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (257, '<noinclude>
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
VALUES (257, 470, '', 1, 'tt:257');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1032, 149, 1, 1, NOW(), 0, 0, 470, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1032, 1, 257, 1032);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (149, 10, 'Template:CalibrationRecord', 0, 1, RANDOM(), NOW(), 1032, 470);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (258, '<form>
{{{for template|CalibrationRecord}}}
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
VALUES (258, 1200, '', 1, 'tt:258');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1033, 158, 1, 1, NOW(), 0, 0, 1200, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1033, 1, 258, 1033);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (158, 0, 'Form:CalibrationRecord', 0, 1, RANDOM(), NOW(), 1033, 1200);

-- ============================================================================
-- FORM 7: Water System Maintenance
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (259, '<noinclude>
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
VALUES (259, 450, '', 1, 'tt:259');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1034, 150, 1, 1, NOW(), 0, 0, 450, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1034, 1, 259, 1034);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (150, 10, 'Template:WaterSystemMaintenance', 0, 1, RANDOM(), NOW(), 1034, 450);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (260, '<form>
{{{for template|WaterSystemMaintenance}}}
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
VALUES (260, 1050, '', 1, 'tt:260');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1035, 159, 1, 1, NOW(), 0, 0, 1050, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1035, 1, 260, 1035);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (159, 0, 'Form:WaterSystemMaintenance', 0, 1, RANDOM(), NOW(), 1035, 1050);

-- ============================================================================
-- FORM 8: Roof Water Supply Checklist
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (261, '<noinclude>
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
VALUES (261, 480, '', 1, 'tt:261');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1036, 151, 1, 1, NOW(), 0, 0, 480, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1036, 1, 261, 1036);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (151, 10, 'Template:RoofWaterSupplyChecklist', 0, 1, RANDOM(), NOW(), 1036, 480);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (262, '<form>
{{{for template|RoofWaterSupplyChecklist}}}
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
VALUES (262, 1200, '', 1, 'tt:262');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1037, 160, 1, 1, NOW(), 0, 0, 1200, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1037, 1, 262, 1037);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (160, 0, 'Form:RoofWaterSupplyChecklist', 0, 1, RANDOM(), NOW(), 1037, 1200);

-- ============================================================================
-- FORM 9: Maintenance Chemical Safety
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (263, '<noinclude>
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
VALUES (263, 480, '', 1, 'tt:263');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1038, 152, 1, 1, NOW(), 0, 0, 480, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1038, 1, 263, 1038);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (152, 10, 'Template:MaintenanceChemicalSafety', 0, 1, RANDOM(), NOW(), 1038, 480);

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (264, '<form>
{{{for template|MaintenanceChemicalSafety}}}
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
VALUES (264, 1150, '', 1, 'tt:264');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1039, 161, 1, 1, NOW(), 0, 0, 1150, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1039, 1, 264, 1039);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (161, 0, 'Form:MaintenanceChemicalSafety', 0, 1, RANDOM(), NOW(), 1039, 1150);

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

SELECT 'Purple Closing Section Created: 20 Pages Total (2 content + 18 form pages)' as result;
SELECT COUNT(*) as total_pages FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161;
SELECT page_id, page_namespace, page_title FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161 ORDER BY page_id;
SELECT COUNT(*) as total_text_entries FROM mediawiki.text WHERE old_id BETWEEN 245 AND 264;
SELECT COUNT(*) as total_revisions FROM mediawiki.revision WHERE rev_id BETWEEN 1020 AND 1039;
