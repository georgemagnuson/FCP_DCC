# Complete Execution Guide: FCP MediaWiki Production Script

## Quick Start

```bash
# 1. Backup database
pg_dump -h 192.168.2.30 -U mediawiki mediawiki > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. Execute script
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql

# 3. Verify results
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT 'Summary' as check, COUNT(*) as count
FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
EOF
```

---

## Pre-Execution Checklist

### 1. Verify Database Connectivity

```bash
# Test connection to PostgreSQL
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT version();"
```

**Expected Output:**
```
                                                version
─────────────────────────────────────────────────────────────────────────────
 PostgreSQL 17.0 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 11.4.0, ...
(1 row)
```

**Troubleshooting:**
- If connection fails, check hostname (192.168.2.30)
- Verify credentials (user: mediawiki)
- Confirm PostgreSQL is running: `pg_isready -h 192.168.2.30`

### 2. Verify Required Actor

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT actor_id, actor_name, actor_user
FROM mediawiki.actor
WHERE actor_id = 5;
EOF
```

**Expected Output:**
```
 actor_id |   actor_name      | actor_user
──────────┼──────────────────┼────────────
        5 | Maintenance script|
(1 row)
```

**Troubleshooting:**
- If no result, create actor (see "Setup Required Data" section)
- If different actor_name, that's OK (it's what we'll use)
- If different actor_id, update script to use correct ID

### 3. Verify No ID Conflicts

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT 'page_id' as entity, MAX(page_id) as max_id
FROM mediawiki.page
UNION ALL
SELECT 'old_id', MAX(old_id) FROM mediawiki.text
UNION ALL
SELECT 'rev_id', MAX(rev_id) FROM mediawiki.revision
UNION ALL
SELECT 'comment_id', MAX(comment_id) FROM mediawiki.comment;
EOF
```

**Expected Output:**
```
  entity   | max_id
───────────┼────────
 comment_id|      9
 old_id    |    224
 page_id   |    121
 rev_id    |    999
(4 rows)
```

**All max_ids must be LESS than script starting IDs:**
- comment_id max < 10 ✓
- old_id max < 225 ✓
- page_id max < 122 ✓
- rev_id max < 1000 ✓

**Troubleshooting:**
- If any max_id is >= script starting ID, ID range conflicts
- Update script ID ranges to start higher
- Re-run checks with new ranges

### 4. Create Backup

```bash
# Create timestamped backup
BACKUP_FILE="mediawiki_backup_$(date +%Y%m%d_%H%M%S).sql"
pg_dump -h 192.168.2.30 -U mediawiki mediawiki > "$BACKUP_FILE"
echo "Backup created: $BACKUP_FILE"

# Verify backup size
ls -lh "$BACKUP_FILE"
```

**Expected Output:**
```
Backup created: mediawiki_backup_20260128_143022.sql
-rw-r--r--  1 user  group  15M Jan 28 14:30 mediawiki_backup_20260128_143022.sql
```

**Backup should be:**
- Multiple megabytes (not a few KB)
- Readable text file
- Stored in safe location

---

## Setup Required Data

### If Actor Doesn't Exist

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- Create actor for maintenance script if it doesn't exist
INSERT INTO mediawiki.actor (actor_id, actor_user, actor_name)
VALUES (5, 0, 'Maintenance script')
ON CONFLICT (actor_id) DO NOTHING;

-- Verify creation
SELECT * FROM mediawiki.actor WHERE actor_id = 5;
EOF
```

### If Comment Table Has Different Max ID

```bash
# Check current maximum comment_id
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT MAX(comment_id) FROM mediawiki.comment;"

# If result is >= 10, edit script and change comment IDs
# Example: If MAX is 27, use comment IDs 28-45 instead of 10-27
```

---

## Execution Methods

### Method 1: Direct Execution (Recommended)

```bash
# Most straightforward approach
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql
```

**Advantages:**
- Simple and direct
- All output printed to console
- Easy to see progress

**Output Example:**
```
BEGIN
INSERT 0 1
INSERT 0 1
INSERT 0 1
...
[18 comments inserted]
...
[154 total INSERT statements]
...
COMMIT
SELECT 18
SELECT 18
SELECT 18
...
[Verification queries execute]
```

### Method 2: With Error Logging

```bash
# Capture both stdout and stderr to file
psql -h 192.168.2.30 -U mediawiki -d mediawiki \
  -f fcp_mediawiki_insert_production.sql 2>&1 | tee execution_$(date +%Y%m%d_%H%M%S).log

echo "Execution complete. Log saved to execution_*.log"
```

**Advantages:**
- Captures all output for review
- Timestamps for reference
- Easy to grep for errors

**Reviewing Log:**
```bash
# Check for errors
grep -i error execution_*.log

# Check for warnings
grep -i warning execution_*.log

# View summary (last 20 lines)
tail -20 execution_*.log
```

### Method 3: Step-by-Step with Confirmation

```bash
# Execute in phases for better control
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- Step 1: Begin transaction
BEGIN;

-- Step 2: Insert first comment (test)
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (10, 18732421, 'Initial page content: Keeping food hot', NULL);

-- Verify comment
SELECT COUNT(*) as comment_inserted FROM mediawiki.comment WHERE comment_id = 10;

-- Commit if successful
COMMIT;
EOF
```

### Method 4: Wrapped in Custom Transaction

```bash
# Execute entire script with explicit transaction handling
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- Set transaction isolation for consistency
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Begin implicit transaction
\i fcp_mediawiki_insert_production.sql

-- If we get here, all checks passed
SELECT 'Script executed successfully' as status;
EOF
```

### Method 5: With Progress Tracking

```bash
# Count tables before execution
echo "=== PRE-EXECUTION COUNT ==="
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT 'Before: Pages' as metric, COUNT(*) as count FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139
UNION ALL
SELECT 'Before: Comments', COUNT(*) FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27
UNION ALL
SELECT 'Before: Revisions', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017;
EOF

# Execute script
echo -e "\n=== EXECUTING SCRIPT ==="
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql > /tmp/script_output.txt 2>&1
RESULT=$?
echo "Execution exit code: $RESULT"

# Count tables after execution
echo -e "\n=== POST-EXECUTION COUNT ==="
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT 'After: Pages' as metric, COUNT(*) as count FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139
UNION ALL
SELECT 'After: Comments', COUNT(*) FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27
UNION ALL
SELECT 'After: Revisions', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017;
EOF

# Show script output tail
echo -e "\n=== SCRIPT OUTPUT (last 30 lines) ==="
tail -30 /tmp/script_output.txt
```

**Expected Output:**
```
=== PRE-EXECUTION COUNT ===
 metric          | count
─────────────────┼───────
 Before: Comments|     0
 Before: Pages   |     0
 Before: Revisions|    0

=== EXECUTING SCRIPT ===
Execution exit code: 0

=== POST-EXECUTION COUNT ===
 metric          | count
─────────────────┼───────
 After: Comments |    18
 After: Pages    |    18
 After: Revisions|    18

=== SCRIPT OUTPUT (last 30 lines) ===
[Verification query results showing 18 rows each]
```

---

## Post-Execution Verification

### Quick Verification (30 seconds)

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- Summary statistics
SELECT
  'Comments' as entity, COUNT(*) as count FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27
UNION ALL
SELECT 'Text', COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Content', COUNT(*) FROM mediawiki.content WHERE content_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Revisions', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Slots', COUNT(*) FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Pages', COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
EOF
```

**Expected Result:**
```
    entity   | count
─────────────┼───────
 Comments    |    18
 Content     |    18
 Pages       |    18
 Revisions   |    18
 Slots       |    18
 Text        |    18
(6 rows)
```

### Detailed Verification (2 minutes)

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- 1. Verify all pages exist with correct titles
SELECT
  p.page_id,
  p.page_title,
  p.page_latest,
  CASE
    WHEN p.page_id BETWEEN 122 AND 127 THEN 'Orange'
    WHEN p.page_id BETWEEN 128 AND 129 THEN 'Purple'
    WHEN p.page_id BETWEEN 130 AND 133 THEN 'Red'
    WHEN p.page_id BETWEEN 134 AND 139 THEN 'Teal'
  END as section
FROM mediawiki.page
WHERE p.page_id BETWEEN 122 AND 139
ORDER BY p.page_id;
EOF
```

**Expected Output:**
```
 page_id |      page_title      | page_latest | section
─────────┼──────────────────────┼─────────────┼─────────
     122 | Keeping_food_hot     |        1000 | Orange
     123 | Transporting_food    |        1001 | Orange
     124 | Displaying_food      |        1002 | Orange
     125 | Allergens            |        1003 | Orange
     126 | Labelling            |        1004 | Orange
     127 | B2B_Sales            |        1005 | Orange
     128 | Cleaning_up_closing  |        1006 | Purple
     129 | Maintaining_equipment|        1007 | Purple
     130 | Something_goes_wrong |        1008 | Red
     131 | Dealing_complaints   |        1009 | Red
     132 | Tracing_food         |        1010 | Red
     133 | Recalling_food       |        1011 | Red
     134 | Making_sushi         |        1012 | Teal
     135 | Chinese_roast_duck   |        1013 | Teal
     136 | Doner_kebabs         |        1014 | Teal
     137 | Sous_vide            |        1015 | Teal
     138 | Preparing_red_meat   |        1016 | Teal
     139 | Making_biltong       |        1017 | Teal
(18 rows)
```

### Comprehensive Verification (5 minutes)

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- 2. Verify revision-comment-actor linkage
SELECT
  r.rev_id,
  r.rev_page,
  r.rev_comment_id,
  c.comment_text,
  r.rev_actor,
  a.actor_name,
  r.rev_timestamp
FROM mediawiki.revision r
JOIN mediawiki.comment c ON r.rev_comment_id = c.comment_id
JOIN mediawiki.actor a ON r.rev_actor = a.actor_id
WHERE r.rev_id BETWEEN 1000 AND 1005  -- First 6 (Orange)
ORDER BY r.rev_id;
EOF
```

**Expected Output (first 6 rows):**
```
 rev_id | rev_page | rev_comment_id |              comment_text               | rev_actor |   actor_name      |   rev_timestamp
────────┼──────────┼────────────────┼─────────────────────────────────────────┼───────────┼──────────────────┼─────────────────
   1000 |      122 |             10 | Initial page content: Keeping food hot  |         5 | Maintenance script| 2024-01-15 10:00:00
   1001 |      123 |             11 | Initial page content: Transporting food |         5 | Maintenance script| 2024-01-15 10:01:00
   1002 |      124 |             12 | Initial page content: Displaying food   |         5 | Maintenance script| 2024-01-15 10:02:00
   1003 |      125 |             13 | Initial page content: Allergens         |         5 | Maintenance script| 2024-01-15 10:03:00
   1004 |      126 |             14 | Initial page content: Labelling         |         5 | Maintenance script| 2024-01-15 10:04:00
   1005 |      127 |             15 | Initial page content: B2B Sales         |         5 | Maintenance script| 2024-01-15 10:05:00
(6 rows)
EOF
```

### Content Integrity Verification

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- 3. Verify content integrity (text/content/slot linkage)
SELECT
  t.old_id,
  LENGTH(t.old_text) as actual_length,
  c.content_size as recorded_size,
  CASE
    WHEN LENGTH(t.old_text) = c.content_size THEN 'OK'
    ELSE 'MISMATCH'
  END as size_check,
  s.slot_revision_id,
  CASE
    WHEN s.slot_revision_id = (SELECT rev_id FROM mediawiki.revision WHERE rev_page = p.page_id)
    THEN 'OK'
    ELSE 'MISMATCH'
  END as slot_check
FROM mediawiki.text t
JOIN mediawiki.content c ON t.old_id = c.content_id
JOIN mediawiki.slots s ON c.content_id = s.slot_content_id
JOIN mediawiki.page p ON s.slot_revision_id = (SELECT rev_id FROM mediawiki.revision WHERE rev_page = p.page_id)
WHERE t.old_id BETWEEN 225 AND 232  -- First 8 for sample
ORDER BY t.old_id;
EOF
```

**Expected Output (sample):**
```
 old_id | actual_length | recorded_size | size_check | slot_revision_id | slot_check
────────┼───────────────┼───────────────┼────────────┼──────────────────┼────────────
    225 |           614 |           614 | OK         |             1000 | OK
    226 |           618 |           618 | OK         |             1001 | OK
    227 |           583 |           583 | OK         |             1002 | OK
    228 |           562 |           562 | OK         |             1003 | OK
    229 |           531 |           531 | OK         |             1004 | OK
    230 |           545 |           545 | OK         |             1005 | OK
    231 |           557 |           557 | OK         |             1006 | OK
    232 |           550 |           550 | OK         |             1007 | OK
(8 rows)
```

### Sample Content Retrieval

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
-- 4. Retrieve actual content of a page
SELECT
  p.page_id,
  p.page_title,
  t.old_text,
  c.content_size,
  r.rev_timestamp
FROM mediawiki.page p
JOIN mediawiki.revision r ON p.page_latest = r.rev_id
JOIN mediawiki.slots s ON r.rev_id = s.slot_revision_id
JOIN mediawiki.content c ON s.slot_content_id = c.content_id
JOIN mediawiki.text t ON c.content_id = t.old_id
WHERE p.page_id = 122;  -- Keeping_food_hot
EOF
```

**Expected Output (content shown as first 500 chars):**
```
 page_id |    page_title    | old_text | content_size |   rev_timestamp
─────────┼──────────────────┼──────────┼──────────────┼──────────────────
     122 | Keeping_food_hot | = Know = |          614 | 2024-01-15 10:00:00
         |                  | This ... |              |
```

---

## Error Recovery

### If Execution Fails

**Step 1: Check the error message**
```
ERROR: duplicate key value violates unique constraint "page_pkey"
DETAIL: Key (page_id)=(122) already exists.
```

**Step 2: Identify the problem**
- Pages already exist (someone ran script before)
- IDs conflict with other data
- Database consistency issue

**Step 3: Choose recovery option**

#### Option A: Delete and Retry (Safe)

```bash
# 1. Delete inserted data to start fresh
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
DELETE FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1000 AND 1017;
DELETE FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017;
DELETE FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
DELETE FROM mediawiki.content WHERE content_id BETWEEN 225 AND 242;
DELETE FROM mediawiki.text WHERE old_id BETWEEN 225 AND 242;
DELETE FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27;
EOF

# 2. Verify deletion
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT COUNT(*) as remaining_pages FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
EOF

# 3. Re-run script
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql
```

#### Option B: Use Different ID Ranges

```bash
# 1. Edit script to use different IDs
# Change page_id from 122-139 to 200-217
# Change old_id from 225-242 to 300-317
# Change rev_id from 1000-1017 to 2000-2017
# Change comment_id from 10-27 to 100-117

# 2. Run edited script
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production_updated.sql
```

#### Option C: Restore from Backup

```bash
# Restore database from backup
psql -h 192.168.2.30 -U mediawiki mediawiki < mediawiki_backup_20260128_143022.sql

# Verify restoration
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT COUNT(*) FROM mediawiki.page;"

# Re-run script
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql
```

### Common Error Messages and Solutions

#### "Foreign key violation"
```
ERROR: insert or update on table "revision" violates foreign key constraint
DETAIL: Key (rev_page)=(122) is not present in table "page".
```

**Cause:** Pages not inserted before revisions
**Solution:** Script handles this correctly. If error, check insert order in script.

#### "NOT NULL constraint violation"
```
ERROR: null value in column "content_size" violates not-null constraint
```

**Cause:** Missing required field
**Solution:** Check that content_size is calculated correctly in script

#### "Duplicate key"
```
ERROR: duplicate key value violates unique constraint
```

**Cause:** IDs already exist in database
**Solution:** Use delete and retry, or change ID ranges

---

## Validation Checklists

### Pre-Execution Checklist
- [ ] PostgreSQL connectivity verified
- [ ] Actor ID 5 exists
- [ ] No ID conflicts detected
- [ ] Database backup created
- [ ] Script file located at correct path

### Execution Checklist
- [ ] Running correct execution method
- [ ] Monitoring for errors
- [ ] Exit code is 0 (success)
- [ ] Transaction COMMIT executed
- [ ] No error messages in output

### Post-Execution Checklist
- [ ] All 18 pages inserted
- [ ] All 18 comments created
- [ ] All 18 revisions exist
- [ ] All 18 slots created
- [ ] All foreign keys valid
- [ ] Content integrity verified
- [ ] Page titles correct
- [ ] Timestamps set properly

---

## Performance Notes

**Execution Time:**
- Typical execution: 0.5-2 seconds
- Script size: ~90KB
- Statements: 154 INSERTs
- Database lock time: <100ms

**System Impact:**
- Minimal CPU usage
- Minimal I/O overhead
- No table locks
- Safe concurrent operation

---

## Support and Troubleshooting

**For Issues:**

1. Check error against "Common Error Messages"
2. Review "Error Recovery" section
3. Check database logs:
   ```bash
   tail -100 /var/log/postgresql/postgresql.log
   ```
4. Verify prerequisites all pass
5. Try with backup restore + retry

**Questions:**
- Review PRODUCTION_SCRIPT_README.md
- Review SCHEMA_IMPLEMENTATION_GUIDE.md
- Check script comments for details

---

**Version:** 1.0
**Last Updated:** 2026-01-28
**Status:** Production Ready
