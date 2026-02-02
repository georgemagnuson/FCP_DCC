-- Fix Form Pages - Use proper PageForms syntax instead of raw form tags

BEGIN;

-- Update Form:Equipment_Registry with proper PageForms syntax
UPDATE mediawiki.text
SET old_text = $$<noinclude>
This is the Equipment Registry Form for documenting all temperature control equipment.
</noinclude>

{{#forminput:form=EquipmentRegistry}}

== Equipment Registry ==

This form registers temperature control equipment for the facility.

* '''Unit Number''' (e.g., FRIDGE-01) - Unique identifier
* '''Equipment Type''' - Type of equipment (Refrigerator, Freezer, etc.)
* '''Location''' - Where in the facility
* '''Purpose''' - Cold holding, hot holding, etc.
* '''Installation Date''' - When equipment was installed

After registering equipment, use [[Special:FormEdit/TemperatureRecording|Temperature Recording Form]] to log daily readings.$$
WHERE old_id = 414;

-- Update Form:Temperature_Recording with proper PageForms syntax
UPDATE mediawiki.text
SET old_text = $$<noinclude>
This is the Temperature Recording Form for daily equipment temperature monitoring.
</noinclude>

{{#forminput:form=TemperatureRecording}}

== Daily Temperature Recording ==

This form logs daily temperature readings for registered equipment.

* '''Date''' - Date of temperature reading
* '''Equipment Unit''' - Select from registered equipment (dropdown)
* '''Morning Temperature (°C)''' - Temperature reading (morning)
* '''Evening Temperature (°C)''' - Temperature reading (evening)
* '''Action if Out of Range''' - Actions taken if temperatures are outside acceptable ranges

Equipment must be registered via [[Special:FormEdit/EquipmentRegistry|Equipment Registry Form]] first.$$
WHERE old_id = 422;

COMMIT;
