# Staff Training System - Quick Reference Guide

## Quick Links
- **Deployment Script**: `create_staff_training_system_phase1.sql` (915 lines, 105 INSERT statements)
- **Full Documentation**: `STAFF_TRAINING_SYSTEM_PHASE1_IMPLEMENTATION.md`
- **Status**: ✅ Ready for Production Deployment

## Page Allocation at a Glance

| Section | Count | IDs | Namespaces |
|---------|-------|-----|-----------|
| Properties | 10 | 370-379 | 102 |
| Categories | 3 | 386-388 | 14 |
| Templates | 3 | 381,383,385 | 10 |
| Forms | 3 | 380,382,384 | 106 |
| Portals | 2 | 389-390 | 0 |
| **TOTAL** | **21** | **370-390** | |

## The Three Key Forms

### 1. **Form:Training_Assignment** (Page 380)
*Supervisors assign training to employees*
- Fields: employee_name, assigned_roles (multi-checkbox), date_assigned, notes, status
- Creates: Training Assignment records
- Category: Training_Assignment

### 2. **Form:Training_Completion** (Page 382)
*Employees mark sections complete*
- Fields: section_link, employee_name, date_completed, completion_checkbox
- Creates: Training Completion records
- Category: Training_Completion
- Status: "Completed" + "Not Verified"

### 3. **Form:Supervisor_Verification** (Page 384)
*Supervisors verify employee completions*
- Fields: employee_name, section_title, supervisor_name, date_verified, understanding_checkbox, notes
- Creates: Training Verification records
- Category: Training_Verification
- Status: "Completed" + "Verified"

## The Two Portals

### **Employee_Training_Status** (Page 389)
Employees see:
- ✓ Their assigned training (with roles and dates)
- ✓ Button to mark sections complete
- ✓ Verified completed training with supervisor names
- ✓ Pending verifications awaiting supervisor action

**URL**: `http://[wiki]/Employee_Training_Status`
**Queries**: Filters by {{PAGENAME}} (their own name)

### **Supervisor_Training_Verification** (Page 390)
Supervisors see:
- ✓ Pending verifications (by date)
- ✓ Button to verify training
- ✓ Employee progress grouped by role (Kitchen Staff, Waitstaff, Supervisors)
- ✓ Recently verified training (most recent first)
- ✓ Button to create new assignments

**URL**: `http://[wiki]/Supervisor_Training_Verification`
**Queries**: Shows all records (not filtered by person)

## The 10 Properties

```
Identification:
  370: Has_employee_name          → Filter by employee
  371: Has_assigned_role          → Filter by Kitchen Staff/Waitstaff/Supervisor/Trainer
  372: Has_training_section       → Link to FCP pages being trained on

Status Tracking:
  373: Has_completion_status      → Not Started|In Progress|Completed|Verified
  374: Has_verification_status    → Not Verified|Verified

People:
  375: Has_supervisor_name        → Who verified it

Dates:
  376: Has_date_assigned          → Supervisor assigned it (date)
  377: Has_date_completed         → Employee finished reading (date)
  378: Has_date_verified          → Supervisor confirmed it (date)

Quality:
  379: Has_demonstrated_understanding → Yes|No (understanding validation)
```

## Workflow in One Picture

```
SUPERVISOR creates assignment
        ↓
    Workflow: Not Started
        ↓
    [Employee_Training_Status portal shows assignment]
        ↓
EMPLOYEE clicks "Mark Section Complete"
        ↓
    Workflow: Completed + Not Verified
        ↓
    [Supervisor_Training_Verification portal shows pending item]
        ↓
SUPERVISOR clicks "Verify Employee Training"
        ↓
    Workflow: Completed + Verified
        ↓
    [Employee_Training_Status shows as verified, moving to "Completed Training" section]
        ↓
    [Supervisor_Training_Verification shows in "Recently Verified" section]
```

## Deployment Command (PostgreSQL)

```bash
# On MediaWiki server:
psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db \
  -f create_staff_training_system_phase1.sql
```

## Verification After Deployment

```bash
# Check all 21 pages created:
psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
  "SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 370 AND 390;"
# Expected: 21

# Check properties specifically:
psql -h 192.168.2.10 -U mediawiki_user -d mediawiki_db -c \
  "SELECT COUNT(*) FROM mediawiki.page WHERE page_namespace=102 AND page_id BETWEEN 370 AND 379;"
# Expected: 10
```

## Testing Checklist

- [ ] Visit Form:Training_Assignment - form displays
- [ ] Create test assignment - record created successfully
- [ ] Visit Employee_Training_Status - shows assigned training
- [ ] Employee completes section - record created
- [ ] Pending verification appears on Supervisor portal
- [ ] Supervisor verifies - verification record created
- [ ] Record moves to "Recently Verified" section
- [ ] SMW #ask queries return correct results

## File References

All original patterns came from existing scripts:
- `create_smw_properties.sql` - Property structure pattern
- `create_employee_system.sql` - Form/template pattern
- `create_daily_activity_forms.sql` - Modern schema pattern
- `create_records_archive.sql` - Portal with SMW queries pattern

## Database IDs Used

- **Text IDs**: 470-490 (21 content records)
- **Page IDs**: 370-390 (21 pages)
- **Revision IDs**: 1256-1276 (21 revisions)
- **Content IDs**: 470-490 (same as text IDs)

**No conflicts with existing IDs** - follows sequential allocation (max was 369, starting at 370)

## Key Design Decisions

1. **Separate completion_status and verification_status** - tracks two-step workflow clearly
2. **Boolean field for understanding** - supervisors can flag non-understanding without marking failed
3. **Page type for training_section** - allows direct linking to FCP documentation
4. **Checkboxes for roles** - enables multi-role assignments (e.g., Kitchen Staff + Trainer)
5. **SMW queries in portals** - dynamic filtering by employee/supervisor without hardcoding

## Next Phase (Phase 2)

Will add:
- Training section master list
- Bulk assignment
- Email notifications
- Expiration tracking
- Reporting dashboards

---

**Questions?** See full documentation: `STAFF_TRAINING_SYSTEM_PHASE1_IMPLEMENTATION.md`
