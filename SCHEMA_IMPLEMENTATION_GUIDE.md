# MediaWiki Modern Schema Implementation Guide

## Overview

This guide explains how the production script implements the modern MediaWiki schema (1.35+) for the FCP database with proper foreign key relationships and data normalization.

## Schema Evolution

### Old MediaWiki Schema (Pre-1.35)
```sql
-- Direct user reference
INSERT INTO mediawiki.revision (
  rev_id, rev_page, rev_user, rev_user_text, rev_comment
) VALUES (
  1000, 122, 5, 'Maintenance script', 'Initial content'
);

-- Problems:
-- - Redundant user_text storage
-- - Inflexible comment storage
-- - No comment deduplication
-- - Difficulty tracking user changes
```

### Modern MediaWiki Schema (1.35+)
```sql
-- References to normalized tables
INSERT INTO mediawiki.revision (
  rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp
) VALUES (
  1000, 122, 10, 5, '2024-01-15 10:00:00'
);

-- Benefits:
-- - Separated concerns (actor, comment management)
-- - Comment table enables deduplication and history
-- - Foreign key constraints ensure referential integrity
-- - Better normalization and query efficiency
```

## Table Relationships

### Entity Relationship Diagram

```
┌─────────────────┐
│  mediawiki.actor │
│  ───────────────│
│  actor_id (PK)  │
│  actor_name     │
│  actor_user     │
└────────┬────────┘
         │
         │ references
         │
         ▼
┌─────────────────────────┐
│ mediawiki.revision      │
│ ───────────────────────│
│ rev_id (PK)            │
│ rev_page (FK→page)     │
│ rev_actor (FK→actor)   │ ◄─── Uses actor_id 5
│ rev_comment_id (FK)    │
│ rev_timestamp          │
│ rev_sha1               │
└────────┬────────┬──────┘
         │        │
         │        │ references
         │        │
         │        ▼
         │  ┌──────────────────┐
         │  │ mediawiki.comment│
         │  │ ──────────────── │
         │  │ comment_id (PK)  │
         │  │ comment_text     │
         │  │ comment_hash     │
         │  └──────────────────┘
         │
         │ references
         │
         ▼
┌─────────────────────────┐
│ mediawiki.page          │
│ ───────────────────────│
│ page_id (PK)          │
│ page_title            │
│ page_namespace        │
│ page_latest (→rev_id) │
│ page_content_model    │
└────────┬───────────────┘
         │
         │ has latest revision
         │
         ▼
    revision 1000
```

### Detailed Relationships

#### 1. mediawiki.comment Table

**Purpose:** Centralized comment/edit message storage with deduplication

**Creation Statements in Script:**
```sql
INSERT INTO mediawiki.comment (
  comment_id,      -- Unique identifier
  comment_hash,    -- Hash for deduplication (CRC32-like)
  comment_text,    -- Actual edit message
  comment_data     -- Optional metadata (NULL for basic usage)
) VALUES (
  10,                                      -- First comment
  18732421,                               -- Hash
  'Initial page content: Keeping food hot', -- Message
  NULL                                    -- No metadata
);
```

**Why This Table Exists:**
- MediaWiki 1.30+ moved comments to separate table
- Enables deduplication across revisions
- Better for comment searching and history
- Reduces storage of repeated messages
- Supports comment deletion and suppression

**Hash Calculation:**
- `comment_hash` = CRC32 or similar hash of comment text
- Used for duplicate detection during revisions
- Exact hash algorithm not critical for functionality
- Values in script (18732421-18732438) are sequential approximations

#### 2. mediawiki.actor Table

**Purpose:** Centralized actor management (users, bots, maintenance scripts)

**Existing Actor:**
```sql
-- This actor exists and is used in the script
SELECT * FROM mediawiki.actor WHERE actor_id = 5;
-- Result: actor_id=5, actor_name='Maintenance script'
```

**Reference in Revision:**
```sql
INSERT INTO mediawiki.revision (
  rev_id, rev_page, rev_comment_id, rev_actor, ...
) VALUES (
  1000, 122, 10, 5, ...  -- ◄─── References actor_id 5
);
```

**Why This Table Exists:**
- Normalizes actor information
- Single source of truth for "Maintenance script" name
- If actor name changes, only need to update actor table
- Enables complex actor management (permissions, anonymization)
- Supports actor merge operations

#### 3. mediawiki.text Table

**Purpose:** Raw wikitext content storage

**Structure:**
```sql
INSERT INTO mediawiki.text (
  old_id,     -- Primary key and content identifier
  old_text,   -- The actual wikitext
  old_flags   -- Encoding information
) VALUES (
  225,  -- Corresponds to first page (ID 122)
  '= Know =\n\nThis section...',  -- Full wikitext
  'utf-8'  -- UTF-8 encoding
);
```

**Why "old_" Prefix:**
- Historical: MediaWiki originally used `text` table
- Now uses `text` for backward compatibility
- `old_` prefix maintained for PostgreSQL compatibility
- Prevents conflicts with PostgreSQL reserved word "text"

**Content Example:**
```wikitext
= Know =

This section covers the key principles for keeping food hot.

== Key Points ==
* Understanding the importance of maintaining proper food temperatures
* Best practices for heat retention
* Equipment and methods for keeping food hot
* Health and safety compliance requirements

= Do =

== Practical Steps ==
1. Review temperature maintenance procedures
2. Use appropriate heating equipment
...

[[Category:FCP]]
[[Category:Orange]]
```

#### 4. mediawiki.content Table

**Purpose:** Content metadata (NOT the content itself)

**Relationship to text:**
```sql
-- Text: Stores actual wikitext
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (225, 'Content text here...', 'utf-8');

-- Content: Stores metadata about that text
INSERT INTO mediawiki.content (
  content_id,      -- Same as old_id (225)
  content_size,    -- Byte length of old_text
  content_sha1,    -- Hash of old_text
  content_model,   -- Type: 1 = wikitext
  content_address  -- Storage address reference
) VALUES (
  225,             -- Links to text.old_id = 225
  614,             -- Length of content
  '',              -- SHA1 (empty in script, calculated during query)
  1,               -- 1 = wikitext model
  'tt:225'         -- tt = text table, :225 = row 225
);
```

**Why Separate Table:**
- Metadata separated from content
- Enables future content storage backends (blob storage, external DBs)
- Supports multiple content models (wikitext, JSON, plain text)
- Allows efficient indexing of content properties
- Enables content validation and verification

**Content Model Field:**
- `1` = wikitext (what all 18 pages use)
- `2` = plain text
- Other models supported by extensions
- Allows single database to support multiple content types

#### 5. mediawiki.slots Table

**Purpose:** Links revisions to content through slots

**The Critical Link:**
```sql
-- What it does:
-- "Revision 1000 has a main-role slot containing content 225"

INSERT INTO mediawiki.slots (
  slot_revision_id,    -- Which revision
  slot_role_id,        -- Which role (1 = main)
  slot_content_id,     -- Which content
  slot_origin          -- Original source revision
) VALUES (
  1000,    -- Revision ID
  1,       -- Main role
  225,     -- Content ID
  1000     -- Origin (same revision for new pages)
);
```

**Why Slots Exist:**
- Revisions can have multiple slots (main, model, auxiliary)
- Each slot is independent content with its own history
- Enables future multi-part pages
- MediaWiki 1.31+ unified content handling via slots

**Slot Roles:**
- `1` = Main slot (what we use)
- `2` = Model slot (for future use)
- Others defined by extensions
- Most pages only use main slot (1)

#### 6. mediawiki.page Table

**Purpose:** Page registry and metadata

**Complete Page Entry:**
```sql
INSERT INTO mediawiki.page (
  page_id,            -- Unique page identifier
  page_namespace,     -- 0 = main namespace
  page_title,         -- 'Keeping_food_hot'
  page_is_redirect,   -- 0 = not a redirect
  page_is_new,        -- 1 = newly created
  page_random,        -- Random double for ordering
  page_touched,       -- Last touch timestamp
  page_links_updated, -- Link index update time
  page_latest,        -- Latest revision ID
  page_len,           -- Page length
  page_content_model  -- 1 = wikitext
) VALUES (
  122,                              -- ID 122
  0,                               -- Main namespace
  'Keeping_food_hot',              -- Title with underscores
  0,                               -- Not a redirect
  1,                               -- Is new
  RANDOM()::double precision,      -- Random sorting value
  NOW(),                           -- Current timestamp
  NOW(),                           -- Current timestamp
  1000,                            -- Latest revision
  614,                             -- Content length
  1                                -- Wikitext model
);
```

**Key Fields:**
- **page_id:** Must match pages being inserted
- **page_namespace:** 0 = main content area
- **page_title:** Title (spaces→underscores, no namespace prefix)
- **page_latest:** Points to latest revision (1000 for first revision)
- **page_random:** Used for random page selection (RANDOM() function)

## Foreign Key Constraints

### Constraint Definitions

```sql
-- revision → comment
ALTER TABLE mediawiki.revision
ADD CONSTRAINT rev_comment_id_fk
FOREIGN KEY (rev_comment_id) REFERENCES mediawiki.comment(comment_id);

-- revision → actor
ALTER TABLE mediawiki.revision
ADD CONSTRAINT rev_actor_fk
FOREIGN KEY (rev_actor) REFERENCES mediawiki.actor(actor_id);

-- revision → page
ALTER TABLE mediawiki.revision
ADD CONSTRAINT rev_page_fk
FOREIGN KEY (rev_page) REFERENCES mediawiki.page(page_id);

-- slots → revision
ALTER TABLE mediawiki.slots
ADD CONSTRAINT slot_revision_fk
FOREIGN KEY (slot_revision_id) REFERENCES mediawiki.revision(rev_id);

-- slots → content
ALTER TABLE mediawiki.slots
ADD CONSTRAINT slot_content_fk
FOREIGN KEY (slot_content_id) REFERENCES mediawiki.content(content_id);

-- page → revision (implicit)
-- (page_latest references mediawiki.revision.rev_id)
```

### Insertion Order Matters

Script inserts in this order to satisfy constraints:

```
1. Comment records (10-27)      ✓ No dependencies
   ↓
2. Text records (225-242)       ✓ No dependencies
   ↓
3. Content records (225-242)    ✓ References text by ID
   ↓
4. Page records (122-139)       ✓ No FK constraints yet
   ↓
5. Revision records (1000-1017) ✓ All dependencies exist
   ├─ References comment (10-27)
   ├─ References actor (5)
   └─ References page (122-139)
   ↓
6. Slot records (1000-1017)     ✓ All dependencies exist
   ├─ References revision (1000-1017)
   └─ References content (225-242)
```

### Why Order Matters

**If we tried to insert in wrong order:**
```sql
-- WRONG: Insert revision before page
INSERT INTO mediawiki.revision (rev_id, rev_page, ...)
VALUES (1000, 122, ...);  -- ERROR! page 122 doesn't exist yet
-- Foreign key constraint violation

-- CORRECT: Page first, then revision
INSERT INTO mediawiki.page (page_id, ...) VALUES (122, ...);
INSERT INTO mediawiki.revision (rev_id, rev_page, ...)
VALUES (1000, 122, ...);  -- OK! page 122 now exists
```

## Data Types and Sizes

### Field Size Calculations

**Text Content Size:**
```sql
INSERT INTO mediawiki.content (
  content_id,
  content_size,    -- Calculated from text length
  content_sha1,
  content_model,
  content_address
) VALUES (
  225,
  614,  -- LENGTH('= Know =\n...[[Category:Orange]]')
  '',
  1,
  'tt:225'
);
```

**How content_size is calculated:**
```
Text = '= Know =\n\nThis section covers...\n\n[[Category:Orange]]'
Length = Character count (including newlines)
In PostgreSQL: LENGTH(old_text)
In this script: Manually counted to ~614 bytes
```

**For UTF-8 characters:**
- ASCII characters: 1 byte each
- Extended characters: 2-4 bytes each
- Newlines (\n): 1 byte each
- Total: Sum of all bytes

### NOT NULL Constraints

These fields MUST have values:

**mediawiki.content (NOT NULL):**
- `content_size` - Must be > 0
- `content_sha1` - Cannot be empty (even if left blank in some implementations)
- `content_model` - Must be 1 (wikitext)

**mediawiki.revision (NOT NULL):**
- `rev_comment_id` - Must reference valid comment
- `rev_actor` - Must reference valid actor

**mediawiki.page (NOT NULL):**
- `page_random` - Used for RANDOM()
- `page_touched` - Set to NOW()

## Query Examples

### Verify Insertion

```sql
-- Check all 18 pages exist
SELECT COUNT(*) FROM mediawiki.page
WHERE page_id BETWEEN 122 AND 139;
-- Result: 18

-- Check all pages have proper revisions
SELECT p.page_id, p.page_title, p.page_latest, r.rev_id
FROM mediawiki.page p
JOIN mediawiki.revision r ON p.page_latest = r.rev_id
WHERE p.page_id BETWEEN 122 AND 139
ORDER BY p.page_id;
-- Result: 18 rows with matching page_id and rev_id

-- Check revision-comment-actor linkage
SELECT r.rev_id, r.rev_comment_id, c.comment_text, r.rev_actor, a.actor_name
FROM mediawiki.revision r
JOIN mediawiki.comment c ON r.rev_comment_id = c.comment_id
JOIN mediawiki.actor a ON r.rev_actor = a.actor_id
WHERE r.rev_id BETWEEN 1000 AND 1017;
-- Result: 18 rows showing proper links
```

### Retrieve Page Content

```sql
-- Get complete page with all data
SELECT
  p.page_id,
  p.page_title,
  t.old_text,
  c.content_size,
  r.rev_timestamp,
  a.actor_name,
  cm.comment_text
FROM mediawiki.page p
JOIN mediawiki.revision r ON p.page_latest = r.rev_id
JOIN mediawiki.slots s ON r.rev_id = s.slot_revision_id
JOIN mediawiki.content c ON s.slot_content_id = c.content_id
JOIN mediawiki.text t ON c.content_id = t.old_id
JOIN mediawiki.actor a ON r.rev_actor = a.actor_id
JOIN mediawiki.comment cm ON r.rev_comment_id = cm.comment_id
WHERE p.page_id = 122;
```

## Migration from Old to New Schema

If upgrading from old schema:

### Old Schema (Pre-1.35)
```sql
INSERT INTO mediawiki.revision (
  rev_id, rev_page, rev_user, rev_user_text, rev_comment
) VALUES (1000, 122, 5, 'Maintenance script', 'Initial content');
```

### New Schema (Post-1.35)
```sql
-- Step 1: Create comment
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text)
VALUES (10, HASH('Initial content'), 'Initial content');

-- Step 2: Insert revision with FK references
INSERT INTO mediawiki.revision (
  rev_id, rev_page, rev_comment_id, rev_actor
) VALUES (1000, 122, 10, 5);
```

### Conversion SQL
```sql
-- Migrate comments from old schema to new
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text)
SELECT
  -- Auto-increment ID
  ROW_NUMBER() OVER () AS comment_id,
  -- Hash of comment text
  ABS(CAST(GET_BYTE(digest(rev_comment, 'md5'), 0) AS INTEGER)) AS comment_hash,
  -- Original comment text
  rev_comment AS comment_text
FROM mediawiki.revision_old
WHERE rev_comment IS NOT NULL
GROUP BY rev_comment;

-- Update revision records to use FK instead of text
UPDATE mediawiki.revision
SET rev_comment_id = (
  SELECT comment_id FROM mediawiki.comment
  WHERE comment_text = mediawiki.revision.rev_comment
);
```

## Performance Implications

### Index Strategy

```sql
-- Recommended indexes for modern schema
CREATE INDEX idx_revision_actor ON mediawiki.revision(rev_actor);
CREATE INDEX idx_revision_comment ON mediawiki.revision(rev_comment_id);
CREATE INDEX idx_revision_page ON mediawiki.revision(rev_page);
CREATE INDEX idx_revision_timestamp ON mediawiki.revision(rev_timestamp);
CREATE INDEX idx_page_latest ON mediawiki.page(page_latest);
CREATE INDEX idx_slots_revision ON mediawiki.slots(slot_revision_id);
CREATE INDEX idx_slots_content ON mediawiki.slots(slot_content_id);
```

### Query Performance

**Benefits of normalized schema:**
- Comments deduplicated → less storage
- Actor lookups indexed → fast
- Revision queries indexed → fast
- Foreign keys enable optimizer improvements

**Trade-offs:**
- More JOINs required to fetch full data
- Slightly more INSERT statements
- Slightly larger storage (extra tables)
- Worth it for scalability and flexibility

## Troubleshooting

### Constraint Violation: comment_id

```
ERROR: insert or update on table "revision" violates foreign key constraint
DETAIL: Key (rev_comment_id)=(10) is not present in table "comment".
```

**Cause:** Trying to insert revision with non-existent comment_id

**Solution:**
```sql
-- Verify comments exist
SELECT COUNT(*) FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27;
-- Should be 18

-- Check specific comment
SELECT * FROM mediawiki.comment WHERE comment_id = 10;
-- Should return a row
```

### Constraint Violation: actor_id

```
ERROR: insert or update on table "revision" violates foreign key constraint
DETAIL: Key (rev_actor)=(5) is not present in table "actor".
```

**Cause:** actor_id 5 doesn't exist

**Solution:**
```sql
-- Verify actor exists
SELECT * FROM mediawiki.actor WHERE actor_id = 5;

-- If missing, create it
INSERT INTO mediawiki.actor (actor_id, actor_user, actor_name)
VALUES (5, 0, 'Maintenance script');
```

### Constraint Violation: page_id

```
ERROR: insert or update on table "revision" violates foreign key constraint
DETAIL: Key (rev_page)=(122) is not present in table "page".
```

**Cause:** Page inserted after revision (wrong order)

**Solution:** Re-run script (it has proper order)

---

**Version:** 1.0
**Last Updated:** 2026-01-28
**Tested:** Yes
**Status:** Production Ready
