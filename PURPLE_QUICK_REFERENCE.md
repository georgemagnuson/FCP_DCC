# Purple (Closing) Section - Quick Reference Guide

## Complete Purple Section Summary

**Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/purple_closing_section.sql`

**Total Pages:** 20
- 2 Content Pages (IDs 142-143)
- 18 Form Pages (9 templates + 9 forms, IDs 144-161)

**Text/Content IDs:** 245-264 (sequential)
**Revision IDs:** 1020-1039 (sequential)

---

## Page ID Allocations

### Content Pages (2)
| Page ID | Title | Text ID | Size | Type |
|---------|-------|---------|------|------|
| 142 | FCP:Closing:Cleaning_up | 245 | 2247 B | Know/Do/Show |
| 143 | FCP:Closing:Equipment_facilities | 246 | 2348 B | Know/Do/Show |

### Form Templates (9)
| Page ID | Template Name | Text ID | Size | Form Purpose |
|---------|---------------|---------|------|--------------|
| 144 | Template:EndOfDayStockControl | 247 | 450 B | Stock inventory tracking |
| 145 | Template:DailyCleaningSanitising | 249 | 500 B | Cleaning documentation |
| 146 | Template:WasteManagementRecord | 251 | 450 B | Waste tracking |
| 147 | Template:EquipmentMaintenanceLog | 253 | 480 B | Equipment maintenance |
| 148 | Template:PremisesConditionInspection | 255 | 520 B | Premises safety check |
| 149 | Template:CalibrationRecord | 257 | 470 B | Equipment calibration |
| 150 | Template:WaterSystemMaintenance | 259 | 450 B | Water system upkeep |
| 151 | Template:RoofWaterSupplyChecklist | 261 | 480 B | Roof water supply check |
| 152 | Template:MaintenanceChemicalSafety | 263 | 480 B | Chemical inventory/safety |

### Form Pages (9)
| Page ID | Form Name | Text ID | Size | Associated Template |
|---------|-----------|---------|------|---------------------|
| 153 | Form:EndOfDayStockControl | 248 | 900 B | Template:EndOfDayStockControl |
| 154 | Form:DailyCleaningSanitising | 250 | 1050 B | Template:DailyCleaningSanitising |
| 155 | Form:WasteManagementRecord | 252 | 1000 B | Template:WasteManagementRecord |
| 156 | Form:EquipmentMaintenanceLog | 254 | 1100 B | Template:EquipmentMaintenanceLog |
| 157 | Form:PremisesConditionInspection | 256 | 1350 B | Template:PremisesConditionInspection |
| 158 | Form:CalibrationRecord | 258 | 1200 B | Template:CalibrationRecord |
| 159 | Form:WaterSystemMaintenance | 260 | 1050 B | Template:WaterSystemMaintenance |
| 160 | Form:RoofWaterSupplyChecklist | 262 | 1200 B | Template:RoofWaterSupplyChecklist |
| 161 | Form:MaintenanceChemicalSafety | 264 | 1150 B | Template:MaintenanceChemicalSafety |

---

## Content Pages Detail

### Page 142: Cleaning_up
**Coverage:**
- Stock disposal protocols
- Cleaning vs sanitising distinction
- Surface cleaning requirements
- Waste management procedures
- Laundry handling
- Record-keeping compliance

**Key Records Needed:**
- Daily cleaning logs
- Stock disposal records
- Waste management documentation
- Cleaning product inventory
- Staff training records

### Page 143: Equipment_facilities
**Coverage:**
- Equipment maintenance procedures
- Premises inspection protocols
- Water system management
- Equipment calibration procedures
- Maintenance chemical storage
- Documentation requirements

**Key Records Needed:**
- Premises inspection logs
- Equipment maintenance schedules
- Calibration certificates
- Water system maintenance records
- Chemical inventory and safety data

---

## Form Details

### Form 1: End-of-Day Stock Control
**Key Fields:**
- Date tracking
- Item inventory (opening/closing)
- Waste quantity
- Expiry status (4 options)
- Staff identification

### Form 2: Daily Cleaning & Sanitising Log
**Key Fields:**
- Date/time stamping
- Area/equipment identification
- Cleaning method selection (4 options)
- Sanitising method selection (5 options)
- Duration tracking
- Pass/Fail assessment with corrective actions

### Form 3: Waste Management Record
**Key Fields:**
- Waste type classification (7 types)
- Quantity tracking
- Disposal method selection (6 options)
- Disposal route/contractor
- Date verification
- Staff accountability

### Form 4: Equipment Maintenance Log
**Key Fields:**
- Equipment identification (name, model, serial)
- Maintenance type (6 options: preventive, corrective, calibration, etc.)
- Issues and corrective actions (textarea fields)
- Next maintenance scheduling
- Technician identification

### Form 5: Premises Condition Inspection
**Key Fields:**
- Pest monitoring (3 levels)
- Structural assessment
- Cleanliness grading (3 levels)
- Ventilation status (3 levels)
- Water system condition (3 levels)
- Overall pass/fail assessment

### Form 6: Calibration Record
**Key Fields:**
- Equipment type (7 types: thermometers, scales, pH meters, etc.)
- Equipment identification
- Calibration method (5 options)
- In/out of tolerance assessment
- Reference standard documentation
- Next calibration scheduling

### Form 7: Water System Maintenance
**Key Fields:**
- System component selection (8 types: tanks, pipes, filters, taps, etc.)
- Maintenance type (7 types)
- Findings and actions (textarea)
- Water quality assessment (4 levels)
- Next maintenance scheduling

### Form 8: Roof Water Supply Checklist
**Key Fields:**
- Roof condition (5 assessment levels)
- Guttering condition (4 levels)
- Tank debris assessment (3 levels)
- Water clarity monitoring (3 levels)
- Microbial testing status (4 options)
- Treatment documentation
- Safe to use determination (3 options)

### Form 9: Maintenance Chemical Safety
**Key Fields:**
- Chemical identification and quantity
- Storage location verification (4 options)
- Expiry date tracking
- Safety Data Sheet (SDS) availability (3 options)
- Container labeling compliance (3 levels)
- Staff training status (3 levels)
- Overall pass/fail compliance

---

## Category Structure

All 20 pages include the category: **`[[Category:Purple:Closing]]`**

### Additional Categories by Type

**Content Pages:**
- Purple:Closing (automatic)

**Form Pages:**
- Forms (all 9)
- Purple:Closing (all 9)
- Specific (e.g., Stock_Control, Cleaning_Records, etc.)

---

## Database Structure

### Text Table (old_id 245-264)
- Stores wikitext content
- UTF-8 encoded
- Sizes range from 450-2348 bytes

### Content Table (content_id 245-264)
- Maps to text entries
- Wikitext model (1)
- Content addressed as tt:{old_id}

### Revision Table (rev_id 1020-1039)
- Initial revisions for all pages
- Linked to pages via rev_page
- Timestamp: NOW() (script execution time)
- No parent revisions (initial creation)

### Slots Table (slot_revision_id 1020-1039)
- Maps revisions to content
- Main role (role_id 1)
- Origin equals revision ID (no previous slots)

### Page Table (page_id 142-161)
- Namespace 0 (main) for content and forms
- Namespace 10 (template) for templates
- Page_latest points to most recent revision
- Page_len contains content size

---

## Execution Commands

### Backup Before Execution
```bash
pg_dump mediawiki > backup_purple_section.sql
```

### Execute Script
```bash
psql mediawiki < purple_closing_section.sql
```

### Verify Creation
```bash
psql mediawiki -c "SELECT page_id, page_namespace, page_title FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161 ORDER BY page_id;"
```

### Count Verification
```bash
psql mediawiki -c "SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 142 AND 161;"
# Expected: 20
```

---

## Integration Notes

### With Existing Sections
- **Purple section follows:** Orange (Serving/Selling) section
- **Page sequence:** Continuous from 142 onwards
- **Revision sequence:** Continuous from 1020 onwards
- **Text ID sequence:** Continuous from 245 onwards

### MediaWiki Namespaces Used
- **Namespace 0 (Main):** Content pages and form pages
- **Namespace 10 (Template):** Form templates

### Related Documentation
- Dark Blue (Setting Up): Pages 1-141
- Orange (Serving/Selling): Preceding pages
- Purple (Closing): Pages 142-161

---

## Troubleshooting

### If script fails to execute:
1. Verify PostgreSQL connection
2. Check mediawiki database exists
3. Confirm user has INSERT privileges
4. Review error message in transaction

### If pages don't display:
1. Verify all 20 pages created (SELECT COUNT)
2. Check page titles for special characters
3. Confirm wikitext syntax validity
4. Test individual page access via MediaWiki UI

### If forms don't work:
1. Verify templates created (namespace 10)
2. Check form pages reference correct templates
3. Test template inclusion: `{{Template:FormName}}`
4. Verify Semantic Forms extension enabled in MediaWiki

---

## File Information

**Primary Script:**
- Location: `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/purple_closing_section.sql`
- Size: ~926 lines
- Format: PostgreSQL transaction
- Includes: Verification queries

**Documentation:**
- Quick Reference: `PURPLE_QUICK_REFERENCE.md` (this file)
- Detailed Structure: `PURPLE_CLOSING_STRUCTURE.md`
- Project Guide: `CLAUDE.md`

---

**Status:** Ready for immediate deployment
**Last Generated:** 2026-01-29
**Validation:** All IDs sequential, byte counts calculated, wikitext formatted
