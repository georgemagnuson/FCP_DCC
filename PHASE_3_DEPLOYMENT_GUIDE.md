# Phase 3: Records Archive System - Deployment Guide

**Status:** Ready for Deployment
**Created:** 2026-01-31
**Pages to Deploy:** 5 (Records_Archive + 4 subpages)
**New Page IDs:** 313-317
**New Revision IDs:** 1128-1132
**SQL Script:** `create_records_archive.sql`

---

## Overview

This guide walks you through deploying Phase 3: Records Archive System. This phase creates 5 MediaWiki pages that use Semantic MediaWiki (SMW) queries to dynamically display submitted food control records from Phase 1 and Phase 2.

### What's Being Deployed

**5 Archive Pages with 40+ SMW Queries:**
- Records_Archive (main hub)
- Records_Archive/Daily (today's forms)
- Records_Archive/Weekly (last 7 days)
- Records_Archive/Monthly (last 30 days)
- Records_Archive/Search (advanced filters)

**Dependencies:**
- ✅ Phase 1: Record Management Pages (completed)
- ✅ Phase 2: 12 SMW Properties (completed)
- ✅ Phase 2: 30 Form Templates annotated (completed)

---

## Pre-Deployment Checklist

### 1. Verify Phase 2 is Complete

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 301 AND 312;"
```

**Expected result:** `12` (the 12 SMW properties)

### 2. Verify Page ID Availability

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT page_id, page_title FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317;"
```

**Expected result:** Empty (0 rows) - all page IDs 313-317 are available

### 3. Verify Current max page_id

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT MAX(page_id) FROM mediawiki.page;"
```

**Expected result:** `312` (current maximum page ID)

### 4. Verify Current max rev_id

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT MAX(rev_id) FROM mediawiki.revision;"
```

**Expected result:** `1127` (current maximum revision ID)

### 5. Verify Current max old_id

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT MAX(old_id) FROM mediawiki.text;"
```

**Expected result:** `351` (current maximum text ID)

---

## Deployment Steps

### Step 1: Create Pre-Deployment Backup

```bash
PGPASSWORD="rash4z4m!" pg_dump -U postgres -h 192.168.2.30 -d mediawiki \
  > /tmp/backup_mediawiki_before_phase3_$(date +%Y%m%d_%H%M%S).sql
```

Verify backup was created and has reasonable size:
```bash
ls -lh /tmp/backup_mediawiki_before_phase3_*.sql
```

**Expected:** ~4-5 MB file size

### Step 2: Copy SQL Script to Remote Server

```bash
scp -i ~/.ssh/id_rsa \
  /Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_records_archive.sql \
  georgemagnuson@192.168.2.10:/tmp/
```

### Step 3: Execute Deployment Script

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki \
  -f /Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_records_archive.sql
```

**Expected output:**
```
BEGIN
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
INSERT 0 1
... (repeats 5 times for each page)
COMMIT
```

**No errors should appear.** If an error occurs, the transaction will automatically rollback.

### Step 4: Verify Deployment

Run verification query to confirm all pages were created:

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT page_id, page_title, page_len FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317 ORDER BY page_id;"
```

**Expected output:**
```
 page_id |      page_title       | page_len
---------+-----------------------+----------
     313 | Records_Archive       |     1903
     314 | Records_Archive/Daily |     1869
     315 | Records_Archive/Weekly|     2162
     316 | Records_Archive/Monthly|    2598
     317 | Records_Archive/Search |    4421
```

### Step 5: Verify Revisions Were Created

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT rev_id, rev_page, rev_len FROM mediawiki.revision WHERE rev_id BETWEEN 1128 AND 1132 ORDER BY rev_id;"
```

**Expected output:**
```
 rev_id | rev_page | rev_len
--------+----------+---------
   1128 |      313 |    1903
   1129 |      314 |    1869
   1130 |      315 |    2162
   1131 |      316 |    2598
   1132 |      317 |    4421
```

### Step 6: SSH to MediaWiki Server and Clear Cache

```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10

# Navigate to MediaWiki directory
cd /usr/local/www/mediawiki

# Clear the cache
php maintenance/purgeList.php --db-touch

# Process the job queue
php maintenance/runJobs.php --maxjobs=1000
```

**This step is critical.** MediaWiki caches page data, so you must clear it after adding new pages.

### Step 7: Verify Pages are Accessible

Visit each URL in your browser to verify they load without errors:

- http://192.168.2.10/Records_Archive
- http://192.168.2.10/Records_Archive/Daily
- http://192.168.2.10/Records_Archive/Weekly
- http://192.168.2.10/Records_Archive/Monthly
- http://192.168.2.10/Records_Archive/Search

**Expected:** Each page loads successfully with "No records" messages (since no forms have been submitted yet).

---

## Testing Strategy

### Phase A: Syntax Verification (No Data)

These tests verify the SMW queries are syntactically correct and load without errors.

1. **Visit Records_Archive:** Should display 5 summary counts, all showing "0"
2. **Visit Records_Archive/Daily:** Should display "No records submitted today"
3. **Visit Records_Archive/Weekly:** Should display "No records from the past 7 days"
4. **Visit Records_Archive/Monthly:** Should display "No records from the past 30 days"
5. **Visit Records_Archive/Search:** Should display all search categories with "No records found" messages
6. **Test Navigation:** Click between pages using the navigation links

### Phase B: With Test Data

Once you're confident the pages work, create test form submissions:

1. **Submit Sample Daily Form:** Via MediaWiki PageForms, submit a HotHoldingTemperatureLog with today's date
2. **Verify on Daily Archive:** Refresh Records_Archive/Daily - form should appear
3. **Submit Weekly Form:** Submit another form with a date from 5 days ago
4. **Verify on Weekly Archive:** Refresh Records_Archive/Weekly - both forms should appear
5. **Test Failed Status:** Create a form with Has_pass_fail_status = "Fail"
6. **Verify on Search:** Visit Records_Archive/Search and scroll to "All Failed Checks" section
7. **Test Incident:** Create an Incident_Report with Has_incident_severity = "High"
8. **Verify on Monthly:** Records_Archive/Monthly should show the incident

---

## Rollback Plan

### If Deployment Fails

The transaction is atomic - either all 5 pages are created or none are. If an error occurs during deployment, the database automatically rolls back to its previous state. No manual intervention is needed.

### If Deployment Succeeds but Pages Have Errors

**Option 1: Quick Fix (Preferred)**

Update just the problematic page's content:

```sql
-- Example: Fix Records_Archive/Daily query syntax
BEGIN;

UPDATE mediawiki.text
SET old_text = '[corrected wikitext with fixed SMW query]'
WHERE old_id = 353;

-- Recalculate the byte count
UPDATE mediawiki.content
SET content_size = [new_byte_count]
WHERE content_id = 353;

UPDATE mediawiki.page
SET page_len = [new_byte_count]
WHERE page_id = 314;

COMMIT;

-- Then clear cache:
-- ssh to 192.168.2.10
-- php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
```

**Option 2: Selective Deletion**

Remove only the 5 archive pages:

```sql
BEGIN;
DELETE FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317;
DELETE FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1128 AND 1132;
DELETE FROM mediawiki.revision WHERE rev_id BETWEEN 1128 AND 1132;
DELETE FROM mediawiki.content WHERE content_id BETWEEN 352 AND 356;
DELETE FROM mediawiki.text WHERE old_id BETWEEN 352 AND 356;
COMMIT;
```

Then re-run the deployment from Step 3 onwards with corrected SQL.

**Option 3: Full Restore (Last Resort)**

```bash
# SSH to PostgreSQL server
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30

# Stop services
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10 'sudo service apache24 stop'

# Restore backup
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  < /tmp/backup_mediawiki_before_phase3_20260131_XXXXXX.sql

# Restart services
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10 'sudo service apache24 start'

# Clear cache
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php
```

---

## Post-Deployment Tasks

### 1. Update QUICK_REFERENCE.md

Add Records_Archive information to the Current Project Status section:

```markdown
**Records Archive Pages (Phase 3):**
- Records_Archive (page_id: 313) - Main hub
- Records_Archive/Daily (page_id: 314) - Today's records
- Records_Archive/Weekly (page_id: 315) - Last 7 days
- Records_Archive/Monthly (page_id: 316) - Last 30 days
- Records_Archive/Search (page_id: 317) - Advanced search
```

### 2. Create PHASE_3_DEPLOYMENT_REPORT.md

Document the deployment:

```markdown
# Phase 3 Deployment Report

**Status:** ✅ COMPLETE AND VERIFIED
**Deployment Date:** 2026-01-31
**Duration:** [actual time taken]
**Outcome:** All 5 archive pages deployed with SMW queries enabled

## Pages Created
- Records_Archive (313): Main hub - 1903 bytes
- Records_Archive/Daily (314): Today's forms - 1869 bytes
- Records_Archive/Weekly (315): Last 7 days - 2162 bytes
- Records_Archive/Monthly (316): Last 30 days - 2598 bytes
- Records_Archive/Search (317): Advanced search - 4421 bytes

## Total
- 5 pages created
- 40+ SMW queries deployed
- 0 errors
- Cache cleared successfully
```

### 3. Save to Memory Bank

Use the memory-bank-subagent to save:
- Phase 3 completion milestone
- Archive page URLs
- SMW query patterns for future reference

### 4. Update Food_Control_Records Main Page

Consider adding a link to Records_Archive on the main Food_Control_Records page:

```wiki
== Record Retrieval ==

* [[Records_Archive|📦 Records Archive]] - Search and view all submitted records
```

---

## Success Criteria

- ✅ All 5 pages created (IDs 313-317)
- ✅ All pages accessible via HTTP
- ✅ All SMW queries display without errors
- ✅ Empty result defaults display ("No records...")
- ✅ Navigation links work between pages
- ✅ Categories applied correctly
- ✅ Cache cleared successfully
- ✅ Database backup created
- ✅ Documentation updated

---

## SMW Query Reference

For future modifications, here are the SMW query patterns used:

### Count Query
```wiki
{{#ask: [[Has_submission_date::YYYY-MM-DD]]
 |format=count
 |default=0
}}
```

### Table Query
```wiki
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
 |?Has_form_name=Form
 |?Has_staff_name=Staff
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
 |limit=100
 |default=No records found.
}}
```

### Multi-Condition Query
```wiki
{{#ask: [[Has_pass_fail_status::Fail]]
       [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
 |?Has_corrective_action=Action
 |format=broadtable
 |limit=100
}}
```

### OR Query
```wiki
{{#ask: [[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
 |?Has_investigation_status=Status
 |format=broadtable
}}
```

---

## Troubleshooting

### Pages Show But Queries Don't Display Results

**Cause:** SMW index needs rebuilding
**Solution:**
```bash
php /usr/local/www/mediawiki/maintenance/runJobs.php --maxjobs=1000
```

### "No results" Appears Even After Submitting Forms

**Cause:** Form templates may not have SMW annotations
**Solution:** Verify Phase 2 deployment completed successfully (all 30 templates updated)

### Pages Not Appearing in Browser

**Cause:** Cache not cleared
**Solution:**
```bash
php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
```

### Database Connection Timeout

**Cause:** Network or PostgreSQL issue
**Solution:** Verify PostgreSQL is running and accessible:
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -c "SELECT 1;"
```

---

## Important Notes

1. **Atomic Transaction:** The entire deployment is one transaction. Either all 5 pages are created or none are.
2. **No Data Loss:** This deployment only adds new pages. No existing data is modified or deleted.
3. **SMW Depends on Phase 2:** The queries require Phase 2 (SMW properties) to be complete.
4. **Cache Clearing Required:** Always clear MediaWiki cache after deploying new pages.
5. **Backup is Your Safety Net:** The pre-deployment backup allows full restoration if needed.

---

## Next Steps After Phase 3

1. Train staff on using Records_Archive pages
2. Create test data and verify queries work
3. Monitor query performance as data accumulates
4. Consider Phase 4: Integration with main Food_Control_Records page
5. Plan advanced features: custom date pickers, export functionality, analytics dashboards

---

**Ready to Deploy?** Start with Step 1: Create Pre-Deployment Backup above.
