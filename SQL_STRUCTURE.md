# FCP_DCC SQL Structure Documentation

## Overview

This document describes the SQL structure used to insert FCP section pages into the MediaWiki database.

## SQL Execution Sequence

Each page insertion follows this sequence:

### 1. Insert Text Content
```sql
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
($TEXT_ID, '$CONTENT', 'utf-8');
```

- Stores the actual wikitext content of the page
- Uses UTF-8 encoding
- Content includes Know/Do/Show sections and categories

### 2. Insert Content Metadata
```sql
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
($CONTENT_ID, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = $TEXT_ID), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = $TEXT_ID)::bytea), 
 'wikitext', 'tt:$TEXT_ID');
```

- Metadata for the text content
- Automatically calculates content size using LENGTH()
- Generates SHA1 hash using SHA1() function
- Model is always 'wikitext'
- Address uses format 'tt:$TEXT_ID'

### 3. Insert Revision Record
```sql
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
($REV_ID, $PAGE_ID, '$TIMESTAMP', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');
```

- Timestamp format: YYYYMMDDHHMMSS (UTC)
- User ID 1 = System/Admin user
- Minor edit = 0 (false)
- Deleted = 0 (not deleted)
- Parent ID = NULL (first revision)

### 4. Insert Slot Linking
```sql
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
($REVISION_ID, 1, $CONTENT_ID, $REVISION_ID);
```

- Links revision to content via slots
- Role ID 1 = 'main' slot
- Origin = revision ID (original source)

### 5. Insert Page Record
```sql
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
($PAGE_ID, 6, '$TITLE', 0, 1, $REVISION_ID, 0);
```

- Namespace 6 = FCP custom namespace (colon-separated titles)
- Title = portion after last colon (e.g., "Keeping_food_hot")
- Page is new = 1 (true)
- Latest = revision ID of this page's latest revision
- Underscores replace spaces in titles

### 6. Insert SMW Properties
```sql
INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
($PAGE_ID, 'smw_id', '$PAGE_ID');
```

- Creates Semantic MediaWiki property
- Links page to SMW object ID

## Data Types and Constraints

| Table | Column | Type | Notes |
|-------|--------|------|-------|
| text | old_id | INT | PRIMARY KEY |
| text | old_text | TEXT | Page wikitext content |
| text | old_flags | VARCHAR | Usually 'utf-8' |
| content | content_id | INT | PRIMARY KEY |
| content | content_size | INT | Calculated from text length |
| content | content_sha1 | CHAR(32) | SHA1 hash in hex |
| content | content_model | VARCHAR | Always 'wikitext' |
| content | content_address | VARCHAR | Format: 'tt:TEXT_ID' |
| revision | rev_id | INT | PRIMARY KEY |
| revision | rev_page | INT | FOREIGN KEY to page.page_id |
| revision | rev_timestamp | CHAR(14) | UTC format YYYYMMDDHHMMSS |
| revision | rev_user | INT | User ID (1 for system) |
| revision | rev_minor_edit | TINYINT | 0 or 1 |
| revision | rev_deleted | TINYINT | 0 = not deleted |
| revision | rev_len | INT | NULL for new pages |
| revision | rev_parent_id | INT | NULL for first revision |
| revision | rev_content_model | VARCHAR | Always 'wikitext' |
| revision | rev_content_format | VARCHAR | Always 'text/x-wiki' |
| slots | slot_revision_id | INT | FOREIGN KEY to revision |
| slots | slot_role_id | INT | 1 = main slot |
| slots | slot_content_id | INT | FOREIGN KEY to content |
| slots | slot_origin | INT | Usually revision ID |
| page | page_id | INT | PRIMARY KEY |
| page | page_namespace | INT | 6 for FCP pages |
| page | page_title | VARCHAR | Title without namespace |
| page | page_is_redirect | TINYINT | 0 = not a redirect |
| page | page_is_new | TINYINT | 1 = newly created |
| page | page_latest | INT | Latest revision ID |
| page | page_len | INT | 0 for new pages |
| page_props | pp_page | INT | FOREIGN KEY to page |
| page_props | pp_propname | VARCHAR | Property name |
| page_props | pp_value | BLOB | Property value |

## Title Handling

Page titles use MediaWiki's colon-separated format:

- **Full page name:** `FCP:Serving_Selling:Keeping_food_hot`
- **Namespace:** `FCP:` (namespace 6)
- **Title stored in DB:** `Keeping_food_hot`
- **Title separators:** Colons become full page paths
- **Space replacement:** Spaces → underscores (e.g., "keeping food hot" → "keeping_food_hot")

## Content Structure

Each page contains standardized sections:

```wikitext
= Know =

This section covers the key principles for [PAGE_NAME].

== Key Points ==
* Understanding the importance of [PAGE_NAME]
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for [PAGE_NAME]
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of [PAGE_NAME] procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:SECTION_NAME|SECTION_NAME]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:SECTION_NAME]]
```

## Character Escaping

Single quotes in SQL content are escaped:
- Input: `What's wrong?`
- Escaped: `What''s wrong?`
- Regex: `s/'/''/g`

## Transaction Safety

The entire insert is wrapped in a transaction:

```sql
BEGIN;
-- All INSERT statements
COMMIT;
```

Benefits:
- All-or-nothing execution
- Atomic operations
- Easy rollback if errors occur
- Data consistency guaranteed

## ID Allocation Strategy

| Entity | Start | End | Range | Purpose |
|--------|-------|-----|-------|---------|
| Text (old_id) | 225 | 242 | 225-242 | Page content storage |
| Page (page_id) | 122 | 139 | 122-139 | Page registry |
| Revision (rev_id) | 1000 | 1017 | 1000-1017 | Edit history |
| Slot (slot_id) | 500 | 517 | 500-517 | Content linking |

Allocation is sequential to prevent ID conflicts:
- Previous Magenta section: Text 200-224, Page 97-121
- Orange/Purple/Red/Teal: Text 225-242, Page 122-139

## Verification Queries

After insertion, verify data integrity:

```sql
-- Count all inserted pages
SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;

-- Count text records
SELECT COUNT(*) FROM mediawiki.text WHERE old_id >= 225;

-- Verify text-content link
SELECT t.old_id, c.content_id, c.content_model 
FROM mediawiki.text t 
JOIN mediawiki.content c ON t.old_id = c.content_id 
WHERE t.old_id >= 225;

-- List all FCP pages by section
SELECT p.page_id, p.page_title, p.page_latest 
FROM mediawiki.page p 
WHERE p.page_namespace = 6 AND p.page_id >= 122 
ORDER BY p.page_id;

-- Check revision status
SELECT COUNT(*), MIN(rev_id), MAX(rev_id) 
FROM mediawiki.revision 
WHERE rev_id >= 1000;
```

## Performance Notes

- Total SQL file size: ~38KB
- Number of SQL statements: 108 (6 per page × 18 pages)
- Execution time: <1 second (typical)
- Transaction safety: Yes (wrapped in BEGIN/COMMIT)
- Rollback: Simple DELETE queries (see guide)

## Common Issues and Solutions

### Duplicate Key Error
- **Cause:** IDs conflict with existing data
- **Solution:** Check MAX(old_id), MAX(page_id), MAX(rev_id) before inserting
- **Adjust:** Update starting IDs if needed and regenerate script

### Foreign Key Violation
- **Cause:** Page_id doesn't exist when linking
- **Solution:** Ensure page INSERT runs before revision INSERT (order in script)

### Character Encoding Issues
- **Cause:** Non-UTF8 characters in content
- **Solution:** Verify content uses UTF-8, check old_flags column

### SHA1 Hash Mismatch
- **Cause:** Content modified after initial insert
- **Solution:** SHA1 is calculated dynamically by SELECT, regenerate if needed

---

**Last Updated:** 2026-01-28
**Script Version:** 1.0
**MediaWiki Version:** 1.43.5
**PostgreSQL Version:** 17.0
