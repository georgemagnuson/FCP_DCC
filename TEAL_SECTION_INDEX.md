# Teal (Specialist) Section - Complete Documentation Index

**Generated:** 2026-01-29
**Project:** FCP_DCC (Food Compliance Protocol - Digital Content Conversion)
**Section:** Teal (Specialist) - Pages 209-226
**Total Pages:** 18
**Total Data:** ~29.3 KB

---

## Quick Start

### Execute the SQL Script
```bash
cd /Users/georgemagnuson/Documents/GitHub/FCP_DCC
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 < teal_specialist_section.sql
```

### Verify Deployment
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT page_id, page_namespace, page_title FROM mediawiki.page WHERE page_id BETWEEN 209 AND 226 ORDER BY page_id;"
# Expected result: 18 rows
```

---

## Content Pages (Pages 209-214)

### Page 209: FCP:Specialist:Making_sushi
**Namespace:** 0 (main)
**Text ID:** 323
**Size:** 2,245 bytes
**Revision ID:** 1098

**Topics Covered:**
- Acidified vs. non-acidified rice sushi requirements
- pH control critical for safety (3.0-4.3 range)
- Vinegar solution preparation (4% acetic acid minimum)
- Cooling procedures for non-acidified sushi
- Storage temperature and display time limits
- pH measurement with calibrated equipment
- Record-keeping requirements

**Key Safety Points:**
- Acidified sushi: room temperature storage (max 24 hours)
- Non-acidified sushi: cool to <5°C within 90 minutes, display max 2 hours
- pH meter calibration critical

---

### Page 210: FCP:Specialist:Making_chinese_roast_duck
**Namespace:** 0 (main)
**Text ID:** 324
**Size:** 2,132 bytes
**Revision ID:** 1099

**Topics Covered:**
- Boiling water dip with vinegar (critical surface decontamination)
- Drying procedure critical for food safety
- Maximum drying time: 6 hours above 5°C
- Internal temperature monitoring (must not exceed 25°C)
- Skin integrity maintenance
- Temperature verification at start and mid-drying

**Key Safety Points:**
- Water temperature ≥100°C with vinegar
- Internal temp <25°C throughout drying
- Proper cooling before storage

---

### Page 211: FCP:Specialist:Making_doner_kebabs
**Namespace:** 0 (main)
**Text ID:** 325
**Size:** 2,024 bytes
**Revision ID:** 1100

**Topics Covered:**
- Fresh meat requirement (no pre-cooked)
- Vertical grill cooking procedure
- Heating element positioning
- Temperature verification (minimum 75°C)
- Safe meat shaving and collection
- Service temperature maintenance (≥65°C)

**Key Safety Points:**
- Internal temperature must reach 75°C minimum
- Prevent cross-contamination during shaving
- Maintain temperature control during service

---

### Page 212: FCP:Specialist:Cooking_sous_vide
**Namespace:** 0 (main)
**Text ID:** 326
**Size:** 2,863 bytes
**Revision ID:** 1101

**Topics Covered:**
- **CRITICAL HIGH-RISK PROCEDURE** - errors can cause illness/death
- Only for whole muscle cuts (red meat minimum 55°C, poultry 60°C)
- Vacuum sealing integrity critical
- Water bath temperature control (±1°C)
- Monthly calibration requirement
- Approved time/temperature tables essential
- Complete documentation requirements

**Key Safety Points:**
- ONLY whole muscle beef, lamb, venison, poultry breast/thigh
- Vacuum seal must be complete - no air pockets
- Temperature deviations are NOT acceptable
- Detailed temperature records mandatory

---

### Page 213: FCP:Specialist:Preparing_red_meat_raw
**Namespace:** 0 (main)
**Text ID:** 327
**Size:** 2,598 bytes
**Revision ID:** 1102

**Topics Covered:**
- Only beef, lamb, venison (NO pork/poultry/other meats)
- Three approved decontamination methods:
  * Searing (180-200°C, all surfaces)
  * Blanching (boiling water, 1-2 minutes)
  * Sanitizing solution (approved chemical, per instructions)
- 48-hour usage limit after decontamination
- Cold chain maintenance
- Cross-contamination prevention

**Key Safety Points:**
- Meat type restrictions are strict
- Decontamination must cover all exterior surfaces
- Must use within 48 hours
- Separate from other raw meat preparations

---

### Page 214: FCP:Specialist:Making_biltong
**Namespace:** 0 (main)
**Text ID:** 328
**Size:** 2,947 bytes
**Revision ID:** 1103

**Topics Covered:**
- Red meat from registered NZ processor ONLY
- Water activity <0.85 mandatory for safety
- Marinade requirements (minimum 30g salt + 30g vinegar per kg)
- Marinating at ≤5°C for 10+ hours
- Dedicated drying space requirement
- Environmental controls (15-25°C, 45-65% humidity)
- Water activity measurement critical

**Key Safety Points:**
- Supplier registration verification essential
- Water activity measurement required
- Mold growth monitoring during drying
- Batch documentation critical

---

## Form Templates (Pages 215-220, Namespace 10)

### Page 215: Template:Sushi_pH_Record
**Size:** 398 bytes
**Fields:** 8 parameters
- date, rice_type, ph_reading, meter_calibration, cooling_method, storage_temp, display_time, staff

### Page 216: Template:Roast_Duck_Temperature_Log
**Size:** 430 bytes
**Fields:** 9 parameters
- date, start_time, finish_time, start_temp, mid_temp, max_temp, duration, equipment, staff

### Page 217: Template:Doner_Kebab_Cooking_Log
**Size:** 390 bytes
**Fields:** 8 parameters
- date, meat_type, cook_start, cook_finish, internal_temp, min_temp, service_temp, staff

### Page 218: Template:Sous_Vide_Cooking_Log
**Size:** 390 bytes
**Fields:** 9 parameters
- date, food_type, thickness, target_temp, actual_temp, cook_time, seal_check, calibration, staff

### Page 219: Template:Raw_Meat_Decontamination_Log
**Size:** 396 bytes
**Fields:** 8 parameters
- date, meat_type, quantity, method, temperature, duration, staff, used_within_48hrs

### Page 220: Template:Biltong_Production_Record
**Size:** 448 bytes
**Fields:** 11 parameters
- date_started, meat_type, quantity, salt_qty, vinegar_qty, marinade_temp, marinate_hours, drying_temp, drying_days, water_activity, staff

---

## Form Pages (Pages 221-226, Namespace 0)

### Page 221: Form:Sushi_pH_Record
**Size:** 1,056 bytes
**Fields:** 8 inputs
- Acidified/non-acidified rice selection
- pH measurement (0-14 scale)
- Meter calibration verification
- Cooling method selection
- Storage temperature
- Display time tracking
- Staff member

**Categories:** Forms, Teal:Specialist, Sushi_Records

### Page 222: Form:Roast_Duck_Temperature_Log
**Size:** 1,032 bytes
**Fields:** 9 inputs
- Start/finish times
- Temperature monitoring (internal, start/mid-drying)
- Maximum temperature constraints
- Drying duration tracking
- Equipment used

**Categories:** Forms, Teal:Specialist, Roast_Duck_Records

### Page 223: Form:Doner_Kebab_Cooking_Log
**Size:** 1,023 bytes
**Fields:** 8 inputs
- Meat type selection (lamb, beef, chicken)
- Cooking time tracking
- Temperature verification
- Service temperature maintenance

**Categories:** Forms, Teal:Specialist, Doner_Kebab_Records

### Page 224: Form:Sous_Vide_Cooking_Log
**Size:** 1,289 bytes
**Fields:** 9 inputs
- Food type restrictions
- Meat thickness measurement
- Target vs. actual temperature
- Cooking time documentation
- Vacuum seal verification
- Equipment calibration date

**Categories:** Forms, Teal:Specialist, Sous_Vide_Records

### Page 225: Form:Raw_Meat_Decontamination_Log
**Size:** 1,134 bytes
**Fields:** 8 inputs
- Meat type (beef, lamb, venison only)
- Quantity tracking
- Decontamination method selection
- Temperature documentation
- Duration tracking
- 48-hour usage verification

**Categories:** Forms, Teal:Specialist, Raw_Meat_Records

### Page 226: Form:Biltong_Production_Record
**Size:** 1,317 bytes
**Fields:** 11 inputs
- Start date and meat type
- Marinade ingredient quantities (salt, vinegar)
- Temperature controls
- Marinating duration (minimum 10 hours)
- Drying conditions and duration
- Water activity measurement
- Staff verification

**Categories:** Forms, Teal:Specialist, Biltong_Records

---

## Database Integration

### mediawiki.text Table (18 entries)
| Text ID | Size | Purpose |
|---------|------|---------|
| 323-328 | 2,024-2,947 B | Content pages (6) |
| 329-334 | 390-448 B | Form templates (6) |
| 335-340 | 1,023-1,317 B | Form pages (6) |

### mediawiki.content Table (18 entries)
All entries reference text IDs 323-340
- content_model: 1 (for all)
- content_address: tt:[text_id]

### mediawiki.revision Table (18 entries)
| Rev ID | Rev Page | Purpose |
|--------|----------|---------|
| 1098-1103 | 209-214 | Content pages |
| 1104-1109 | 215-220 | Form templates |
| 1110-1115 | 221-226 | Form pages |

### mediawiki.page Table (18 entries)
**Content Pages (Namespace 0):** Pages 209-214
**Form Templates (Namespace 10):** Pages 215-220
**Form Pages (Namespace 0):** Pages 221-226

---

## Category Structure

### Primary Category
All pages assigned to: `Teal:Specialist`

### Secondary Categories by Type
- Page 221: `Sushi_Records`
- Page 222: `Roast_Duck_Records`
- Page 223: `Doner_Kebab_Records`
- Page 224: `Sous_Vide_Records`
- Page 225: `Raw_Meat_Records`
- Page 226: `Biltong_Records`

All forms tagged with: `Forms`

---

## Verification Steps

### Step 1: Page Count
```sql
SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 209 AND 226;
-- Expected: 18
```

### Step 2: Text Entries
```sql
SELECT COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 323 AND 340;
-- Expected: 18
```

### Step 3: Revisions
```sql
SELECT COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1098 AND 1115;
-- Expected: 18
```

### Step 4: Content Integrity
```sql
SELECT page_id, page_namespace, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 209 AND 226
ORDER BY page_id;
```

### Step 5: MediaWiki UI Verification
- Access content pages
- Access form pages
- Test form submission
- Verify categories link correctly

---

## Integration with FCP Color System

The Teal section completes the FCP color-coded system:

| Color | Section | Pages | Focus |
|-------|---------|-------|-------|
| Dark Blue | Setting Up | Multiple | Foundation and planning |
| Blue | Starting | Multiple | Hazard analysis and controls |
| Green | Preparing | Multiple | Food preparation safety |
| Magenta | Making + Cooking | Multiple | Cooking procedures |
| Orange | Serving + Selling | 6 | Serving and customer interface |
| Purple | Closing | 4 | End-of-day procedures |
| Red | Troubleshooting | 4 | Incident management |
| **Teal** | **Specialist** | **6** | **Optional high-risk procedures** |

Teal section is optional and only applies if business uses specialized procedures.

---

## Next Steps

1. Verify deployment using verification queries above
2. Test pages in MediaWiki UI
3. Commit changes to git
4. Update project documentation
5. Consider additional specialist procedures if needed

---

## Support

For issues or questions, refer to:
- TEAL_QUICK_REFERENCE.md for fast lookup
- Database logs for deployment issues
- MediaWiki logs for UI issues

**Status:** Production Ready
**Last Updated:** 2026-01-29
