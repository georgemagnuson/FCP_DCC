# Phase 3: Records Archive System - SQL Reference

**Purpose:** Technical reference for the SQL deployment script
**Status:** Ready for deployment
**File:** create_records_archive.sql (514 lines)

---

## SQL Script Structure

The script contains exactly 5 page insertions, following the proven 5-table pattern from Phase 1:

### Pattern (Repeated 5 Times)

For each page:
1. INSERT into mediawiki.text (old_id, old_text, old_flags)
2. INSERT into mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
3. INSERT into mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
4. INSERT into mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
5. INSERT into mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)

---

## Page 1: Records_Archive (Main Hub)

### IDs Used
- old_id: 352
- content_id: 352
- rev_id: 1128
- page_id: 313
- Content size: 1903 bytes

### Content Summary
- Title: Records Archive
- Purpose: Main hub with navigation
- Sections:
  - Quick Navigation (links to 4 subpages)
  - Summary Statistics (today, failures, incidents)
  - Archive Overview (5 latest records)
  - Related Pages

### Key Queries
```wiki
# Today's count
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
 |format=count |default=0
}}

# Recent failures (7 days)
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |format=count |default=0
}}

# Critical incidents (30 days)
{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |format=count |default=0
}}

# Latest records table
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=5
 |default=No recent records available.
}}
```

---

## Page 2: Records_Archive/Daily

### IDs Used
- old_id: 353
- content_id: 353
- rev_id: 1129
- page_id: 314
- Content size: 1869 bytes

### Content Summary
- Title: Daily Records Archive
- Purpose: Today's submitted forms
- Sections:
  - Records Submitted Today
  - Today's Summary (counts)
  - Temperature Monitoring Forms
  - Navigation

### Key Queries
```wiki
# All today's records
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |?Has_temperature=Temperature
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No records submitted today. Records will appear here as forms are submitted.
}}

# Passed checks (today)
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
       [[Has_pass_fail_status::Pass]]
 |format=count |default=0
}}

# Failed checks (today)
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
       [[Has_pass_fail_status::Fail]]
 |format=count |default=0
}}

# Temperature logs (today)
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
       [[Has_temperature::+]]
 |?Has_form_name=Form
 |?Has_food_item=Item
 |?Has_temperature=Temperature
 |?Has_temperature_unit=Unit
 |format=broadtable
 |limit=50
 |default=No temperature logs submitted today.
}}
```

---

## Page 3: Records_Archive/Weekly

### IDs Used
- old_id: 354
- content_id: 354
- rev_id: 1130
- page_id: 315
- Content size: 2162 bytes

### Content Summary
- Title: Weekly Records Archive
- Purpose: Last 7 days with failure tracking
- Sections:
  - Records from Last 7 Days
  - Weekly Summary
  - Failed Checks Requiring Attention
  - Temperature Trends
  - Navigation

### Key Queries
```wiki
# All 7-day records
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No records from the past 7 days.
}}

# Failed checks (7 days)
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |?Has_corrective_action=Action Taken
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No failed checks. Excellent compliance record!
}}

# Temperature trends (7 days)
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
       [[Has_temperature::+]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_food_item=Item
 |?Has_temperature=Temperature
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No temperature data available.
}}
```

---

## Page 4: Records_Archive/Monthly

### IDs Used
- old_id: 355
- content_id: 355
- rev_id: 1131
- page_id: 316
- Content size: 2598 bytes

### Content Summary
- Title: Monthly Records Archive
- Purpose: Last 30 days with incident tracking
- Sections:
  - Records from Last 30 Days
  - Monthly Summary
  - Incidents & Investigations
  - Compliance Performance
  - Navigation

### Key Queries
```wiki
# All 30-day records
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form Type
 |?Has_staff_name=Staff Member
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=500
 |default=No records from the past 30 days.
}}

# High & critical incidents (30 days)
{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_incident_severity=Severity
 |?Has_investigation_status=Investigation Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No high or critical incidents. Facility operating safely.
}}

# All incidents (30 days)
{{#ask: [[Has_form_name::Incident Report]] OR [[Has_form_name::Complaint Log]] OR [[Has_form_name::Root Cause Analysis]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_incident_severity=Severity
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No incidents recorded.
}}

# Failed checks (30 days)
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_corrective_action=Corrective Action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No failed checks recorded.
}}
```

---

## Page 5: Records_Archive/Search

### IDs Used
- old_id: 356
- content_id: 356
- rev_id: 1132
- page_id: 317
- Content size: 4421 bytes (largest)

### Content Summary
- Title: Advanced Search & Filters
- Purpose: Advanced search with multiple filters
- Sections:
  - Search by Date Range (3, 14, 60 days)
  - Search by Form Type
  - Search by Status (Pass/Fail)
  - Search by Severity (Critical, High, Medium)
  - Staff Performance Tracking
  - Tips and Navigation

### Key Queries
```wiki
# Last 3 days
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -3 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No records in the past 3 days.
}}

# Last 14 days
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -14 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=150
 |default=No records in the past 14 days.
}}

# Last 60 days
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -60 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=300
 |default=No records in the past 60 days.
}}

# All passed checks (30 days)
{{#ask: [[Has_pass_fail_status::Pass]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No passed checks found.
}}

# All failed checks (30 days)
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |?Has_corrective_action=Corrective Action
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=200
 |default=No failed checks found.
}}

# Critical incidents (90 days)
{{#ask: [[Has_incident_severity::Critical]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |limit=50
 |default=No critical incidents recorded.
}}

# High severity incidents (90 days)
{{#ask: [[Has_incident_severity::High]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No high severity incidents recorded.
}}

# Medium severity incidents (90 days)
{{#ask: [[Has_incident_severity::Medium]]
       [[Has_submission_date::>{{#time:Y-m-d|now -90 days}}]]
 |?Has_submission_date=Date
 |?Has_form_name=Incident Type
 |?Has_investigation_status=Status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No medium severity incidents recorded.
}}

# Records by staff member (30 days)
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_staff_name=Staff
 |?Has_form_name=Form
 |?Has_pass_fail_status=Status
 |format=broadtable
 |sort=Has_staff_name
 |order=asc
 |limit=300
 |default=No staff records found.
}}
```

---

## Query Pattern Summary

### Count Queries (10 examples)
- Today's records
- Passed checks (multiple timeframes)
- Failed checks (multiple timeframes)
- Critical incidents
- High severity incidents
- Medium severity incidents

### Table Queries (30+ examples)
- All records (various date ranges)
- Failed checks with corrective actions
- Temperature monitoring records
- Maintenance records
- Incident records by severity
- Staff performance tracking
- Form-type specific records

### Date Filtering Patterns
```wiki
[[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
{{#time:Y-m-d|now -3 days}}
{{#time:Y-m-d|now -7 days}}
{{#time:Y-m-d|now -14 days}}
{{#time:Y-m-d|now -30 days}}
{{#time:Y-m-d|now -60 days}}
{{#time:Y-m-d|now -90 days}}
```

### Condition Patterns
```wiki
# AND (multiple conditions)
[[Property1::Value1]]
[[Property2::Value2]]

# OR (multiple values)
[[Property::Value1]] OR [[Property::Value2]]

# Property exists
[[Property::+]]

# Comparison
[[Property::>Value]]
```

---

## Database Allocation Summary

### Text Entries (old_id)
| old_id | Page | Size | Role |
|--------|------|------|------|
| 352 | Records_Archive | 1903 bytes | Main hub |
| 353 | Records_Archive/Daily | 1869 bytes | Daily view |
| 354 | Records_Archive/Weekly | 2162 bytes | Weekly view |
| 355 | Records_Archive/Monthly | 2598 bytes | Monthly view |
| 356 | Records_Archive/Search | 4421 bytes | Search interface |
| **TOTAL** | **5 pages** | **13,053 bytes** | **40+ queries** |

### Revision Entries (rev_id)
| rev_id | page_id | Purpose |
|--------|---------|---------|
| 1128 | 313 | Main archive page |
| 1129 | 314 | Daily records page |
| 1130 | 315 | Weekly records page |
| 1131 | 316 | Monthly records page |
| 1132 | 317 | Search page |

### Page Entries (page_id)
| page_id | title | namespace |
|---------|-------|-----------|
| 313 | Records_Archive | 0 (main) |
| 314 | Records_Archive/Daily | 0 (main) |
| 315 | Records_Archive/Weekly | 0 (main) |
| 316 | Records_Archive/Monthly | 0 (main) |
| 317 | Records_Archive/Search | 0 (main) |

---

## Verification Queries

### Check All Pages Created
```sql
SELECT page_id, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 313 AND 317
ORDER BY page_id;
```

**Expected Result:** 5 rows with pages 313-317

### Check All Revisions Created
```sql
SELECT rev_id, rev_page, rev_len
FROM mediawiki.revision
WHERE rev_id BETWEEN 1128 AND 1132
ORDER BY rev_id;
```

**Expected Result:** 5 rows with revisions 1128-1132

### Check All Text Entries Created
```sql
SELECT old_id, LENGTH(old_text) as text_length
FROM mediawiki.text
WHERE old_id BETWEEN 352 AND 356
ORDER BY old_id;
```

**Expected Result:** 5 rows with IDs 352-356 and correct byte lengths

### Check Content Entries
```sql
SELECT content_id, content_size
FROM mediawiki.content
WHERE content_id BETWEEN 352 AND 356
ORDER BY content_id;
```

**Expected Result:** 5 rows with correct sizes

### Check Slots Linking
```sql
SELECT slot_revision_id, slot_content_id
FROM mediawiki.slots
WHERE slot_revision_id BETWEEN 1128 AND 1132
ORDER BY slot_revision_id;
```

**Expected Result:** 5 rows, each rev_id linked to corresponding content_id

---

## Transaction Safety

The entire script is wrapped in:
```sql
BEGIN;
... (all 5 pages inserted here)
COMMIT;
```

This ensures:
- ✅ All 5 pages inserted together
- ✅ No partial state possible
- ✅ Auto-rollback if any error occurs
- ✅ Atomic operation (all or nothing)

---

## SMW Properties Referenced

The 40+ queries use these 12 Phase 2 properties:

1. Has_submission_date (Date) - Filters by when record was submitted
2. Has_form_name (Text) - Identifies form type
3. Has_staff_name (Text) - Tracks which staff submitted
4. Has_pass_fail_status (Text) - Shows Pass/Fail status
5. Has_temperature (Number) - Stores temperature values
6. Has_temperature_unit (Text) - Unit of temperature (C/F)
7. Has_incident_severity (Text) - Severity level (Critical/High/Medium/Low)
8. Has_investigation_status (Text) - Investigation status
9. Has_corrective_action (Text) - Action taken for failures
10. Has_record_type (Text) - Type of record
11. Has_food_item (Text) - Food item being monitored
12. Has_equipment_unit (Text) - Equipment unit identifier

---

## Integration with Phase 2

All 30 form templates from Phase 2 have been annotated with SMW properties. When forms are submitted through MediaWiki PageForms, the queries in these archive pages will automatically capture and display:

- Form name from template variable
- Submission date (auto-captured)
- Staff name from form input
- Status from form input
- Temperature readings from form input
- Incident severity from form input
- And all other captured properties

The archive queries run against these captured properties to populate the dynamic tables and counts.

---

## Performance Considerations

### Query Limits
- Daily archive: 100 records max
- Weekly archive: 200 records max
- Monthly archive: 500 records max
- Search pages: 50-300 records per query

These limits prevent overwhelming large result sets while still showing comprehensive data.

### Sorting & Ordering
- Default sort: Has_submission_date
- Default order: desc (newest first)
- Staff queries sort by: Has_staff_name asc (alphabetical)

### Default Messages
Every query includes `|default=` to display helpful messages when no data exists, preventing confusing empty tables.

---

## Future Enhancement Opportunities

The query patterns support future enhancements like:
- Custom date range picker (extends the hardcoded ranges)
- Export to CSV/PDF (MediaWiki extension)
- Email alerts on failures (trigger on queries)
- Analytics dashboard (aggregate counts)
- Performance dashboards (track trends)
- Custom reports (combine multiple queries)

---

This SQL reference provides the complete technical details of every query, property, and page in Phase 3.
