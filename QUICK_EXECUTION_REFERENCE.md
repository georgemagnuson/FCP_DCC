# Quick Execution Reference Card

## One-Line Execution

```bash
pg_dump -h 192.168.2.30 -U mediawiki mediawiki > backup_$(date +%Y%m%d_%H%M%S).sql && psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql && psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;"
```

## Pre-Flight Checks (60 seconds)

```bash
# 1. Database available?
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT 1;" && echo "✓ Connected"

# 2. Actor 5 exists?
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT COUNT(*) FROM mediawiki.actor WHERE actor_id = 5;" && echo "✓ Actor exists"

# 3. No ID conflicts?
psql -h 192.168.2.30 -U mediawiki -d mediawiki -c "SELECT MAX(page_id), MAX(old_id), MAX(rev_id), MAX(comment_id) FROM mediawiki.page, mediawiki.text, mediawiki.revision, mediawiki.comment;"
# All values should be: <122, <225, <1000, <10
```

## Execute (2 minutes)

```bash
# With backup
pg_dump -h 192.168.2.30 -U mediawiki mediawiki > backup_$(date +%Y%m%d_%H%M%S).sql && \
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql

# Or without backup (if you already have one)
psql -h 192.168.2.30 -U mediawiki -d mediawiki -f fcp_mediawiki_insert_production.sql
```

## Quick Verify (30 seconds)

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
SELECT 'Comments' as type, COUNT(*) FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27
UNION ALL
SELECT 'Pages', COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139
UNION ALL
SELECT 'Revisions', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017;
EOF
# All should show 18
```

## Expected Result

```
    type    | count
─────────────┼───────
 Comments   |    18
 Pages      |    18
 Revisions  |    18
(3 rows)
```

## Common Issues & Fixes

| Issue | Fix |
|-------|-----|
| Connection refused | Check IP 192.168.2.30 is correct, PostgreSQL running |
| Actor 5 not found | Create with: `INSERT INTO mediawiki.actor VALUES (5, 0, 'Maintenance script');` |
| Duplicate key error | IDs exist. Delete with: `DELETE FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;` (and slots, revision, content, text, comment) |
| Foreign key error | Check insert order (script is correct, but check if rows were partially inserted) |

## File Locations

**Script:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/fcp_mediawiki_insert_production.sql`
**Docs:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/PRODUCTION_SCRIPT_README.md`

## Pages Inserted (18 Total)

**Orange (6):** Keeping_food_hot, Transporting_food, Displaying_food, Allergens, Labelling, B2B_Sales

**Purple (2):** Cleaning_up_closing, Maintaining_equipment

**Red (4):** Something_goes_wrong, Dealing_complaints, Tracing_food, Recalling_food

**Teal (6):** Making_sushi, Chinese_roast_duck, Doner_kebabs, Sous_vide, Preparing_red_meat, Making_biltong

## ID Allocation

| Type | Range | Count |
|------|-------|-------|
| comment_id | 10-27 | 18 |
| old_id (text) | 225-242 | 18 |
| content_id | 225-242 | 18 |
| rev_id | 1000-1017 | 18 |
| page_id | 122-139 | 18 |

## Rollback If Needed

```bash
psql -h 192.168.2.30 -U mediawiki -d mediawiki << 'EOF'
DELETE FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1000 AND 1017;
DELETE FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017;
DELETE FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
DELETE FROM mediawiki.content WHERE content_id BETWEEN 225 AND 242;
DELETE FROM mediawiki.text WHERE old_id BETWEEN 225 AND 242;
DELETE FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27;
EOF
```

---

**Version:** 1.0 | **Updated:** 2026-01-28 | **Status:** Production Ready
