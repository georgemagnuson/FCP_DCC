# Phase 3: Records Archive System - Quick Start

**Status:** Ready to Deploy
**Date:** 2026-01-31
**Script:** `create_records_archive.sql`
**Pages:** 5 (Records_Archive + 4 subpages)
**IDs Used:** page_id 313-317, rev_id 1128-1132, old_id 352-356

---

## One-Command Deployment

```bash
# 1. Create backup
PGPASSWORD="rash4z4m!" pg_dump -U postgres -h 192.168.2.30 -d mediawiki \
  > /tmp/backup_mediawiki_before_phase3_$(date +%Y%m%d_%H%M%S).sql

# 2. Deploy all 5 pages
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki \
  -f /Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_records_archive.sql

# 3. Verify deployment
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki -c \
  "SELECT page_id, page_title FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317;"

# 4. Clear cache (SSH to 192.168.2.10)
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10 \
  'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'

# 5. Visit pages
# http://192.168.2.10/Records_Archive
# http://192.168.2.10/Records_Archive/Daily
# http://192.168.2.10/Records_Archive/Weekly
# http://192.168.2.10/Records_Archive/Monthly
# http://192.168.2.10/Records_Archive/Search
```

---

## Pages Created

| Page | ID | Size | Purpose |
|------|----|----|---------|
| Records_Archive | 313 | 1903 bytes | Main hub with navigation |
| Records_Archive/Daily | 314 | 1869 bytes | Today's submitted forms |
| Records_Archive/Weekly | 315 | 2162 bytes | Last 7 days with failure tracking |
| Records_Archive/Monthly | 316 | 2598 bytes | Last 30 days with incident tracking |
| Records_Archive/Search | 317 | 4421 bytes | Advanced search with multiple filters |

---

## What's Included

✅ **5 Archive Pages** with:
- 40+ SMW queries for dynamic record retrieval
- Summary statistics (counts, totals, performance)
- Date-based filtering (today, 7 days, 30 days, 60 days, 90 days)
- Status filtering (Pass, Fail)
- Severity filtering (Critical, High, Medium)
- Form type filtering (temperature, maintenance, incidents)
- Staff tracking and performance views
- Complete navigation between pages

✅ **Pre-built Query Types:**
- Count queries (0 records if empty)
- Table queries (broadtable format)
- Multi-condition queries (AND, OR logic)
- Date range queries using dynamic dates
- Severity-based queries for incidents
- Temperature monitoring queries

---

## Key Features

### Records_Archive (Main Hub)
- Quick navigation links to 4 subpages
- Today's activity summary
- Recent failures count
- Critical incidents count
- 5 latest records table

### Records_Archive/Daily
- All today's submitted forms
- Today's summary statistics
- Passed/failed check counts
- Temperature monitoring records

### Records_Archive/Weekly
- Last 7 days of records
- Failed checks requiring attention
- Temperature trends
- Weekly compliance summary

### Records_Archive/Monthly
- Last 30 days of records
- Incident tracking (all types)
- High and critical severity incidents
- Compliance performance analysis
- Failed checks by date

### Records_Archive/Search
- Last 3, 14, 60 days pre-built searches
- Temperature monitoring search
- Maintenance & inspection search
- All passed checks (30 days)
- All failed checks (30 days)
- Critical, High, Medium incident searches
- Staff performance tracking

---

## Dependencies

**Must Complete Before Deploying Phase 3:**
- ✅ Phase 1: Record Management Pages (Daily_Records, Weekly_Records, Monthly_Records, Incident_Records)
- ✅ Phase 2: 12 SMW Properties (Has_submission_date, Has_form_name, Has_staff_name, Has_pass_fail_status, Has_incident_severity, etc.)
- ✅ Phase 2: 30 Form Templates annotated with SMW properties

---

## Testing Without Data

All pages will display "No records" messages initially:

```wiki
No records submitted today.
No records from the past 7 days.
No records from the past 30 days.
No records found.
```

This is expected and correct. As forms are submitted through MediaWiki PageForms, the counts and tables will populate.

---

## Testing With Sample Data

### Create Test Records

Submit forms via MediaWiki PageForms with:
1. Today's date
2. Different dates (yesterday, 5 days ago, 15 days ago)
3. Different statuses (Pass, Fail)
4. Different severities (Critical, High, Medium)
5. Different form types

### Verify Archive Pages Show Data

1. Submit HotHoldingTemperatureLog (today) → Check Records_Archive/Daily
2. Submit DailyCleaningLog (5 days ago) → Check Records_Archive/Weekly
3. Submit IncidentReport (high severity) → Check Records_Archive/Monthly
4. Visit Records_Archive/Search → See all test records appear

---

## SMW Query Examples

All queries in the archive use these patterns:

**Today's Date:**
```wiki
[[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]]
```

**Last 7 Days:**
```wiki
[[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]]
```

**Pass/Fail Status:**
```wiki
[[Has_pass_fail_status::Pass]]
[[Has_pass_fail_status::Fail]]
```

**Severity:**
```wiki
[[Has_incident_severity::Critical]]
[[Has_incident_severity::High]]
```

**Multiple Conditions (AND):**
```wiki
[[Has_pass_fail_status::Fail]]
[[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]]
```

**Multiple Conditions (OR):**
```wiki
[[Has_incident_severity::High]] OR [[Has_incident_severity::Critical]]
```

---

## File Summary

**SQL Script:** `create_records_archive.sql`
- 5 complete page definitions
- 5 content entries (old_id 352-356)
- 5 revision entries (rev_id 1128-1132)
- 5 page entries (page_id 313-317)
- Wrapped in atomic transaction (BEGIN/COMMIT)
- Verification queries included

**Documentation:**
- `PHASE_3_DEPLOYMENT_GUIDE.md` (complete step-by-step guide)
- `PHASE_3_QUICK_START.md` (this file)

---

## Rollback

If anything goes wrong:

**Automatic Rollback:** If deployment fails, database rolls back automatically.

**Manual Rollback (if needed):**
```bash
# Restore from backup
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -d mediawiki \
  < /tmp/backup_mediawiki_before_phase3_20260131_XXXXXX.sql
```

---

## After Deployment

1. ✅ Verify all 5 pages created
2. ✅ Clear MediaWiki cache
3. ✅ Visit each page to confirm it loads
4. ✅ Test with sample data
5. ✅ Update QUICK_REFERENCE.md
6. ✅ Create PHASE_3_DEPLOYMENT_REPORT.md
7. ✅ Save Phase 3 completion to Memory Bank

---

## Common Issues

| Issue | Solution |
|-------|----------|
| Pages not showing in browser | Clear cache: `php maintenance/purgeList.php --db-touch` |
| Queries show "No results" after submitting forms | Rebuild SMW index: `php maintenance/runJobs.php` |
| Can't connect to database | Verify PostgreSQL running: `psql -U postgres -h 192.168.2.30` |
| Pages created but have syntax errors | Check SMW documentation for query syntax |

---

## Next Steps

1. Run deployment commands above
2. Verify all 5 pages created
3. Test navigation between pages
4. Submit test data and verify queries work
5. Update documentation
6. Train staff on using archive pages

---

**Ready?** Run the deployment commands above, then follow PHASE_3_DEPLOYMENT_GUIDE.md for detailed verification and testing.
