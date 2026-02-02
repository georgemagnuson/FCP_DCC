-- =====================================================================
-- Comprehensive Main_Page Redesign
-- Date: 2026-02-02
-- Purpose: Complete information hub for Food Control Plan Diary System
-- =====================================================================

BEGIN;

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (373, '= Food Control Plan Diary System =

Welcome to the Food Control Plan (FCP) Diary System. This system manages all food safety compliance records and documentation required for your business.

----

== 1. 📋 Food Control Plan ==

The Food Control Plan outlines your business''s food safety procedures and processes. Access the FCP and its related sections here:

=== FCP Sections ===

* [[FCP:Setting_Up:Plan_monitoring|FCP 01: Setting Up]] - Establishing your food safety program (business details, risk assessment, planning)
* [[FCP:Preparing:General_Introduction|FCP 02: Preparing]] - Preparation and sourcing procedures
* [[FCP:Making_Cooking:General_Introduction|FCP 03: Making & Cooking]] - Cooking and food preparation standards
* [[FCP:Serving_Selling:General_Introduction|FCP 04: Serving & Selling]] - Service and sales procedures
* [[FCP:Closing:General_Introduction|FCP 05: Closing]] - End-of-day procedures and compliance

=== FCP Forms & Documentation ===

* [[FCP:Forms_Repository_Hub|Forms Repository Hub]] - Complete list of all forms by section
* [[Equipment_Registry|Equipment Registry]] - Register and manage temperature control equipment
* [[Calibration_Record|Thermometer Calibration]] - Temperature measurement verification
* [[Supplier_List|Trusted Suppliers]] - Supplier documentation and records

----

== 2. 📖 Food Control Diary Guide ==

Understanding how to properly maintain your Food Control Diary for compliance:

* [[Food_Control_Diary|📚 Food Control Diary Guide]] - Complete guide to diary requirements
* [[Food_Control_Plan_Diary_Daily_Checks_and_Procedures|Daily Checks & Procedures]] - Opening/closing/temperature requirements
* [[Food_Control_Plan_Diary_Four_Week_Review_Process|Four-Week Review Process]] - Manager compliance review procedures
* [[Food_Control_Plan_Diary_Thermometer_Calibration_Procedures|Thermometer Calibration]] - Temperature probe accuracy verification

**Key Requirements:**
* Daily opening checks (staff fitness, area cleanliness, hand washing)
* Daily closing checks (food protection, temperatures, cleaning, waste)
* Daily temperature monitoring of all potentially hazardous food storage
* Weekly compliance checks and manager attestation
* Four-weekly comprehensive review by management
* Problem documentation with corrective actions

----

== 3. 👥 Employee Records ==

Manage staff members, training records, and accountability tracking:

* [[Employee_Directory|👥 Employee Directory]] - Register and manage all staff members
* [[Employee_Directory/Training|Training Status]] - Track food safety training completion
* [[Employee_Directory/Permissions|User Permissions]] - Assign MediaWiki access and roles
* [[Employee_Directory/Accountability|Accountability Reports]] - View employee submission history

**Staff Roles:**
* **Data Entry Staff** - Submit daily forms and records
* **Manager** - Oversee operations, complete weekly supervision
* **Inspector** - Read-only access to all records for verification
* **System Admin** - Manage users and system configuration

----

== 4. ✍️ Food Control Diary Record - Daily Entry ==

Submit daily operational records and compliance documentation:

* [[Daily_Records|✍️ Daily Records]] - Quick access to all daily forms
* [[Daily_Activity_Records|Daily Activity Records]] - Entry point for today''s checklists

=== Daily Forms (Complete Every Day) ===

* [[Form:Daily_Opening_Checklist|Opening Checklist]] - Complete at start of business day
* [[Form:Daily_Closing_Checklist|Closing Checklist]] - Complete at end of business day
* [[Form:Temperature_Recording|Temperature Monitoring]] - Record morning and evening readings

=== Incident Reporting (As Needed) ===

* [[Form:Daily_Problem_Report|Problem Report]] - Document issues and corrective actions
* [[Form:Incident_Report|Incident Report]] - Formal incident documentation

=== Weekly Forms (Complete Every Week) ===

* [[Form:Weekly_Supervision|Weekly Supervision]] - Manager attestation of compliance

=== Equipment Management ===

* [[Equipment_Registry_Documentation|Equipment Registry]] - Register all temperature control equipment
* [[Form:Equipment_Maintenance_Log|Equipment Maintenance]] - Record maintenance and issues
* [[Form:Calibration_Record|Thermometer Calibration]] - Calibration records (minimum every 12 weeks)

----

== 5. 📊 Food Control Diary Archive - View Records ==

Access, search, and analyze submitted records:

=== Browse Records by Time Period ===

* [[Records_Archive|📊 Records Archive Hub]] - Central archive and statistics
* [[Records_Archive/Daily|Today''s Records]] - All submissions from today
* [[Records_Archive/Weekly|This Week''s Records]] - Last 7 days of submissions
* [[Records_Archive/Monthly|This Month''s Records]] - Last 30 days of submissions

=== Advanced Search & Filtering ===

* [[Records_Archive/Search|Advanced Search]] - Find records with custom filters
  - Search by date range
  - Filter by staff member (accountability)
  - Filter by form type
  - Filter by compliance status (Pass/Fail)
  - Find high-severity incidents

=== Sample Queries ===

* **Temperature Failures** - Equipment readings out of safe range
* **Problem Reports** - All issues documented with corrective actions
* **Staff Accountability** - Records submitted by specific staff member
* **Equipment Trends** - Historical data for specific equipment units
* **Compliance Summary** - Pass/Fail overview for management reporting

----

== 6. ⚡ Quick Links - Forms & Required Dates ==

Forms that need regular completion:

{| class="wikitable" style="width: 100%; margin: 1em 0;"
|-
! Form Name !! Frequency !! Staff Role !! Status
|-
| [[Form:Daily_Opening_Checklist|Daily Opening Checklist]]
| Every day (Morning)
| All Staff
| ☐ Not Yet Completed
|-
| [[Form:Daily_Closing_Checklist|Daily Closing Checklist]]
| Every day (Evening)
| All Staff
| ☐ Not Yet Completed
|-
| [[Form:Temperature_Recording|Temperature Recording]]
| Every day (Morning & Evening)
| All Staff
| ☐ Not Yet Completed
|-
| [[Form:Daily_Problem_Report|Problem Report]]
| As needed
| All Staff
| ☐ Optional
|-
| [[Form:Weekly_Supervision|Weekly Supervision]]
| Every week (Friday)
| Manager
| ☐ Not Yet Completed
|-
| [[Form:Equipment_Maintenance_Log|Equipment Maintenance]]
| Weekly
| Maintenance Staff
| ☐ Optional
|-
| [[Form:Calibration_Record|Thermometer Calibration]]
| Every 12 weeks
| Manager/Maintenance
| ☐ Not Yet Completed
|-
| [[Four_Week_Review|Four-Week Manager Review]]
| Every 4 weeks
| Manager
| ☐ Not Yet Completed
|}

=== Where to Submit ===

1. Daily forms: [[Daily_Records|Daily Records]] page
2. Weekly forms: [[Daily_Activity_Records|Daily Activity Records]] page
3. All forms auto-save and appear in [[Records_Archive|Records Archive]]

----

== System Overview ==

{| class="wikitable" style="width: 100%; margin: 1em 0;"
|-
! Component !! Status !! Purpose
|-
| Employee Directory
| ✅ Active
| Staff registration, training, accountability
|-
| Daily Forms
| ✅ Active
| Opening/closing/temperature/problems
|-
| Records Archive
| ✅ Active
| View and search submitted records
|-
| Equipment Registry
| ✅ Active
| Temperature control equipment tracking
|-
| SMW Queries
| ✅ Active
| Dynamic record filtering and analysis
|-
| Access Control
| ✅ Active
| Role-based staff/manager/inspector access
|}

----

== Getting Started ==

=== For Staff (Data Entry) ===

1. Go to [[Daily_Records|Daily Records]]
2. Check you''re registered in [[Employee_Directory|Employee Directory]]
3. Complete daily opening checklist (morning)
4. Record temperatures (morning and evening)
5. Complete daily closing checklist (evening)
6. Report any problems immediately

=== For Managers ===

1. Ensure all staff registered in [[Employee_Directory|Employee Directory]] with training verified
2. Review submitted records in [[Records_Archive|Records Archive]]
3. Complete weekly supervision attestation every Friday
4. Conduct four-week compliance review
5. Address any problems or non-conformances

=== For Inspectors ===

1. Access [[Records_Archive|Records Archive]] to view records
2. Use [[Records_Archive/Search|Advanced Search]] for detailed compliance verification
3. Filter by date, staff, or record type as needed
4. Generate compliance reports for documentation

----

== Need Help? ==

* [[Food_Control_Diary|Food Control Diary Guide]] - How to complete the diary
* [[Food_Control_Plan|Food Control Plan]] - Business procedures
* [[Employee_Directory|Employee Directory]] - Staff management
* [[Records_Archive|Records Archive]] - Accessing records

[[Category:Food Control Records]]
[[Category:Main]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (373, 8500, '', 1, 'tt:373');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1154, 1, 1, 1, NOW(), 0, 0, 8500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1154, 1, 373, 1154);

UPDATE mediawiki.page SET page_latest = 1154, page_touched = NOW(), page_len = 8500 WHERE page_id = 1;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Updated page: Main_Page (page 1)
-- New revision: 1154
--
-- Six Major Sections:
-- 1. Food Control Plan - FCP sections and forms repository
-- 2. Food Control Diary Guide - Diary requirements and procedures
-- 3. Employee Records - Staff management and training
-- 4. Food Control Diary Record - Daily/weekly data entry forms
-- 5. Food Control Diary Archive - Record viewing and searching
-- 6. Quick Links - Forms with required dates and frequencies
--
-- Additional Content:
-- - System Overview table (status of all components)
-- - Getting Started guide (workflows for different roles)
-- - Help section with navigation
--
-- Pages linked:
-- - FCP sections (Setting Up, Preparing, Making, Serving, Closing)
-- - Forms Repository Hub
-- - Food_Control_Diary (guide)
-- - Employee_Directory (and subsections)
-- - Daily_Records and Daily_Activity_Records
-- - Records_Archive (all views)
-- - Equipment_Registry
-- - Various form pages
--
-- Next steps:
-- 1. ssh 192.168.2.10
-- 2. php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Navigate to: http://192.168.1.18/mediawiki/index.php/Main_Page
-- 4. Verify all 6 sections appear with proper links
-- 5. Test navigation to each major section
-- =====================================================================
