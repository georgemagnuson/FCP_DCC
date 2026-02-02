-- Fix Main_Page Quick Access Table - Add Equipment Management Section

BEGIN;

UPDATE mediawiki.text
SET old_text = $$== Welcome to Jitsu Compliance ==

The Food Control Plan Diary system for documenting and managing food safety compliance.

=== Main Sections ===

* '''[[Food_Control_Plan|Food Control Plan]]''' - Procedures and requirements for food safety management
* '''[[Food_Control_Diary|Food Control Diary]]''' - Daily check procedures, record-keeping requirements, and management reviews
* '''[[Food_Control_Records|Food Control Records]]''' - Submitted forms and recorded data from daily operations

=== Quick Access ===

{| class="wikitable"
|-
! Section !! Purpose !! Documentation
|-
| [[FCP:Setting_Up|Setting Up]] || Business layout and risk management || Food Control Plan Section 1
|-
| [[FCP:Preparing|Preparing]] || Food preparation procedures || Food Control Plan Section 2
|-
| [[FCP:Making_Cooking|Making & Cooking]] || Food cooking procedures || Food Control Plan Section 3
|-
| [[FCP:Serving_Selling|Serving & Selling]] || Food service and sale || Food Control Plan Section 4
|-
| [[FCP:Closing|Closing]] || End-of-day procedures || Food Control Plan Section 5
|-
| rowspan="3" | [[Equipment_Registry|Equipment Management]] || Daily temperature monitoring and equipment registry || [[Equipment_Registry|Quick Start Guide]]
|-
| Register New Equipment || [[Form:Equipment_Registry|Add Equipment]]
|-
| Log Daily Temperatures || [[Form:Temperature_Recording|Temperature Log]]
|}

=== About This System ===

This wiki implements the Ministry for Primary Industries (MPI) Food Control Plan guidelines for New Zealand food businesses. It combines the Food Control Plan (procedures and requirements) with the Food Control Diary (daily record-keeping) to provide a complete food safety management system.

For more information, see the [[Special:AllPages|complete page index]].$$
WHERE old_id = 344;

COMMIT;
