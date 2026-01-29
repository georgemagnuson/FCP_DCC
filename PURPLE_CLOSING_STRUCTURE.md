# Purple (Closing) Section - MediaWiki SQL Script Documentation

## Overview
Complete SQL script for creating 20 Purple (Closing) section pages in MediaWiki database. This represents the final closure and maintenance phase of the FCP (Food Compliance Protocol).

**File Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/purple_closing_section.sql`

## Page Allocation Summary

| Component | Page IDs | Count | Description |
|-----------|----------|-------|-------------|
| Content Pages | 142-143 | 2 | Know/Do/Show educational pages |
| Form Templates | 144-152 | 9 | MediaWiki template namespace (10) |
| Form Pages | 153-161 | 9 | Form namespace (0) |
| **Total** | **142-161** | **20** | Complete section |

## Text and Revision IDs

| Type | IDs | Count | Notes |
|------|-----|-------|-------|
| Text IDs | 245-264 | 20 | One-to-one mapping with page IDs |
| Revision IDs | 1020-1039 | 20 | Sequential revisions |
| Content IDs | 245-264 | 20 | Matches text IDs |

## Content Pages (2 pages, IDs 142-143)

### Page 142: FCP:Closing:Cleaning_up
- **Page ID:** 142
- **Namespace:** 0 (Main)
- **Text ID:** 245
- **Revision ID:** 1020
- **Content Size:** 2247 bytes
- **Title:** FCP:Closing:Cleaning_up

**Know Section (Key Principles):**
- Importance of daily end-of-day cleaning and sanitising
- Difference between cleaning and sanitising
- Surface cleaning requirements
- Waste management protocols
- Laundry handling for food safety
- Cleaning schedules and record-keeping

**Do Section (Actions):**
- Daily stock disposal procedures
- Waste segregation methods
- Cleaning equipment protocols
- Sanitiser application and contact times
- Laundry procedures with hot water
- Maintenance of cleaning schedules and records
- Staff training requirements

**Show Section (Evidence):**
- Daily cleaning logs
- Stock disposal records
- Waste management documentation
- Cleaning product inventory records
- Staff training evidence

---

### Page 143: FCP:Closing:Equipment_facilities
- **Page ID:** 143
- **Namespace:** 0 (Main)
- **Text ID:** 246
- **Revision ID:** 1021
- **Content Size:** 2348 bytes
- **Title:** FCP:Closing:Equipment_facilities

**Know Section (Key Principles):**
- Importance of regular equipment maintenance
- Premises inspection protocols
- Water system requirements
- Equipment calibration necessity
- Maintenance chemical storage safety
- Documentation requirements
- Preventive vs reactive maintenance

**Do Section (Actions):**
- Daily premises checks (pests, structure, cleanliness, ventilation)
- Equipment maintenance scheduling
- Temperature monitoring equipment calibration
- Water system inspection and maintenance
- Maintenance chemical proper storage
- Maintenance logging procedures
- Professional maintenance scheduling
- Access to equipment manuals

**Show Section (Evidence):**
- Daily premises inspection records
- Equipment maintenance logs
- Calibration records with dates
- Water system maintenance documentation
- Chemical inventory and storage records
- Staff training evidence

---

## Form Pairs (9 forms = 18 pages, IDs 144-161)

Each form consists of:
- **Template Page:** Namespace 10 (Template namespace)
- **Form Page:** Namespace 0 (Main namespace)

### Form 1: End-of-Day Stock Control

**Pages:**
- Template: Page 144 (Text 247, Rev 1022) - 450 bytes
- Form: Page 153 (Text 248, Rev 1023) - 900 bytes

**Purpose:** Track daily inventory movements and stock disposal

**Template Fields:**
- Date
- Item Name
- Opening Stock (quantity)
- Stock Used/Sold (quantity)
- Waste Disposed (quantity/weight)
- Closing Stock (quantity)
- Expiry Status
- Staff member name

**Form Fields:**
- Date picker
- Item name (text input)
- Quantity fields (numeric)
- Waste quantity (text)
- Expiry status dropdown (Within date, Expired, Damaged, Unsuitable)
- Staff member (text)

**Categories:** Forms, Purple:Closing, Stock_Control

---

### Form 2: Daily Cleaning & Sanitising Log

**Pages:**
- Template: Page 145 (Text 249, Rev 1024) - 500 bytes
- Form: Page 154 (Text 250, Rev 1025) - 1050 bytes

**Purpose:** Document all cleaning and sanitising activities

**Template Fields:**
- Date/Time
- Area/Equipment Cleaned
- Cleaning Method
- Sanitising Method
- Duration (minutes)
- Pass/Fail
- Corrective Actions
- Staff member

**Form Fields:**
- Date/time picker
- Area/equipment (textarea)
- Cleaning method dropdown (Water/detergent, Degreaser, Acid cleaner, Other)
- Sanitising method dropdown (Chemical, Hot water >82°C, Steam, UV, N/A)
- Duration (numeric)
- Result dropdown (Pass, Fail, Partial with correction)
- Corrective actions (textarea)
- Staff member (text)

**Categories:** Forms, Purple:Closing, Cleaning_Records

---

### Form 3: Waste Management Record

**Pages:**
- Template: Page 146 (Text 251, Rev 1026) - 450 bytes
- Form: Page 155 (Text 252, Rev 1027) - 1000 bytes

**Purpose:** Track waste generation, disposal methods, and routes

**Template Fields:**
- Date
- Waste Type
- Quantity
- Disposal Method
- Disposal Route
- Date Disposed
- Staff Verified

**Form Fields:**
- Date (date picker)
- Waste type dropdown (General, Food, Recyclable, Hazardous, Cleaning containers, Equipment, Other)
- Quantity (text with units)
- Disposal method dropdown (Landfill, Recycling, Composting, Incineration, Licensed contractor, Other)
- Disposal route/contractor (text)
- Date actually disposed (date picker)
- Staff verification (text)

**Categories:** Forms, Purple:Closing, Waste_Management

---

### Form 4: Equipment Maintenance Log

**Pages:**
- Template: Page 147 (Text 253, Rev 1028) - 480 bytes
- Form: Page 156 (Text 254, Rev 1029) - 1100 bytes

**Purpose:** Document all equipment maintenance activities

**Template Fields:**
- Date
- Equipment Name
- Model/Serial Number
- Maintenance Type
- Issues Identified
- Corrective Actions
- Next Maintenance Due
- Technician

**Form Fields:**
- Date (date picker)
- Equipment name (text)
- Model/serial (text)
- Maintenance type dropdown (Preventive, Corrective, Calibration, Cleaning, Professional service, Other)
- Issues identified (textarea)
- Corrective actions (textarea)
- Next maintenance due (date picker)
- Technician/staff (text)

**Categories:** Forms, Purple:Closing, Equipment_Maintenance

---

### Form 5: Premises Condition Inspection

**Pages:**
- Template: Page 148 (Text 255, Rev 1030) - 520 bytes
- Form: Page 157 (Text 256, Rev 1031) - 1350 bytes

**Purpose:** Daily inspection of premises for safety and hygiene issues

**Template Fields:**
- Date
- Pest Signs
- Structural Issues
- Cleanliness Assessment
- Ventilation Status
- Water Systems Status
- Corrective Actions
- Pass/Fail
- Inspector

**Form Fields:**
- Date (date picker)
- Pest signs dropdown (None, Possible entry points, Evidence of activity)
- Structural issues (textarea)
- Cleanliness (dropdown: Good, Fair, Poor)
- Ventilation status (dropdown: Operational, Partially operational, Non-operational)
- Water systems (dropdown: Good, Minor issues, Significant issues)
- Corrective actions (textarea)
- Assessment result (dropdown: Pass, Pass with actions, Fail)
- Inspector name (text)

**Categories:** Forms, Purple:Closing, Premises_Inspection

---

### Form 6: Calibration Record

**Pages:**
- Template: Page 149 (Text 257, Rev 1032) - 470 bytes
- Form: Page 158 (Text 258, Rev 1033) - 1200 bytes

**Purpose:** Document calibration of measurement and monitoring equipment

**Template Fields:**
- Date
- Equipment Type
- Equipment ID
- Calibration Method
- Result (In/Out of Tolerance)
- Reference Standard Used
- Next Calibration Due
- Technician

**Form Fields:**
- Date (date picker)
- Equipment type dropdown (Probe thermometer, Digital thermometer, Infrared thermometer, Data logger, Scales/Balances, pH meter, Other)
- Equipment ID/serial (text)
- Calibration method dropdown (Two-point, Single-point, Professional lab, Manufacturer check, Other)
- Result dropdown (In tolerance, Out of tolerance - adjusted, Out of tolerance - removed)
- Reference standard (text)
- Next calibration due (date picker)
- Technician (text)

**Categories:** Forms, Purple:Closing, Calibration_Records

---

### Form 7: Water System Maintenance

**Pages:**
- Template: Page 150 (Text 259, Rev 1034) - 450 bytes
- Form: Page 159 (Text 260, Rev 1035) - 1050 bytes

**Purpose:** Track maintenance of water supply systems

**Template Fields:**
- Date
- System Component
- Maintenance Type
- Findings
- Action Taken
- Water Quality OK?
- Next Maintenance Due
- Technician

**Form Fields:**
- Date (date picker)
- System component dropdown (Tank, Inlet pipes, Distribution pipes, Filtration, Taps/dispensers, Hoses, Connections, Other)
- Maintenance type dropdown (Inspection, Cleaning, Filter replacement, Leak repair, Testing, Flushing/disinfection, Professional service)
- Findings (textarea)
- Action taken (textarea)
- Water quality dropdown (Safe, Needs further action, Requires boiling, Requires disinfection)
- Next maintenance due (date picker)
- Technician (text)

**Categories:** Forms, Purple:Closing, Water_Systems

---

### Form 8: Roof Water Supply Checklist

**Pages:**
- Template: Page 151 (Text 261, Rev 1036) - 480 bytes
- Form: Page 160 (Text 262, Rev 1037) - 1200 bytes

**Purpose:** Specific checklist for roof water supply systems

**Template Fields:**
- Date
- Roof Condition
- Guttering Condition
- Debris in Tank
- Water Discoloration
- Microbial Testing Done
- Treatment Applied
- Safe to Use?
- Inspector

**Form Fields:**
- Date (date picker)
- Roof condition dropdown (Good, Fair, Poor, Has netting, No netting)
- Guttering condition dropdown (Clean, Some debris - cleaned, Blocked, Damaged)
- Debris in tank dropdown (None, Minor, Significant)
- Water clarity dropdown (Clear, Slight discoloration, Significant discoloration)
- Microbial testing (dropdown: Yes - acceptable, Yes - concerning, Not due, Scheduled)
- Treatment applied (textarea)
- Water safe to use (dropdown: Yes, No, Yes - after treatment)
- Inspector name (text)

**Categories:** Forms, Purple:Closing, Water_Supply

---

### Form 9: Maintenance Chemical Safety

**Pages:**
- Template: Page 152 (Text 263, Rev 1038) - 480 bytes
- Form: Page 161 (Text 264, Rev 1039) - 1150 bytes

**Purpose:** Track maintenance chemical inventory and safety compliance

**Template Fields:**
- Date
- Chemical Name
- Storage Location
- Quantity in Stock
- Expiry Date
- SDS Available?
- Proper Labeling?
- Staff Trained?
- Pass/Fail

**Form Fields:**
- Date (date picker)
- Chemical name (text)
- Storage location dropdown (Locked cabinet, Storage room, Outdoor shed, Other)
- Quantity (text)
- Expiry/shelf-life date (date picker)
- SDS available (dropdown: Yes - on site, Yes - electronic, No - request)
- Labeling (dropdown: Yes - clear, Partial, No - relabel)
- Staff trained (dropdown: Yes - all, Partial, No)
- Assessment (dropdown: Pass, Fail)

**Categories:** Forms, Purple:Closing, Chemical_Safety

---

## SQL Structure Details

### Text Entries (IDs 245-264)
Each text entry contains:
- `old_id`: Unique identifier (245-264)
- `old_text`: Wikitext content (varies by page)
- `old_flags`: Set to 'utf-8'

### Content Entries (IDs 245-264)
Each content entry contains:
- `content_id`: Matches text ID
- `content_size`: Byte length of content (calculated)
- `content_sha1`: Empty string (application-level SHA1)
- `content_model`: 1 (wikitext)
- `content_address`: tt:{old_id} format

### Revision Entries (IDs 1020-1039)
Each revision contains:
- `rev_id`: 1020-1039
- `rev_page`: Corresponding page ID
- `rev_comment_id`: 1 (default)
- `rev_actor`: 1 (system user)
- `rev_timestamp`: NOW()
- `rev_minor_edit`: 0 (false)
- `rev_deleted`: 0 (not deleted)
- `rev_len`: Byte length of content
- `rev_parent_id`: NULL (initial revision)
- `rev_sha1`: Empty string

### Slots Entries (IDs 1020-1039)
Each slot contains:
- `slot_revision_id`: Corresponding revision ID
- `slot_role_id`: 1 (main role)
- `slot_content_id`: Corresponding content ID
- `slot_origin`: Same as revision ID

### Page Entries (IDs 142-161)
Each page contains:
- `page_id`: 142-161
- `page_namespace`: 0 (main) or 10 (template)
- `page_title`: Proper page title
- `page_is_redirect`: 0 (not a redirect)
- `page_is_new`: 1 (new page)
- `page_random`: RANDOM()
- `page_touched`: NOW()
- `page_latest`: Corresponding revision ID
- `page_len`: Byte length of content

## Byte Length Calculations

### Content Pages
| Page | ID | Text ID | Size (bytes) |
|------|-----|----------|-------------|
| Cleaning_up | 142 | 245 | 2247 |
| Equipment_facilities | 143 | 246 | 2348 |

### Form Templates
| Form | Template ID | Text ID | Size (bytes) |
|------|----------|---------|-------------|
| End-of-Day Stock Control | 144 | 247 | 450 |
| Daily Cleaning & Sanitising | 145 | 249 | 500 |
| Waste Management Record | 146 | 251 | 450 |
| Equipment Maintenance Log | 147 | 253 | 480 |
| Premises Condition Inspection | 148 | 255 | 520 |
| Calibration Record | 149 | 257 | 470 |
| Water System Maintenance | 150 | 259 | 450 |
| Roof Water Supply Checklist | 151 | 261 | 480 |
| Maintenance Chemical Safety | 152 | 263 | 480 |

### Form Pages
| Form | Form ID | Text ID | Size (bytes) |
|------|---------|---------|-------------|
| End-of-Day Stock Control | 153 | 248 | 900 |
| Daily Cleaning & Sanitising | 154 | 250 | 1050 |
| Waste Management Record | 155 | 252 | 1000 |
| Equipment Maintenance Log | 156 | 254 | 1100 |
| Premises Condition Inspection | 157 | 256 | 1350 |
| Calibration Record | 158 | 258 | 1200 |
| Water System Maintenance | 159 | 260 | 1050 |
| Roof Water Supply Checklist | 160 | 262 | 1200 |
| Maintenance Chemical Safety | 161 | 264 | 1150 |

**Total Script Size:** ~23,000 bytes (wikitext + SQL)

## Category Tags

All pages include appropriate categories:

### Content Pages
- `[[Category:Purple:Closing]]`

### Form Pages
- `[[Category:Forms]]`
- `[[Category:Purple:Closing]]`
- Form-specific category (e.g., `[[Category:Stock_Control]]`)

## Transaction Structure

The script is wrapped in a PostgreSQL transaction:

```sql
BEGIN;
-- All INSERT statements
COMMIT;
```

This ensures atomicity - all 20 pages are created together or none are created.

## Verification Queries

The script includes verification queries at the end:

```sql
-- Count total pages created
SELECT COUNT(*) as total_pages FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161;

-- List all created pages
SELECT page_id, page_namespace, page_title FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161 ORDER BY page_id;

-- Count text entries
SELECT COUNT(*) as total_text_entries FROM mediawiki.text WHERE old_id BETWEEN 245 AND 264;

-- Count revisions
SELECT COUNT(*) as total_revisions FROM mediawiki.revision WHERE rev_id BETWEEN 1020 AND 1039;
```

## Execution Instructions

1. **Backup Database:**
   ```bash
   pg_dump mediawiki > backup_before_purple.sql
   ```

2. **Execute Script:**
   ```bash
   psql mediawiki < purple_closing_section.sql
   ```

3. **Verify:**
   - Check all 20 pages are created
   - Verify page content displays correctly
   - Test form functionality
   - Confirm category assignments

## Related Files

- Previous sections: Dark Blue (Pages 1-141), Orange (continuation)
- Main documentation: FCP_DCC project
- Database schema: MediaWiki standard schema
- Configuration: CLAUDE.md project instructions

---

**Last Updated:** 2026-01-29
**Status:** Complete and ready for deployment
**Testing:** Verification queries included
