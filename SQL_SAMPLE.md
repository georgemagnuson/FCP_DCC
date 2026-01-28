# FCP_DCC SQL Insert Script - Sample Content

This document shows sample excerpts from the generated SQL script to demonstrate the structure and content being inserted.

## Sample Page 1: Keeping_food_hot (Orange Section)

### Text Content Insert
```sql
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(225, '= Know =

This section covers the key principles for Serving Selling:Keeping food hot.

== Key Points ==
* Understanding the importance of Serving Selling:Keeping food hot
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Keeping food hot
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Keeping food hot procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');
```

### Content Metadata Insert
```sql
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(225, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 225), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 225)::bytea), 
 'wikitext', 'tt:225');
```

### Revision Record Insert
```sql
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1000, 122, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');
```

### Slot Linking Insert
```sql
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1000, 1, 225, 1000);
```

### Page Record Insert
```sql
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(122, 6, 'Keeping_food_hot', 0, 1, 1000, 0);
```

### SMW Properties Insert
```sql
INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(122, 'smw_id', '122');
```

---

## Sample Page 2: Cleaning_up_and_closing (Purple Section)

### Page Record Insert
```sql
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(128, 6, 'Cleaning_up_and_closing', 0, 1, 1006, 0);
```

---

## Sample Page 3: Making_sushi (Teal Section)

### Page Record Insert
```sql
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(134, 6, 'Making_sushi', 0, 1, 1012, 0);
```

---

## Complete SQL Script Structure

The full SQL script follows this pattern for each page:

```sql
-- Start transaction
BEGIN;

-- ORANGE SECTION PAGES (122-127, Text 225-230)
[6 pages × 6 INSERT statements each = 36 INSERTs]

-- PURPLE SECTION PAGES (128-129, Text 231-232)
[2 pages × 6 INSERT statements each = 12 INSERTs]

-- RED SECTION PAGES (130-133, Text 233-236)
[4 pages × 6 INSERT statements each = 24 INSERTs]

-- TEAL SECTION PAGES (134-139, Text 237-242)
[6 pages × 6 INSERT statements each = 36 INSERTs]

-- Total: 18 pages × 6 statements = 108 INSERT statements

-- Commit transaction
COMMIT;

-- Verification queries
SELECT COUNT(*) as page_count FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;
SELECT COUNT(*) as text_count FROM mediawiki.text WHERE old_id >= 225;
```

---

## Page Title Mapping

Each page in the database follows this structure:

| Namespace | Title | Full Name | Page ID | Text ID |
|-----------|-------|-----------|---------|---------|
| 6 (FCP) | Keeping_food_hot | FCP:Serving_Selling:Keeping_food_hot | 122 | 225 |
| 6 (FCP) | Transporting_food | FCP:Serving_Selling:Transporting_food | 123 | 226 |
| 6 (FCP) | Displaying_food | FCP:Serving_Selling:Displaying_food | 124 | 227 |
| 6 (FCP) | Allergens | FCP:Serving_Selling:Allergens | 125 | 228 |
| 6 (FCP) | Labelling | FCP:Serving_Selling:Labelling | 126 | 229 |
| 6 (FCP) | B2B | FCP:Serving_Selling:B2B | 127 | 230 |
| 6 (FCP) | Cleaning_up_and_closing | FCP:Closing:Cleaning_up_and_closing | 128 | 231 |
| 6 (FCP) | Maintaining_equipment | FCP:Closing:Maintaining_equipment | 129 | 232 |
| 6 (FCP) | When_something_goes_wrong | FCP:Troubleshooting:When_something_goes_wrong | 130 | 233 |
| 6 (FCP) | Customer_complaints | FCP:Troubleshooting:Customer_complaints | 131 | 234 |
| 6 (FCP) | Tracing_your_food | FCP:Troubleshooting:Tracing_your_food | 132 | 235 |
| 6 (FCP) | Recalling_your_food | FCP:Troubleshooting:Recalling_your_food | 133 | 236 |
| 6 (FCP) | Making_sushi | FCP:Specialist:Making_sushi | 134 | 237 |
| 6 (FCP) | Chinese_roast_duck | FCP:Specialist:Chinese_roast_duck | 135 | 238 |
| 6 (FCP) | Doner_kebabs | FCP:Specialist:Doner_kebabs | 136 | 239 |
| 6 (FCP) | Sous_vide | FCP:Specialist:Sous_vide | 137 | 240 |
| 6 (FCP) | Preparing_red_meat | FCP:Specialist:Preparing_red_meat | 138 | 241 |
| 6 (FCP) | Making_biltong | FCP:Specialist:Making_biltong | 139 | 242 |

---

## Content Template

Each page follows this MediaWiki format:

```wikitext
= Know =

This section covers the key principles for [TOPIC].

== Key Points ==
* Understanding the importance of [TOPIC]
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for [TOPIC]
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of [TOPIC] procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:[SECTION]|[SECTION]]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:[SECTION]]]
```

---

## Database Statistics

After executing the SQL script:

| Table | Records Added | Starting ID | Ending ID |
|-------|---------------|-----------  |-----------|
| text | 18 | 225 | 242 |
| content | 18 | 225 | 242 |
| revision | 18 | 1000 | 1017 |
| slots | 18 | 500 | 517 |
| page | 18 | 122 | 139 |
| page_props | 18 | 122 | 139 |

**Total records added:** 108 INSERT statements across 6 tables

---

## Verification Queries Included

The script includes these verification queries at the end:

```sql
-- Count inserted pages
SELECT COUNT(*) as page_count FROM mediawiki.page 
WHERE page_namespace = 6 AND page_id >= 122;
-- Expected: 18

-- Count inserted text records
SELECT COUNT(*) as text_count FROM mediawiki.text 
WHERE old_id >= 225;
-- Expected: 18
```

---

**Generated:** 2026-01-28
**Total Pages:** 18
**Total Statements:** 108
**File Size:** ~38 KB
**Execution Time:** < 1 second (typical)

