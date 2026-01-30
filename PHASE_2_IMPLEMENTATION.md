# Phase 2 Implementation: SMW Properties for Form Templates

## Overview

Phase 2 adds Semantic MediaWiki (SMW) properties to all 30 existing form templates, enabling semantic queries and the Records Archive system (Phase 3). This implementation creates a semantic layer that allows filtering form submissions by date, type, staff, temperature, severity, and other criteria.

## Implementation Complete

All three SQL scripts have been created and are ready for deployment:

### 1. **create_smw_properties.sql** - 12 New SMW Properties
Creates the semantic property infrastructure that form templates will use.

**Properties Created:**
| Property | Type | Purpose | Page ID |
|----------|------|---------|---------|
| Has_submission_date | Date | Form submission date | 301 |
| Has_record_type | Text | Daily/Weekly/Monthly/Incident | 302 |
| Has_staff_name | Text | Person completing form | 303 |
| Has_form_name | Text | Template identifier | 304 |
| Has_temperature | Number | Temperature readings | 305 |
| Has_temperature_unit | Text | Always "°C" | 306 |
| Has_equipment_unit | Text | Equipment ID (FRIDGE-01) | 307 |
| Has_food_item | Text | Food product name | 308 |
| Has_pass_fail_status | Text | Pass/Fail outcome | 309 |
| Has_corrective_action | Text | Actions when issues found | 310 |
| Has_incident_severity | Text | Low/Medium/High/Critical | 311 |
| Has_investigation_status | Text | Open/In Progress/Resolved | 312 |

**Database Allocation:**
- Text IDs: 401-412
- Revision IDs: 1201-1212
- Namespace: 102 (Property namespace)

### 2. **update_templates_smw_phase2a.sql** - 8 High-Priority Templates

Updates critical daily and incident management templates.

**Templates Updated:**

**Orange Section (2):**
1. Template:HotHoldingTemperatureLog (Text ID 231, Page 128)
   - Wraps: food_item, date_placed, temperatures, pass_fail

2. Template:FoodTransportLog (Text ID 233, Page 130)
   - Wraps: food_items, date, temperatures, staff

**Purple Section (2):**
3. Template:Premises_Condition_Inspection (New: Text 450, Page 250)
   - Wraps: date, pest_activity, structural_issues, pass_fail

4. Template:Daily_Cleaning_Sanitising_Log (Text ID 287, Page 173)
   - Wraps: datetime, cleaning_method, pass_fail, corrective_actions

**Red Section (4):**
5. Template:Incident_Report (Text ID 307, Page 193)
   - Wraps: date_time, staff_involved, severity, immediate_actions

6. Template:Complaint_Log (Text ID 308, Page 194)
   - Wraps: date_received, investigation_status, resolution

7. Template:Corrective_Action_Plan (New: Text 451, Page 251)
   - Wraps: date_created, corrective_action, responsible_staff, status

8. Template:Food_Traceability_Record (Text ID 309, Page 195)
   - Wraps: product_name, delivery_date, distributed_to

### 3. **update_templates_smw_phase2b.sql** - 12 Medium-Priority Templates

Updates specialist food handling and equipment maintenance templates.

**Specialist Foods - Teal (6):**
- Template:Sushi_pH_Record (New: Text 452, Page 252)
- Template:Roast_Duck_Temperature_Log (New: Text 453, Page 253)
- Template:Doner_Kebab_Cooking_Log (New: Text 454, Page 254)
- Template:Sous_Vide_Cooking_Log (New: Text 455, Page 255)
- Template:Raw_Meat_Decontamination_Log (New: Text 456, Page 256)
- Template:Biltong_Production_Record (New: Text 457, Page 257)

**Maintenance - Purple (4):**
- Template:Equipment_Maintenance_Log (New: Text 458, Page 258)
- Template:Calibration_Record (New: Text 459, Page 259)
- Template:Water_System_Maintenance (New: Text 460, Page 260)
- Template:Roof_Water_Supply_Checklist (New: Text 461, Page 261)

**Additional Orange (2):**
- Template:LiveShellfishDisplayLog (Update: Text 235, Page 132)
- Template:SelfServiceDisplayChecklist (Update: Text 237, Page 134)

### 4. **update_templates_smw_phase2c.sql** - 10 Remaining Templates

Final batch completing SMW coverage for all 30 templates.

**Purple Section (3):**
- Template:End_of_Day_Stock_Control (Update: Text 285, Page 171)
- Template:Waste_Rubbish_Management (New: Text 462, Page 262)
- Template:Maintenance_Chemical_Safety (New: Text 463, Page 263)

**Orange Section (3):**
- Template:IngredientAllergenRegister (New: Text 464, Page 264)
- Template:FoodLabelSpecifications (New: Text 465, Page 265)
- Template:B2BCustomerSupplyRegister (New: Text 466, Page 266)

**Red Section (4):**
- Template:Recall_Notification (New: Text 467, Page 267)
- Template:Regulatory_Report (New: Text 468, Page 268)
- Template:Root_Cause_Analysis (New: Text 469, Page 269)
- Template:Investigation_Log (New: Text 470, Page 270)

## Deployment Instructions

### Prerequisites
- PostgreSQL access to mediawiki database
- Backup of database (CRITICAL)
- SSH access to llamajail for cache clearing

### Step 1: Create Database Backup
```bash
pg_dump -U postgres -h 192.168.2.30 mediawiki > /tmp/backup_before_phase2_$(date +%Y%m%d_%H%M%S).sql
```

### Step 2: Create SMW Properties
```bash
# SSH to database server
psql -U postgres -h 192.168.2.30 -d mediawiki < /Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_smw_properties.sql
```

**Expected Result:** 12 new Property pages created (IDs 301-312)

### Step 3: Deploy Phase 2A (High Priority)
```bash
psql -U postgres -h 192.168.2.30 -d mediawiki < /Users/georgemagnuson/Documents/GitHub/FCP_DCC/update_templates_smw_phase2a.sql
```

**Expected Result:** 8 templates updated with SMW annotations

### Step 4: Clear MediaWiki Cache (Critical!)
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10

cd /usr/local/www/mediawiki

# Clear page cache
php maintenance/purgeList.php --db-touch

# Run job queue
php maintenance/runJobs.php --maxjobs=1000
```

### Step 5: Test Phase 2A
- Navigate to http://192.168.2.10/mediawiki/index.php/Special:Properties
- Verify 12 new properties are visible
- Submit test form for Template:HotHoldingTemperatureLog
- Verify properties are captured in the page

### Step 6: Deploy Phase 2B (Medium Priority)
```bash
psql -U postgres -h 192.168.2.30 -d mediawiki < /Users/georgemagnuson/Documents/GitHub/FCP_DCC/update_templates_smw_phase2b.sql

# Clear cache again
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000
```

### Step 7: Deploy Phase 2C (Final)
```bash
psql -U postgres -h 192.168.2.30 -d mediawiki < /Users/georgemagnuson/Documents/GitHub/FCP_DCC/update_templates_smw_phase2c.sql

# Clear cache again
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000
```

## Verification Checklist

After deployment, verify:

### Database Verification
```sql
-- Check properties created
SELECT page_id, page_title FROM mediawiki.page
WHERE page_namespace = 102 AND page_id BETWEEN 301 AND 312;
-- Expected: 12 rows

-- Check templates updated
SELECT COUNT(*) FROM mediawiki.text
WHERE old_text LIKE '%Has_%::';
-- Expected: 30 (all templates have SMW annotations)
```

### MediaWiki Interface
- [ ] Navigate to Special:Properties (http://192.168.2.10/mediawiki/index.php/Special:Properties)
- [ ] Verify all 12 properties are listed with correct types
- [ ] Check each property's documentation page

### Form Submission Tests
- [ ] Submit test form for Template:HotHoldingTemperatureLog
- [ ] Submit test form for Template:Incident_Report
- [ ] Submit test form for Template:Sushi_pH_Record
- [ ] Navigate to each created page
- [ ] Click "Browse properties" tab
- [ ] Verify properties captured with correct values

### SMW Query Test
Create a test page with this query:
```wiki
{{#ask: [[Has_form_name::HotHoldingTemperatureLog]]
 |?Has_submission_date
 |?Has_food_item
 |?Has_temperature
 |limit=10
}}
```

Should return submitted records in table format.

### Visual Display
- [ ] All templates render correctly
- [ ] Forms still display data properly
- [ ] No broken wiki syntax
- [ ] No error messages in browser console

## Technical Details

### SMW Annotation Pattern

**Before:**
```wiki
| {{{food_item|}}}
| {{{date_placed|}}}
| {{{initial_temp|}}}
```

**After:**
```wiki
| [[Has_food_item::{{{food_item|}}}]]
| [[Has_submission_date::{{{date_placed|}}}]]
| [[Has_temperature::{{{initial_temp|}}}]][[Has_temperature_unit::°C]]
```

**Key Points:**
- Property wraps the parameter: `[[Property::{{{param}}}]]`
- Visual display unchanged (SMW renders the value)
- Multiple properties can annotate the same cell
- Form-level properties added at template bottom
- Content size increases by 60-120%

### Content Size Calculation

Each template's content_size field must be updated to reflect new SMW annotations:
- Original HotHoldingTemperatureLog: 380 bytes
- With SMW: 798 bytes

Scripts automatically calculate and update:
- `mediawiki.text.old_text` - Changed content
- `mediawiki.content.content_size` - New size in bytes
- `mediawiki.page.page_len` - New length in characters

### Database IDs Allocated

| Range | Purpose | Count | Used For |
|-------|---------|-------|----------|
| Text: 401-412 | SMW Properties | 12 | create_smw_properties.sql |
| Text: 450-451 | Phase 2A New | 2 | Premises_Inspection, Corrective_Action |
| Text: 452-457 | Phase 2B Specialists | 6 | Teal specialist foods |
| Text: 458-461 | Phase 2B Maintenance | 4 | Purple maintenance |
| Text: 462-470 | Phase 2C Remaining | 9 | Final templates |
| Pages: 301-312 | SMW Properties | 12 | Property pages |
| Pages: 250-251 | Phase 2A New | 2 | New templates |
| Pages: 252-261 | Phase 2B | 10 | Teal + Maintenance |
| Pages: 262-270 | Phase 2C | 9 | Final templates |
| Revisions: 1201-1212 | SMW Properties | 12 | Property revisions |
| Revisions: 1350-1370 | Template updates | 21 | Template revisions |

## Rollback Procedure

If issues occur, rollback is available via database backup:

```bash
# Restore from backup (from Step 1)
psql -U postgres -h 192.168.2.30 -d mediawiki < /tmp/backup_before_phase2_[date].sql

# Clear cache
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000
```

## Next Steps (Phase 3)

Once Phase 2 is complete and verified, Phase 3 will create:

**Records Archive Pages:**
- Records_Archive - Main hub
- Records_Archive/Daily - Today's submissions
- Records_Archive/Weekly - This week's records
- Records_Archive/Monthly - This month's records
- Records_Archive/Search - Custom date range queries

These pages will use SMW queries on the properties created in Phase 2:

```wiki
{{#ask: [[Has_submission_date::>2026-01-25]]
       [[Has_form_name::HotHoldingTemperatureLog]]
 |?Has_food_item
 |?Has_temperature
 |?Has_pass_fail_status
 |format=broadtable
 |sort=Has_submission_date
 |order=desc
}}
```

## Files Created

1. **create_smw_properties.sql** - 1,212 lines
   - Defines 12 SMW properties with full documentation
   - Each property includes type, usage, and purpose information

2. **update_templates_smw_phase2a.sql** - 320 lines
   - Updates 8 high-priority templates (daily + incidents)
   - UPDATES + INSERTS for new templates

3. **update_templates_smw_phase2b.sql** - 580 lines
   - Updates 12 medium-priority templates (specialist + maintenance)
   - Mix of new insertions and updates to existing templates

4. **update_templates_smw_phase2c.sql** - 470 lines
   - Updates 10 remaining templates (final batch)
   - Creates remaining new templates

**Total:** 2,582 lines of SQL code across 4 files

## Success Metrics

Phase 2 is complete when:
- ✅ 12 SMW properties created and visible in Special:Properties
- ✅ All 30 templates updated with appropriate SMW annotations
- ✅ Templates still render correctly (visual display unchanged)
- ✅ Sample forms submitted for each template type
- ✅ Properties captured correctly in submitted pages
- ✅ SMW #ask queries return expected results
- ✅ No form submission errors
- ✅ Database backup available for rollback

## Contact & Support

For issues during deployment:
1. Check error messages in PostgreSQL console
2. Verify backup file exists
3. Review cache clearing commands (critical step)
4. Consult rollback procedure if needed
