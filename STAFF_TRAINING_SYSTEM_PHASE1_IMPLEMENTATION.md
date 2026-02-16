# Staff Training System - Phase 1 Implementation

## Overview
Complete role-based staff training management system with employee self-completion and supervisor verification workflow.

**Status**: ✅ Ready for Deployment
**Date**: 2026-02-16
**Deployment Script**: `create_staff_training_system_phase1.sql`

## Database Allocation
- **Page IDs**: 370-390 (21 pages total)
- **Text IDs**: 470-490
- **Revision IDs**: 1256-1276
- **Content IDs**: 470-490

## Component Breakdown

### Part 1: SMW Properties (10 pages, IDs 370-379)

Training tracking foundation - enable semantic queries to filter and report on training data.

| ID | Property | Type | Purpose |
|----|----------|------|---------|
| 370 | Has_employee_name | Text | Employee identifier for training records |
| 371 | Has_assigned_role | Text | Kitchen Staff, Waitstaff, Supervisor, Trainer |
| 372 | Has_training_section | Page | Links to FCP section being trained on |
| 373 | Has_completion_status | Text | Not Started, In Progress, Completed, Verified |
| 374 | Has_verification_status | Text | Not Verified, Verified |
| 375 | Has_supervisor_name | Text | Who verified the training |
| 376 | Has_date_assigned | Date | Assignment date |
| 377 | Has_date_completed | Date | Employee completion date |
| 378 | Has_date_verified | Date | Supervisor verification date |
| 379 | Has_demonstrated_understanding | Boolean | Yes/No understanding confirmation |

### Part 2: Categories (3 pages, IDs 386-388)

Organizational structure for training records.

| ID | Category | Purpose |
|----|----------|---------|
| 386 | Category:Training_Assignment | Contains training assignment records from supervisors |
| 387 | Category:Training_Completion | Contains completion records from employees |
| 388 | Category:Training_Verification | Contains verification records from supervisors |

### Part 3: Templates (3 pages, IDs 381, 383, 385)

Display and semantic markup for training forms.

| ID | Template | Purpose |
|----|----------|---------|
| 381 | Template:Training_Assignment | Displays supervisor training assignments |
| 383 | Template:Training_Completion | Displays employee completion records |
| 385 | Template:Training_Verification | Displays supervisor verifications |

### Part 4: Forms (3 pages, IDs 380, 382, 384)

User-facing data entry interfaces.

| ID | Form | Purpose | Users |
|----|------|---------|-------|
| 380 | Form:Training_Assignment | Create training assignments | Supervisors, Managers |
| 382 | Form:Training_Completion | Mark sections complete | Employees |
| 384 | Form:Supervisor_Verification | Verify employee completion | Supervisors |

### Part 5: Portal Pages (2 pages, IDs 389-390)

User dashboards with SMW queries for filtered views.

| ID | Portal | Purpose | Users |
|----|--------|---------|-------|
| 389 | Employee_Training_Status | View assigned training, mark complete, track verifications | Employees |
| 390 | Supervisor_Training_Verification | Manage verifications, track progress by role | Supervisors |

## Workflow

```
┌─────────────────────────────────────────────────────────────┐
│ SUPERVISOR: Create Training Assignment                      │
│ (Form:Training_Assignment → Template:Training_Assignment)   │
│ Creates record with employee_name, assigned_roles, date     │
└────────────────┬────────────────────────────────────────────┘
                 │ Has_completion_status: "Not Started"
                 ↓
┌─────────────────────────────────────────────────────────────┐
│ EMPLOYEE: Complete Training                                 │
│ (Employee_Training_Status portal → Form:Training_Completion)│
│ Marks section read, submits completion record               │
└────────────────┬────────────────────────────────────────────┘
                 │ Has_completion_status: "Completed"
                 │ Has_verification_status: "Not Verified"
                 ↓
┌─────────────────────────────────────────────────────────────┐
│ SUPERVISOR: Verify Training                                 │
│ (Supervisor portal → Form:Supervisor_Verification)          │
│ Confirms completion, verifies understanding                 │
└────────────────┬────────────────────────────────────────────┘
                 │ Has_completion_status: "Verified"
                 │ Has_verification_status: "Verified"
                 │ Has_demonstrated_understanding: "Yes/No"
                 ↓
            [COMPLETE]
```

## Key Features

### 1. **Role-Based Access**
- Employees see their own assigned training and completion status
- Supervisors see all assignments and pending verifications
- SMW queries filter by employee/supervisor name automatically

### 2. **Two-Step Verification**
- **Employee Step**: Completes reading and marks section done
- **Supervisor Step**: Verifies completion and confirms understanding
- Separate status fields (`completion_status` vs `verification_status`) track workflow stage

### 3. **Flexible Role Assignment**
- Training Assignment form supports multiple roles per employee
- Checkboxes allow selecting: Kitchen Staff, Waitstaff, Supervisor, Trainer
- Enables multi-role training assignments

### 4. **Date Tracking**
- Assigned date (when supervisor assigns)
- Completed date (when employee finishes)
- Verified date (when supervisor confirms)
- Enables tracking of time-to-completion metrics

### 5. **Understanding Validation**
- Boolean `Has_demonstrated_understanding` field
- Supervisors can flag cases where employee finished reading but didn't understand
- Separate from basic completion tracking

### 6. **Portal Navigation**
- Employee portal shows assigned training, pending work, verified records
- Supervisor portal shows pending verifications, progress by role, recent verifications
- Uses SMW #ask queries to filter dynamically

## Deployment Steps

1. **Copy SQL File**
   ```bash
   # The script is ready at:
   /Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_staff_training_system_phase1.sql
   ```

2. **Execute on PostgreSQL Database Server (192.168.2.30)**
   ```bash
   psql -h 192.168.2.30 -U mediawiki_user -d mediawiki_db \
     -f create_staff_training_system_phase1.sql
   ```

3. **Clear MediaWiki Cache**
   ```bash
   ssh 192.168.2.10 'cd /usr/local/www/mediawiki && \
     php maintenance/purgeList.php --db-touch && \
     php maintenance/runJobs.php'
   ```

4. **Verify Deployment**
   ```bash
   # Check all 21 pages created
   psql -h 192.168.2.30 -U mediawiki_user -d mediawiki_db -c \
     "SELECT COUNT(*) as total_pages FROM mediawiki.page WHERE page_id BETWEEN 370 AND 390;"
   # Expected: 21

   # Check properties
   psql -h 192.168.2.30 -U mediawiki_user -d mediawiki_db -c \
     "SELECT page_title FROM mediawiki.page WHERE page_namespace=102 AND page_id BETWEEN 370 AND 379;"
   # Expected: 10 properties
   ```

## Testing Workflow

### 1. Test Form Creation
- Visit: `http://192.168.2.10/Form:Training_Assignment`
- Verify form displays with fields: employee_name, assigned_roles, date_assigned, etc.

### 2. Test Employee Portal
- Create test assignment: assign training to test employee
- Visit: `http://192.168.2.10/Employee_Training_Status`
- Verify page shows assigned training

### 3. Test Completion
- Create test completion record using Form:Training_Completion
- Verify it appears on Employee portal under "Pending Supervisor Verification"

### 4. Test Supervisor Portal
- Visit: `http://192.168.2.10/Supervisor_Training_Verification`
- Verify pending verifications appear in table

### 5. Test Verification
- Use Form:Supervisor_Verification to verify employee completion
- Verify record appears under "Recently Verified Training"

### 6. Test SMW Queries
- Run a direct semantic query to verify properties are indexed:
  ```
  {{#ask: [[Category:Training_Completion]]
         [[Has_employee_name::Test Employee]]
   |?Has_training_section=Section
   |format=broadtable
  }}
  ```

## Schema Details

### Text Content IDs (470-490)

| ID | Purpose | Size (bytes) |
|----|---------|--------------|
| 470 | Property: Has_employee_name | 280 |
| 471 | Property: Has_assigned_role | 380 |
| 472 | Property: Has_training_section | 380 |
| 473 | Property: Has_completion_status | 520 |
| 474 | Property: Has_verification_status | 420 |
| 475 | Property: Has_supervisor_name | 330 |
| 476 | Property: Has_date_assigned | 330 |
| 477 | Property: Has_date_completed | 310 |
| 478 | Property: Has_date_verified | 320 |
| 479 | Property: Has_demonstrated_understanding | 440 |
| 480 | Category: Training_Assignment | 340 |
| 481 | Category: Training_Completion | 360 |
| 482 | Category: Training_Verification | 360 |
| 483 | Template: Training_Assignment | 560 |
| 484 | Template: Training_Completion | 520 |
| 485 | Template: Training_Verification | 760 |
| 486 | Form: Training_Assignment | 740 |
| 487 | Form: Training_Completion | 620 |
| 488 | Form: Supervisor_Verification | 940 |
| 489 | Portal: Employee_Training_Status | 1370 |
| 490 | Portal: Supervisor_Training_Verification | 2100 |

## Namespace References

| Namespace | ID | Purpose | Pages This Phase |
|-----------|----|---------|----|
| Property | 102 | SMW properties for semantic data | 10 |
| Template | 10 | Display templates for forms | 3 |
| Form | 106 | PF form definitions | 3 |
| Category | 14 | Record categorization | 3 |
| Main | 0 | Public portal pages | 2 |

## SMW Integration

All 10 properties are fully integrated with MediaWiki's Semantic MediaWiki extension:

```wiki
[[Has_employee_name::John Smith]]
[[Has_assigned_role::Kitchen Staff]]
[[Has_training_section::Temperature_Monitoring]]
[[Has_completion_status::Completed]]
[[Has_verification_status::Not Verified]]
[[Has_supervisor_name::Sarah Manager]]
[[Has_date_assigned::2026-02-16]]
[[Has_date_completed::2026-02-20]]
[[Has_date_verified::2026-02-21]]
[[Has_demonstrated_understanding::Yes]]
```

These properties enable #ask queries used in the portals:

```wiki
{{#ask: [[Category:Training_Completion]]
       [[Has_employee_name::John Smith]]
       [[Has_verification_status::Not Verified]]
 |?Has_training_section=Section
 |format=broadtable
}}
```

## Next Phase Preview

**Phase 2** will add:
- Training section master list (auto-populated from FCP sections)
- Bulk assignment features for role-based training
- Email notification system
- Training expiration/renewal tracking
- Comprehensive reporting dashboards
- Performance metrics by supervisor

## Success Criteria

✅ All 21 pages created with correct namespaces
✅ All 10 SMW properties fully defined
✅ Forms display correctly with proper field types
✅ Templates render data with semantic properties
✅ Both portals show filtered views
✅ SMW queries return expected results
✅ Navigation between assignment → completion → verification works
✅ Database verification queries return expected counts

## Support

### File Locations
- Deployment script: `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/create_staff_training_system_phase1.sql`
- Documentation: `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/STAFF_TRAINING_SYSTEM_PHASE1_IMPLEMENTATION.md`

### Database References
- Template examples: `create_employee_system.sql`, `create_daily_activity_forms.sql`
- Property patterns: `create_smw_properties.sql`
- Portal patterns: `create_records_archive.sql`

### Related Documentation
- Main page with training system links: `Main_Page`
- Food Control Plan sections: FCP navigation hub

---

**Prepared by**: Claude Code
**Last Updated**: 2026-02-16
**Status**: ✅ Ready for Production Deployment
