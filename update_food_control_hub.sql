-- =====================================================================
-- Update Food_Control_Records - Add Navigation Hub
-- Date: 2026-02-02
-- Purpose: Create central navigation hub for Food Control operations
-- =====================================================================

BEGIN;

-- Replace Food_Control_Records content with comprehensive navigation hub
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (371, '= Food Control Records & Compliance Hub =

Welcome to the Food Control Plan Diary System. This is your central hub for managing daily food safety records, employee accountability, and compliance documentation.

== Quick Navigation ==

=== 📋 Daily Operations ===

* [[Daily_Records|Daily Records]] - Access all daily forms (opening/closing checklists, temperature monitoring, problem reports)
* [[Daily_Activity_Records|Daily Activity Records]] - Quick entry point for today''s checklists and supervision
* [[Employee_Directory|Employee Directory]] - Manage staff members, track training, assign permissions

=== 📊 Records & Analysis ===

* [[Records_Archive|Records Archive]] - View submitted records by date period (today, this week, this month)
* [[Records_Archive/Search|Advanced Search]] - Custom date ranges, staff filters, status filtering
* [[Records_Archive/Daily|Today''s Records]] - All submissions from today
* [[Records_Archive/Weekly|Weekly Records]] - Last 7 days of submissions
* [[Records_Archive/Monthly|Monthly Records]] - Last 30 days of submissions

=== 🔧 Equipment & Inventory ===

* [[Equipment_Registry|Equipment Registry]] - Register and manage temperature control equipment
* [[Equipment_Registry_Documentation|Equipment Documentation]] - Equipment inventory and details
* [[Form:Temperature_Recording|Record Temperatures]] - Daily equipment temperature monitoring

=== 📖 Documentation ===

* [[Food_Control_Plan|Food Control Plan]] - Main compliance procedures
* [[Food_Control_Diary|Food Control Diary Guide]] - Official FCP diary requirements

----

== How to Use This System ==

=== For Daily Staff ===

1. Visit [[Daily_Records|Daily Records]]
2. Ensure you are registered in [[Employee_Directory|Employee Directory]]
3. Complete daily checklists (opening, closing, temperature, problems)
4. Submit records via forms - automatically archived and queryable

=== For Managers ===

1. Ensure all staff are registered and trained in [[Employee_Directory|Employee Directory]]
2. Review daily submissions in [[Records_Archive|Records Archive]]
3. Search records by staff member, date, or issue in [[Records_Archive/Search|Advanced Search]]
4. Complete weekly supervision attestation in [[Daily_Activity_Records|Daily Activity Records]]

=== For Inspectors ===

1. Access [[Records_Archive|Records Archive]] to view all submitted records
2. Use [[Records_Archive/Search|Advanced Search]] for detailed compliance reporting
3. Filter by date range, staff member, record type, or compliance status
4. Generate compliance reports for verification

----

== Compliance Features ==

✅ **Staff Accountability** - All records linked to employee names
✅ **Automated Archiving** - Records automatically organized by date and type
✅ **Advanced Filtering** - Search by staff, date, issue type, severity
✅ **Semantic Indexing** - 12 SMW properties capture all record metadata
✅ **Audit Trail** - Complete history of all submissions and changes

----

== System Status ==

Current deployment status:
* ✅ Daily Activity Forms (Opening/Closing/Problem/Supervision)
* ✅ Employee Directory with accountability tracking
* ✅ Records Archive with dynamic SMW queries
* ✅ Equipment Registry with temperature tracking
* ✅ 12 Semantic Properties for compliance queries

---

== Key Pages by Function ==

{| class="wikitable"
|-
! Function !! Page !! Purpose
|-
| Data Entry
| [[Daily_Records]]
| Submit daily forms and checklists
|-
| Staff Management
| [[Employee_Directory]]
| Register employees and assign roles
|-
| Record Review
| [[Records_Archive]]
| View submitted records by time period
|-
| Advanced Search
| [[Records_Archive/Search]]
| Find specific records with filters
|-
| Equipment Tracking
| [[Equipment_Registry]]
| Register and manage equipment
|-
| Temperature Logs
| [[Form:Temperature_Recording]]
| Record daily temperature checks
|-
| Management Oversight
| [[Daily_Activity_Records]]
| Weekly supervision attestations
|}

[[Category:Food Control Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (371, 4500, '', 1, 'tt:371');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1152, 229, 1, 1, NOW(), 0, 0, 4500, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1152, 1, 371, 1152);

-- Update page stats
UPDATE mediawiki.page SET page_latest = 1152, page_touched = NOW(), page_len = 4500 WHERE page_id = 229;

COMMIT;

-- =====================================================================
-- DEPLOYMENT NOTES
-- =====================================================================
-- Updated page: Food_Control_Records (page 229)
-- New revision: 1152
-- Changes: Complete navigation hub with all key pages and workflows
--
-- New sections:
-- - Quick Navigation (Daily Ops, Records, Equipment)
-- - How to Use (Staff, Managers, Inspectors)
-- - Compliance Features
-- - System Status
-- - Key Pages Table
--
-- Links to:
-- - Daily_Records
-- - Daily_Activity_Records
-- - Employee_Directory
-- - Records_Archive (all views)
-- - Equipment_Registry
-- - Food_Control_Plan
-- - Food_Control_Diary
--
-- Next steps:
-- 1. ssh 192.168.2.10
-- 2. php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
-- 3. Navigate to: http://192.168.1.18/mediawiki/index.php/Food_Control_Records
-- 4. Verify comprehensive navigation appears
-- =====================================================================
