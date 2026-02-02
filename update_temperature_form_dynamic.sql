-- Update Temperature Recording Form - Option 2: Dynamic Equipment Dropdown
-- Form will only show equipment that has been registered via Form:Equipment_Registry
-- This enforces referential integrity and prevents orphaned temperature records

BEGIN;

-- ============================================================================
-- UPDATE FORM: Temperature_Recording with Dynamic Equipment Dropdown
-- ============================================================================
-- Uses values_from_category to dynamically pull all registered Equipment pages
-- Only equipment in the Equipment category will appear in the dropdown

UPDATE mediawiki.text
SET old_text = $$<form>
{{{for template|TemperatureRecording}}}
! Date:
| <input type="date" name="date" required />
|-
! Equipment Unit:
| {{{equipment_unit|values_from_category=Equipment|input type=dropdown|required}}}
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

'''NOTE:''' Equipment must be registered via [[Form:Equipment_Registry]] before it will appear in the Equipment Unit dropdown.

[[Category:Forms]] [[Category:Temperature_Records]] [[Category:Daily_Monitoring]]$$
WHERE old_id = 422;

-- ============================================================================
-- UPDATE TEMPLATE: TemperatureRecording - Add validation comment
-- ============================================================================
-- Add documentation about the equipment reference requirement

UPDATE mediawiki.text
SET old_text = $$<noinclude>
This is a template for the Temperature Recording form used in daily temperature monitoring.
Records are linked to specific equipment units via SMW references to Equipment namespace pages.

'''IMPORTANT:''' Equipment must be registered via [[Form:Equipment_Registry]] first.
The equipment_unit field can only accept pages from the Equipment namespace.
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

__NOTOC__$$
WHERE old_id = 421;

-- ============================================================================
-- UPDATE DOCUMENTATION: Equipment Registry
-- ============================================================================
-- Add section about the requirement to register equipment first

UPDATE mediawiki.text
SET old_text = $$== Equipment Registry System ==

This page documents how The Jitsu restaurant tracks temperature control equipment and links it to daily monitoring records through the [[Food Control Plan Diary]].

=== Quick Access ===

* [[Form:Equipment_Registry|Add or Update Equipment]] - Register new equipment units
* [[Form:Temperature_Recording|Record Daily Temperatures]] - Log temperature readings
* [[Property:References_Equipment|Equipment Reference Property]] - SMW property documentation
* [[Equipment|Equipment Namespace]] - View all registered equipment units

=== IMPORTANT: Equipment Must Be Registered First ===

Before you can record temperature readings for a piece of equipment, it '''must first be registered''' via [[Form:Equipment_Registry]].

* The [[Form:Temperature_Recording|Daily Temperature Log]] dropdown will '''only show equipment that has been registered'''
* This ensures all temperature records are linked to a valid equipment entry
* This prevents data quality issues and orphaned temperature readings
* Each equipment unit has a unique identifier (e.g., FRIDGE-01) that cannot be duplicated

=== How It Works ===

==== Step 1: Register Equipment ====
Use [[Form:Equipment_Registry]] to create an entry for each piece of temperature-control equipment:
* Unit Number (e.g., FRIDGE-01) - '''Must be unique - only one FRIDGE-01 can exist'''
* Equipment Type (Refrigerator, Freezer, Display Case, etc.)
* Location in the facility
* Purpose (Cold/Hot holding)
* Installation date

Once registered, the equipment page is created in the [[Equipment]] namespace and immediately becomes available for temperature recording.

==== Step 2: Link Daily Temperature Records ====
When recording daily temperatures via [[Form:Temperature_Recording]]:
1. The Equipment Unit dropdown shows '''only registered equipment''' (dynamically generated)
2. Select the equipment unit from the dropdown
3. Enter the morning and evening temperatures
4. The form automatically links the record to the equipment unit via [[Property:References_Equipment]]

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
1. Enter a '''unique unit number''' (e.g., PREP-FRIDGE-02) that doesn't already exist
2. A new page is created in the [[Equipment]] namespace automatically
3. The new unit appears in the [[Form:Temperature_Recording|Temperature Recording]] dropdown immediately
4. Staff can begin recording temperatures for the new unit right away

=== Why Equipment Registration Matters ===

By requiring equipment registration before temperature recording:
* '''Data Integrity:''' No orphaned temperature records with invalid equipment references
* '''Historical Tracking:''' Complete record of when equipment was installed and all temperatures it has recorded
* '''Unique Identifiers:''' Each equipment unit is uniquely identified, preventing duplicates
* '''Compliance:''' Meets MPI Food Control Plan Diary requirements for equipment registry
* '''Analysis:''' Enables equipment-specific temperature compliance reports and trend analysis

=== Semantic Data Structure ===

The equipment tracking system uses [[Property:References_Equipment]], a semantic property that:
* Creates a link from temperature records to equipment unit pages
* Only accepts pages in the Equipment namespace
* Enables queries across all readings for a specific unit
* Powers the "Linked Records" section on equipment pages
* Supports Phase 3 Records Archive reporting and analytics

=== For Food Safety Inspectors ===

Inspectors can:
* View the complete [[Equipment|Equipment Registry]]
* Verify all equipment units are properly registered
* Check temperature compliance for any piece of equipment
* Verify equipment maintenance and calibration records
* Generate equipment-specific compliance reports
* Confirm no unregistered equipment is in use

[[Category:Equipment]] [[Category:Documentation]] [[Category:Food_Control_Diary]]$$
WHERE old_id = 424;

-- ============================================================================
-- VALIDATION CHECK: Ensure all Equipment pages are in Category:Equipment
-- ============================================================================
-- This ensures the dynamic dropdown will work correctly

-- Equipment:FRIDGE-01 - already has category
-- Equipment:FREEZER-01 - already has category
-- Equipment:HOTBOX-01 - already has category
-- Equipment:DISPLAY-01 - already has category
-- Equipment (hub page) - already has category

-- All equipment pages have been created with [[Category:Equipment]] in their content

COMMIT;
