-- Fix Equipment_Registry_Documentation - Use correct categorytree and forminput pattern

BEGIN;

UPDATE mediawiki.text
SET old_text = $$== Equipment Registry System ==

This page documents how The Jitsu restaurant tracks temperature control equipment and links it to daily monitoring records through the [[Food Control Plan Diary]].

== Existing Equipment Units ==

Click on any equipment unit below to view or edit:

<categorytree mode=pages>Equipment</categorytree>

----

== Register New Equipment or Edit Existing ==

Enter an equipment unit number (e.g., FRIDGE-01) to create a new entry or edit an existing one:

{{#forminput:form=Equipment_Registry|default form=Equipment:|button text=Register/Edit Equipment}}

----

== Record Daily Temperatures ==

Once equipment is registered, use this form to log daily temperature readings:

{{#forminput:form=Temperature_Recording|default form=Temperature_Record_|button text=Record Daily Temperatures}}

----

== Important: Equipment Must Be Registered First ===

Before you can record temperature readings for a piece of equipment:
* The equipment '''must first be registered''' via the form above
* This ensures all temperature records are linked to a valid equipment entry
* This prevents data quality issues and orphaned temperature readings
* Each equipment unit has a unique identifier (e.g., FRIDGE-01) that cannot be duplicated

== How It Works ===

==== Step 1: Register Equipment ====
Use the form above to create an entry for each piece of temperature-control equipment:
* Unit Number (e.g., FRIDGE-01) - '''Must be unique'''
* Equipment Type (Refrigerator, Freezer, Display Case, etc.)
* Location in the facility
* Purpose (Cold/Hot holding)
* Installation date

Once registered, the equipment page is created and immediately becomes available for temperature recording.

==== Step 2: Link Daily Temperature Records ====
When recording daily temperatures via the form above:
1. The Equipment Unit dropdown shows '''only registered equipment''' (dynamically generated)
2. Select the equipment unit from the dropdown
3. Enter the morning and evening temperatures
4. The form automatically links the record to the equipment unit

==== Step 3: View Equipment Records ====
Each equipment page displays:
* Equipment details and specifications
* All linked temperature readings (automatically sorted by date)
* Temperature compliance history
* Performance trends

== Why Equipment Registration Matters ===

By requiring equipment registration before temperature recording:
* '''Data Integrity:''' No orphaned temperature records with invalid equipment references
* '''Historical Tracking:''' Complete record of when equipment was installed and all temperatures it has recorded
* '''Unique Identifiers:''' Each equipment unit is uniquely identified, preventing duplicates
* '''Compliance:''' Meets MPI Food Control Plan Diary requirements for equipment registry
* '''Analysis:''' Enables equipment-specific temperature compliance reports and trend analysis

== For Food Safety Inspectors ===

Inspectors can:
* View the complete equipment registry (see Existing Equipment Units above)
* Verify all equipment units are properly registered
* Check temperature compliance for any piece of equipment
* Verify equipment maintenance and calibration records
* Generate equipment-specific compliance reports
* Confirm no unregistered equipment is in use

[[Category:Equipment]] [[Category:Documentation]] [[Category:Food_Control_Diary]]$$
WHERE old_id = 424;

COMMIT;
