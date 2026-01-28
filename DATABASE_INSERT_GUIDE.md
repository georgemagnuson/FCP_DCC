# FCP_DCC Database Insert Guide

## Overview

This guide explains how to insert Orange, Purple, Red, and Teal section pages into the PostgreSQL MediaWiki database on postgresqljail (192.168.2.30).

**Files:**
- `fcp_insert_sections.sh` - Bash script generator (creates SQL dynamically)
- `fcp_sections_insert.sql` - Pre-generated SQL statements (ready to execute)

## Database Information

| Property | Value |
|----------|-------|
| Host | postgresqljail (192.168.2.30) |
| Port | 5432 |
| Database | mediawiki |
| User | postgres |
| Password | rash4z4m! |

## Pages Being Inserted

### ORANGE SECTION - Serving & Selling (6 pages)
- FCP:Serving_Selling:Keeping_food_hot
- FCP:Serving_Selling:Transporting_food
- FCP:Serving_Selling:Displaying_food
- FCP:Serving_Selling:Allergens
- FCP:Serving_Selling:Labelling
- FCP:Serving_Selling:B2B

### PURPLE SECTION - Closing (2 pages)
- FCP:Closing:Cleaning_up_and_closing
- FCP:Closing:Maintaining_equipment

### RED SECTION - Troubleshooting (4 pages)
- FCP:Troubleshooting:When_something_goes_wrong
- FCP:Troubleshooting:Customer_complaints
- FCP:Troubleshooting:Tracing_your_food
- FCP:Troubleshooting:Recalling_your_food

### TEAL SECTION - Specialist Cooking Methods (6 pages)
- FCP:Specialist:Making_sushi
- FCP:Specialist:Chinese_roast_duck
- FCP:Specialist:Doner_kebabs
- FCP:Specialist:Sous_vide
- FCP:Specialist:Preparing_red_meat
- FCP:Specialist:Making_biltong

**Total: 18 pages**

## ID Allocation

| Type | Start | End | Count |
|------|-------|-----|-------|
| Text ID | 225 | 242 | 18 |
| Page ID | 122 | 139 | 18 |
| Revision ID | 1000 | 1017 | 18 |
| Slot ID | 500 | 517 | 18 |

## Database Tables Modified

The insert script populates the following MediaWiki tables:

1. **mediawiki.text** - Page content (wikitext format)
2. **mediawiki.content** - Content metadata (size, SHA1 hash, model)
3. **mediawiki.revision** - Revision history (timestamps, user info)
4. **mediawiki.slots** - Slot linking (connects revisions to content)
5. **mediawiki.page** - Page registry (namespace 6 for FCP)
6. **mediawiki.page_props** - SMW properties (semantic data)

## Execution Methods

### Method 1: Direct SQL Execution (Recommended)

Execute the pre-generated SQL file directly:

```bash
# From your local machine (if on network)
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -f fcp_sections_insert.sql

# Verify success
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;"
```

### Method 2: Via SSH to postgresqljail

Execute remotely via SSH tunnel:

```bash
# Execute on postgresqljail
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30 \
  "psql -U postgres -d mediawiki -f -" < fcp_sections_insert.sql

# Or with password:
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30 << 'EOFSH'
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -f /tmp/fcp_sections_insert.sql
EOFSH
```

### Method 3: Copy and Execute on Server

1. Copy the SQL file to the server:
```bash
scp -i ~/.ssh/id_rsa fcp_sections_insert.sql \
  georgemagnuson@192.168.2.30:/tmp/
```

2. SSH into the server and execute:
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30
psql -U postgres -d mediawiki -f /tmp/fcp_sections_insert.sql
```

### Method 4: Regenerate SQL (if needed)

The bash script can regenerate the SQL statements:

```bash
# Generate fresh SQL (with updated timestamps)
./fcp_insert_sections.sh > fcp_sections_insert_new.sql

# Review and execute
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -f fcp_sections_insert_new.sql
```

## Page Structure

Each page follows the MediaWiki convention with Know/Do/Show sections:

### Know Section
- Key principles and understanding
- Best practices
- Compliance requirements

### Do Section
- Practical procedures
- Step-by-step instructions
- Recording and documentation

### Show Section
- Evidence requirements
- Training records
- Audit trails

## Verification

After execution, verify the pages were created:

```bash
# Count inserted pages
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 << 'SQL'
SELECT page_id, page_title, page_namespace 
FROM mediawiki.page 
WHERE page_namespace = 6 AND page_id >= 122 
ORDER BY page_id;
SQL

# Check text content
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 << 'SQL'
SELECT COUNT(*) as text_count 
FROM mediawiki.text 
WHERE old_id >= 225;
SQL

# View in MediaWiki web interface
# Visit: http://192.168.2.10/wiki/FCP:Serving_Selling:Keeping_food_hot
```

## Rollback Instructions

If you need to remove the inserted pages, use this query:

```sql
-- WARNING: This will delete all inserted data!
BEGIN;

DELETE FROM mediawiki.page_props WHERE pp_page >= 122;
DELETE FROM mediawiki.slots WHERE slot_revision_id >= 1000;
DELETE FROM mediawiki.revision WHERE rev_id >= 1000;
DELETE FROM mediawiki.content WHERE content_id >= 225;
DELETE FROM mediawiki.text WHERE old_id >= 225;
DELETE FROM mediawiki.page WHERE page_id >= 122;

COMMIT;

-- Verify deletion
SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;
```

## Notes

- The SQL script uses transactions (BEGIN/COMMIT) for safety
- All timestamps are in UTC (Z)
- Page content uses UTF-8 encoding
- The namespace prefix "6" represents the FCP custom namespace
- SMW properties are created automatically for semantic integration
- All content is initially created by user_id 1 (system user)

## Troubleshooting

### Connection Issues

```bash
# Test PostgreSQL connectivity
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 -c "SELECT version();"

# Check if postgresqljail is reachable
ping 192.168.2.30
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30 "echo 'Connected'"
```

### SQL Errors

If you encounter SQL errors:

1. Check that the starting IDs don't conflict with existing data:
```sql
SELECT MAX(old_id) FROM mediawiki.text;
SELECT MAX(page_id) FROM mediawiki.page;
SELECT MAX(rev_id) FROM mediawiki.revision;
```

2. Review the generated SQL for issues:
```bash
grep "INSERT INTO" fcp_sections_insert.sql | head -10
```

3. Try executing with verbose output:
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  --echo-all -f fcp_sections_insert.sql
```

## Security Notes

- The password in this guide is for reference only
- Never commit passwords to version control
- Always use SSH keys when available
- Consider using .pgpass for password management:
```bash
# Create ~/.pgpass
echo "192.168.2.30:5432:mediawiki:postgres:rash4z4m!" > ~/.pgpass
chmod 600 ~/.pgpass

# Then execute without PGPASSWORD:
psql -U postgres -d mediawiki -h 192.168.2.30 -f fcp_sections_insert.sql
```

## Support

For issues or questions:
1. Check the generated SQL file for correctness
2. Verify database connectivity
3. Review MediaWiki logs at `/usr/local/www/mediawiki/` on llamajail
4. Check PostgreSQL logs on postgresqljail

---

**Last Updated:** 2026-01-28
**Script Version:** 1.0
**Database:** MediaWiki 1.43.5
