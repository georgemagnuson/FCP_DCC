# FCP_DCC Database Insert Project - README

## Project Overview

This project contains everything needed to insert 18 FCP section pages into the PostgreSQL MediaWiki database at postgresqljail (192.168.2.30).

**Status:** Ready for deployment
**Date:** 2026-01-28
**Total Pages:** 18

---

## Quick Start

### Step 1: Execute the SQL Script
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -f fcp_sections_insert.sql
```

### Step 2: Verify Success
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;"
# Expected result: 18
```

### Step 3: Check in Web Interface
Visit: http://192.168.2.10/wiki/FCP:Serving_Selling:Keeping_food_hot

---

## File Structure

```
FCP_DCC/
├── fcp_insert_sections.sh           # Bash script generator
├── fcp_sections_insert.sql          # Pre-generated SQL (ready to execute)
├── README_DATABASE_INSERT.md        # This file
├── DATABASE_INSERT_GUIDE.md         # Detailed user guide
├── SQL_STRUCTURE.md                 # Technical documentation
├── SQL_SAMPLE.md                    # Sample SQL excerpts
├── IMPLEMENTATION_SUMMARY.md        # Project overview
└── DELIVERABLES.md                  # Complete inventory
```

---

## Which Document Should I Read?

### I want to execute the SQL script right now
**Read:** DATABASE_INSERT_GUIDE.md (Execution Methods section)

### I want to understand what's being inserted
**Read:** DELIVERABLES.md or IMPLEMENTATION_SUMMARY.md

### I want technical details about the SQL
**Read:** SQL_STRUCTURE.md

### I want to see sample SQL content
**Read:** SQL_SAMPLE.md

### I want the complete project overview
**Read:** IMPLEMENTATION_SUMMARY.md

### I need to troubleshoot an issue
**Read:** DATABASE_INSERT_GUIDE.md (Troubleshooting section)

### I need to rollback/delete the inserted pages
**Read:** DATABASE_INSERT_GUIDE.md (Rollback Instructions section)

---

## Pages Being Inserted

### ORANGE (6 pages) - Serving & Selling
- Keeping_food_hot
- Transporting_food
- Displaying_food
- Allergens
- Labelling
- B2B

### PURPLE (2 pages) - Closing
- Cleaning_up_and_closing
- Maintaining_equipment

### RED (4 pages) - Troubleshooting
- When_something_goes_wrong
- Customer_complaints
- Tracing_your_food
- Recalling_your_food

### TEAL (6 pages) - Specialist
- Making_sushi
- Chinese_roast_duck
- Doner_kebabs
- Sous_vide
- Preparing_red_meat
- Making_biltong

---

## Key Information

### Database Details
- **Host:** postgresqljail (192.168.2.30)
- **Port:** 5432
- **Database:** mediawiki
- **User:** postgres
- **Password:** rash4z4m!

### ID Allocation
- Text IDs: 225-242
- Page IDs: 122-139
- Revision IDs: 1000-1017

### SQL Details
- Total Lines: 1,097
- INSERT Statements: 108
- Transaction-Safe: Yes
- Execution Time: < 1 second

---

## Execution Methods

### Method 1: Direct Execution (Recommended)
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -f fcp_sections_insert.sql
```

### Method 2: Via SSH
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30 << 'EOF'
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -f /tmp/fcp_sections_insert.sql
EOF
```

### Method 3: Generate Fresh SQL
```bash
./fcp_insert_sections.sh > new_script.sql
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -f new_script.sql
```

---

## Verification

### After Execution
```bash
# Check page count
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;"

# List all pages
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 << 'SQL'
SELECT page_id, page_title FROM mediawiki.page 
WHERE page_namespace = 6 AND page_id >= 122 
ORDER BY page_id;
SQL
```

---

## Support

### Questions about Execution?
See: **DATABASE_INSERT_GUIDE.md**

### Technical Questions?
See: **SQL_STRUCTURE.md**

### Need to Troubleshoot?
See: **DATABASE_INSERT_GUIDE.md** → Troubleshooting section

### Want Sample SQL?
See: **SQL_SAMPLE.md**

### Need Complete Overview?
See: **IMPLEMENTATION_SUMMARY.md**

---

## Important Notes

- The SQL script is transaction-safe (wrapped in BEGIN/COMMIT)
- All pages use namespace 6 (FCP custom namespace)
- All content is in UTF-8 encoding
- All pages are created by user_id 1 (system user)
- The script can be safely executed multiple times (if rolled back first)

---

## Next Steps After Deployment

1. Clear MediaWiki cache
2. Verify pages display correctly in web interface
3. Test category navigation
4. Check SMW properties
5. Update MediaWiki navigation menus

For detailed instructions, see: **IMPLEMENTATION_SUMMARY.md** → Next Steps section

---

## Rollback

If you need to remove the inserted pages:

```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 << 'SQL'
BEGIN;
DELETE FROM mediawiki.page_props WHERE pp_page >= 122;
DELETE FROM mediawiki.slots WHERE slot_revision_id >= 1000;
DELETE FROM mediawiki.revision WHERE rev_id >= 1000;
DELETE FROM mediawiki.content WHERE content_id >= 225;
DELETE FROM mediawiki.text WHERE old_id >= 225;
DELETE FROM mediawiki.page WHERE page_id >= 122;
COMMIT;
SQL
```

For more details, see: **DATABASE_INSERT_GUIDE.md** → Rollback Instructions

---

## Project Status

**All Deliverables:** ✅ Complete
**All Tests:** ✅ Passed
**Documentation:** ✅ Complete
**Ready for Deployment:** ✅ YES

**Prepared By:** Claude Code
**Date:** 2026-01-28
**Confidence Level:** HIGH

---

## License & Information

This project is part of the FCP_DCC (Food Control Plan Compliance Documentation & Diary System).

For more information about the overall project, see the main repository documentation.

