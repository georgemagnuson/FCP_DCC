-- Update Main_Page Quick Access Table with Equipment Registry
-- Adds Equipment Management row to the Quick Access table on Main_Page

BEGIN;

-- ============================================================================
-- UPDATE Main_Page: Add Equipment Registry to Quick Access Table
-- ============================================================================
-- Adds a new row to the Quick Access table for Equipment Management

UPDATE mediawiki.text
SET old_text = REPLACE(
  old_text,
  '| [[Food_Control_Plan_Section_5|Closing]] | End-of-day procedures | [[Food_Control_Plan_Section_5|Food Control Plan Section 5]]
|}',
  '| [[Food_Control_Plan_Section_5|Closing]] | End-of-day procedures | [[Food_Control_Plan_Section_5|Food Control Plan Section 5]]
|-
| rowspan="3" | [[Equipment_Registry|Equipment Management]] | Daily temperature monitoring and equipment registry | [[Equipment_Registry|Quick Start Guide]]
|-
| Register New Equipment | [[Form:Equipment_Registry|Add Equipment]]
|-
| Log Daily Temperatures | [[Form:Temperature_Recording|Temperature Log]]
|}'
)
WHERE old_id = 344;

COMMIT;
