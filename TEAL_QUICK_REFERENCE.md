# Teal (Specialist) Section - Quick Reference Guide

**Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/teal_specialist_section.sql`

**Total Pages:** 18
- 6 Content Pages (IDs 209-214)
- 6 Form Templates (IDs 215-220, namespace 10)
- 6 Form Pages (IDs 221-226, namespace 0)

**Text/Content IDs:** 323-342 (sequential)
**Revision IDs:** 1098-1117 (sequential)

---

## Page ID Allocations

### Content Pages (6)
| Page ID | Title | Text ID | Size | Type |
|---------|-------|---------|------|------|
| 209 | FCP:Specialist:Making_sushi | 323 | 2245 B | Know/Do/Show |
| 210 | FCP:Specialist:Making_chinese_roast_duck | 324 | 2132 B | Know/Do/Show |
| 211 | FCP:Specialist:Making_doner_kebabs | 325 | 2024 B | Know/Do/Show |
| 212 | FCP:Specialist:Cooking_sous_vide | 326 | 2863 B | Know/Do/Show |
| 213 | FCP:Specialist:Preparing_red_meat_raw | 327 | 2598 B | Know/Do/Show |
| 214 | FCP:Specialist:Making_biltong | 328 | 2947 B | Know/Do/Show |

### Form Templates (6)
| Page ID | Template Name | Text ID | Size | Form Purpose |
|---------|---------------|---------|------|--------------|
| 215 | Template:Sushi_pH_Record | 329 | 398 B | Sushi pH and cooling documentation |
| 216 | Template:Roast_Duck_Temperature_Log | 330 | 430 B | Duck drying temperature monitoring |
| 217 | Template:Doner_Kebab_Cooking_Log | 331 | 390 B | Kebab cooking temperature records |
| 218 | Template:Sous_Vide_Cooking_Log | 332 | 390 B | Sous vide temperature and time logs |
| 219 | Template:Raw_Meat_Decontamination_Log | 333 | 396 B | Raw meat safety procedures |
| 220 | Template:Biltong_Production_Record | 334 | 448 B | Biltong production and water activity |

### Form Pages (6)
| Page ID | Form Name | Text ID | Size | Associated Template |
|---------|-----------|---------|------|---------------------|
| 221 | Form:Sushi_pH_Record | 335 | 1056 B | Template:Sushi_pH_Record |
| 222 | Form:Roast_Duck_Temperature_Log | 336 | 1032 B | Template:Roast_Duck_Temperature_Log |
| 223 | Form:Doner_Kebab_Cooking_Log | 337 | 1023 B | Template:Doner_Kebab_Cooking_Log |
| 224 | Form:Sous_Vide_Cooking_Log | 338 | 1289 B | Template:Sous_Vide_Cooking_Log |
| 225 | Form:Raw_Meat_Decontamination_Log | 339 | 1134 B | Template:Raw_Meat_Decontamination_Log |
| 226 | Form:Biltong_Production_Record | 340 | 1317 B | Template:Biltong_Production_Record |

---

## Execution Commands

### Deploy the SQL Script
```bash
cd /Users/georgemagnuson/Documents/GitHub/FCP_DCC
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 < teal_specialist_section.sql
```

### Verify Deployment (count pages)
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) as page_count FROM mediawiki.page WHERE page_id BETWEEN 209 AND 226;"
# Expected result: 18
```

### Verify All Pages Created (list details)
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT page_id, page_namespace, page_title, page_len FROM mediawiki.page WHERE page_id BETWEEN 209 AND 226 ORDER BY page_id;"
```

---

## Content Pages Overview

### Page 209: Making Sushi
- Acidified vs. non-acidified rice requirements
- pH control critical (3.0-4.3 for safety)
- Cooling procedures for non-acidified sushi
- Storage and display time limits

### Page 210: Making Chinese Roast Duck
- Boiling water dip with vinegar (critical safety step)
- Drying procedure (max 6 hours, internal temp <25°C)
- Temperature monitoring and documentation

### Page 211: Making Doner Kebabs
- Fresh meat requirement
- Vertical grill cooking with temperature control
- Safe meat shaving and collection procedures

### Page 212: Cooking Using Sous Vide
- **CRITICAL:** High-risk procedure - errors can cause illness/death
- Only for whole muscle meat/poultry cuts
- Water bath calibration and temperature control
- Vacuum seal integrity verification

### Page 213: Preparing Red Meat for Raw/Lightly-Cooked
- Beef, lamb, venison only (NOT pork/chicken)
- Three approved decontamination methods:
  - Searing (180-200°C)
  - Blanching (boiling water)
  - Sanitizing solution
- Must use within 48 hours

### Page 214: Making Biltong
- Red meat from registered NZ processor only
- Water activity <0.85 required for safety
- Marinade: minimum 30g salt + 30g vinegar per kg
- Marinate at ≤5°C for 10+ hours
- Dedicated drying space required

---

## Form Field Reference

### Form 1: Sushi_pH_Record (8 fields)
- Date, Rice Type, pH Reading, Meter Calibration, Cooling Method, Storage Temp, Display Time, Staff

### Form 2: Roast_Duck_Temperature_Log (9 fields)
- Date, Start/Finish Time, Start Temp, Mid-Drying Temp, Max Temp Allowed, Drying Duration, Equipment, Staff

### Form 3: Doner_Kebab_Cooking_Log (8 fields)
- Date, Meat Type, Cook Start/Finish Time, Internal Temp, Min Temp Required, Service Temp, Staff

### Form 4: Sous_Vide_Cooking_Log (9 fields)
- Date, Food Type, Thickness, Target Temp, Actual Temp, Cook Time, Seal Check, Calibration, Staff

### Form 5: Raw_Meat_Decontamination_Log (8 fields)
- Date, Meat Type, Quantity, Method, Temperature, Duration, Staff, Used Within 48hrs

### Form 6: Biltong_Production_Record (11 fields)
- Date Started, Meat Type, Quantity, Salt Qty, Vinegar Qty, Marinade Temp, Marinate Hours, Drying Temp, Drying Days, Water Activity, Staff

---

## Database Statistics

| Metric | Value |
|--------|-------|
| Total Pages | 18 |
| Content Pages | 6 |
| Form Templates | 6 |
| Form Pages | 6 |
| Text Entries | 20 (18 pages + 2 extra) |
| Revision Records | 20 |
| Slot Entries | 20 |
| Total Insert Statements | 100 |
| Content Size | ~29.3 KB |

---

## Troubleshooting

### Pages not showing in MediaWiki UI after deployment
1. Clear the MediaWiki cache:
```bash
ssh -i ~/.ssh/id_rsa -n georgemagnuson@192.168.2.10 "cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch"
```

2. Try accessing directly: `http://mediawiki.local/wiki/Form:Sushi_pH_Record`

### Forms not displaying correctly
- Verify PageForms extension is installed and enabled
- Check that Template: pages exist and are properly formatted
- Try accessing the Template page directly

### Database connection issues
- Verify credentials: User `postgres`, Host `192.168.2.30`
- Test connection: `psql -U postgres -d mediawiki -h 192.168.2.30`
- Ensure firewall allows connection to port 5432

---

## Success Criteria - Post Deployment

✅ All 18 pages created with correct IDs (209-226)
✅ 6 content pages display Know/Do/Show sections
✅ 6 form templates render as wikitable structures
✅ 6 form pages accept form submissions
✅ Categories properly assigned (Teal:Specialist)
✅ All verification queries pass
✅ MediaWiki UI accessible and responsive
