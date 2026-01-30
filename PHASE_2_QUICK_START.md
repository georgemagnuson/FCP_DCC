# Phase 2 Quick Start Guide

## What Was Created

4 SQL scripts to add semantic capabilities to all 30 form templates:

| Script | Templates | Lines | Status |
|--------|-----------|-------|--------|
| create_smw_properties.sql | 12 SMW Properties | 1,212 | Ready |
| update_templates_smw_phase2a.sql | 8 templates (daily/incidents) | 320 | Ready |
| update_templates_smw_phase2b.sql | 12 templates (specialist/maintenance) | 580 | Ready |
| update_templates_smw_phase2c.sql | 10 templates (final) | 470 | Ready |

## Deployment Sequence

### Phase 2A (Day 1)
```bash
# 1. Backup database
pg_dump -U postgres -h 192.168.2.30 mediawiki > /tmp/backup_before_phase2.sql

# 2. Create SMW properties (12 new Property pages)
psql -U postgres -h 192.168.2.30 -d mediawiki < create_smw_properties.sql

# 3. Update 8 high-priority templates
psql -U postgres -h 192.168.2.30 -d mediawiki < update_templates_smw_phase2a.sql

# 4. Clear cache
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000

# 5. Test: Visit http://192.168.2.10/mediawiki/index.php/Special:Properties
# Verify 12 properties visible, submit test form
```

### Phase 2B (Day 2)
```bash
# 1. Update 12 medium-priority templates
psql -U postgres -h 192.168.2.30 -d mediawiki < update_templates_smw_phase2b.sql

# 2. Clear cache
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000

# 3. Test: Submit forms from specialist and maintenance templates
```

### Phase 2C (Day 3)
```bash
# 1. Update 10 remaining templates
psql -U postgres -h 192.168.2.30 -d mediawiki < update_templates_smw_phase2c.sql

# 2. Clear cache
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000

# 3. Full verification: All 30 templates, full test suite
```

## 12 New SMW Properties

These enable semantic queries in Phase 3:

1. **Has_submission_date** (Date) - When form was submitted
2. **Has_record_type** (Text) - Daily/Weekly/Monthly/Incident
3. **Has_staff_name** (Text) - Person who completed form
4. **Has_form_name** (Text) - Which template was used
5. **Has_temperature** (Number) - Temperature readings
6. **Has_temperature_unit** (Text) - Always "°C"
7. **Has_equipment_unit** (Text) - Equipment ID
8. **Has_food_item** (Text) - Food product name
9. **Has_pass_fail_status** (Text) - Pass/Fail outcome
10. **Has_corrective_action** (Text) - Actions taken
11. **Has_incident_severity** (Text) - Low/Medium/High/Critical
12. **Has_investigation_status** (Text) - Open/In Progress/Resolved

## 30 Templates Updated

### Orange (7)
1. HotHoldingTemperatureLog ✅
2. FoodTransportLog ✅
3. LiveShellfishDisplayLog ✅
4. SelfServiceDisplayChecklist ✅
5. IngredientAllergenRegister ✅
6. FoodLabelSpecifications ✅
7. B2BCustomerSupplyRegister ✅

### Purple (9)
1. Premises_Condition_Inspection ✅
2. Daily_Cleaning_Sanitising_Log ✅
3. End_of_Day_Stock_Control ✅
4. Waste_Rubbish_Management ✅
5. Maintenance_Chemical_Safety ✅
6. Equipment_Maintenance_Log ✅
7. Calibration_Record ✅
8. Water_System_Maintenance ✅
9. Roof_Water_Supply_Checklist ✅

### Red (8)
1. Incident_Report ✅
2. Complaint_Log ✅
3. Corrective_Action_Plan ✅
4. Food_Traceability_Record ✅
5. Recall_Notification ✅
6. Regulatory_Report ✅
7. Root_Cause_Analysis ✅
8. Investigation_Log ✅

### Teal (6)
1. Sushi_pH_Record ✅
2. Roast_Duck_Temperature_Log ✅
3. Doner_Kebab_Cooking_Log ✅
4. Sous_Vide_Cooking_Log ✅
5. Raw_Meat_Decontamination_Log ✅
6. Biltong_Production_Record ✅

## Critical: Cache Clearing

**MUST run after EVERY SQL script execution:**

```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000
```

Without this step, new properties and templates won't appear in MediaWiki UI.

## Testing Each Phase

### After Phase 2A
```wiki
# On any wiki page, verify query works:
{{#ask: [[Has_form_name::HotHoldingTemperatureLog]]
 |?Has_submission_date
 |limit=5
}}
```

### After Phase 2B
- Submit test form from: Sushi_pH_Record, Equipment_Maintenance_Log
- Verify properties captured

### After Phase 2C
- Full test of all 30 templates
- Submit at least 2 test forms from each template
- Verify all properties captured

## Rollback (If Needed)

If anything breaks:

```bash
# Restore from backup created in first step
psql -U postgres -h 192.168.2.30 -d mediawiki < /tmp/backup_before_phase2.sql

# Clear cache
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php --maxjobs=1000
```

Database is restored to pre-Phase2 state. No data loss.

## Files Location

All in `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/`:

- create_smw_properties.sql
- update_templates_smw_phase2a.sql
- update_templates_smw_phase2b.sql
- update_templates_smw_phase2c.sql
- PHASE_2_IMPLEMENTATION.md (full documentation)
- PHASE_2_QUICK_START.md (this file)

## What Comes Next (Phase 3)

Once Phase 2 is verified:
- Create Records Archive main page
- Create Records Archive/Daily, /Weekly, /Monthly, /Search pages
- Test semantic queries on real form data
- Build query library for common searches

These will enable:
- "Show all failed temperature checks from this week"
- "List all high-severity incidents from last month"
- "Display today's submitted daily forms"
