# Red (Troubleshooting) Section - Complete Documentation Index

**Generated:** 2026-01-29
**Project:** FCP_DCC (Food Compliance Protocol - Digital Content Conversion)
**Section:** Red (Troubleshooting) - Pages 189-208
**Total Pages:** 20
**Total Data:** ~29.6 KB

---

## Quick Start

### Execute the SQL Script
```bash
cd /Users/georgemagnuson/Documents/GitHub/FCP_DCC
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 < red_troubleshooting_section.sql
```

### Verify Deployment
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT page_id, page_namespace, page_title FROM mediawiki.page WHERE page_id BETWEEN 189 AND 208 ORDER BY page_id;"
# Expected result: 20 rows
```

---

## Generated Files

### 1. Main SQL Script
**File:** `red_troubleshooting_section.sql` (~1,100 lines)
**Status:** Ready for deployment
**Content:**
- 4 content pages (Know/Do/Show sections)
- 8 form templates (MediaWiki namespace 10)
- 8 form pages (MediaWiki namespace 0)
- 100 total INSERT statements
- Verification queries at the end

**Execute with:**
```bash
psql -U postgres -d mediawiki -h 192.168.2.30 < red_troubleshooting_section.sql
```

**Key Features:**
- Wrapped in BEGIN/COMMIT transaction
- All IDs sequential and non-overlapping (189-208)
- Byte calculations pre-computed
- Categories properly assigned to all pages

### 2. Quick Reference Guide
**File:** `RED_QUICK_REFERENCE.md`
**Purpose:** Fast lookup reference with page allocations, execution commands, form fields

### 3. Section Index
**File:** `RED_SECTION_INDEX.md` (this file)
**Purpose:** Complete documentation with full content details

### 4. Byte Calculations
**File:** `RED_BYTE_CALCULATIONS.txt`
**Purpose:** Size verification for all 20 pages

---

## Content Pages (Pages 189-192)

### Page 189: FCP:Troubleshooting:Something_goes_wrong
**Namespace:** 0 (main)
**Text ID:** 303
**Size:** 2,863 bytes
**Revision ID:** 1078

**Content Structure:**
```
Know Section:
- Inevitable incidents and problems
- Importance of systematic approach
- Rapid response and documentation
- Classification by severity
- Staff awareness and response procedures
- Incident as learning opportunity

Do Section:
- Incident response team establishment
- Incident reporting procedures
- Incident classification (Low/Medium/High/Critical)
- Response protocols for each severity level
- Documentation requirements
- Evidence preservation
- Customer communication
- Regulatory authority contact
- Incident review procedures
- Corrective action implementation

Show Section:
- Incident reporting procedures
- Incident register
- Evidence of response actions
- Corrective action documentation
- Staff training records
- Management review meeting minutes
- Regulatory notifications
```

**Categories:** `Red:Troubleshooting`

### Page 190: FCP:Troubleshooting:Dealing_complaints
**Namespace:** 0 (main)
**Text ID:** 304
**Size:** 2,534 bytes
**Revision ID:** 1079

**Content Structure:**
```
Know Section:
- Complaints as valuable information
- Taking all complaints seriously
- Prompt and professional handling importance
- Different complaint types and responses
- Documentation and regulatory requirements
- Staff training needs
- Transparent investigation and communication
- Complaint as system improvement opportunity

Do Section:
- Staff training on professional complaint receipt
- Listening and empathy procedures
- Immediate complaint documentation
- Customer contact and explanation procedures
- Appropriate compensation guidelines
- Food safety complaint escalation
- Investigation procedures
- Root cause determination
- Corrective action implementation
- Customer follow-up communication
- Complaint pattern review
- Regulatory authority reporting

Show Section:
- Complaint log
- Investigation documentation
- Root cause analysis
- Corrective action records
- Customer communication evidence
- Regulatory notifications
- Staff training records
- Management meeting minutes
```

**Categories:** `Red:Troubleshooting`

### Page 191: FCP:Troubleshooting:Tracing_food
**Namespace:** 0 (main)
**Text ID:** 305
**Size:** 2,431 bytes
**Revision ID:** 1080

**Content Structure:**
```
Know Section:
- Effective traceability foundation
- Speed of response importance
- Backward and forward traceability concepts
- Complete documentation requirements
- Batch/lot number criticality
- Over-cautious recall prevention
- Record retention requirements
- Regular testing importance
- Different product type approaches

Do Section:
- Unique identification system establishment
- Batch/lot number recording
- Storage location documentation
- Product usage/sale recording
- Prepared food linking to ingredients
- Supplier list maintenance
- Customer list maintenance
- Regular traceability testing
- High-risk product focus
- Record retention compliance
- Record accessibility
- Annual system review
- Staff training

Show Section:
- Supplier records
- Customer records
- Product receipt records with batch numbers
- Daily usage records
- Traceability test records
- System documentation
- Staff training records
```

**Categories:** `Red:Troubleshooting`

### Page 192: FCP:Troubleshooting:Recalling_food
**Namespace:** 0 (main)
**Text ID:** 306
**Size:** 2,541 bytes
**Revision ID:** 1081

**Content Structure:**
```
Know Section:
- Recall definition and seriousness
- Voluntary vs mandatory recalls
- Traceability system dependence
- Recall classification (Class 1/2/3)
- Regulatory authority notification
- Transparency importance
- Media event management
- Staff coordination needs
- Investigation and corrective action

Do Section:
- Recall identification procedures
- Recall classification
- Management and authority notification
- Regulatory authority contact
- Traceability system usage
- Batch/lot identification
- Customer identification
- Recall notification preparation
- Customer contact procedures
- Retail partner notification
- Recovery tracking
- Detailed record keeping
- Destruction documentation
- Formal recall reporting
- Lessons learned sharing
- Root cause analysis
- Corrective action implementation

Show Section:
- Recall notification letter
- Customer contact list
- Contact dates and methods
- Product recovery records
- Recovery vs distribution documentation
- Formal recall report
- Root cause analysis
- Corrective actions
- Regulatory communication
- Staff communication
```

**Categories:** `Red:Troubleshooting`

---

## Form Templates (Pages 193-200, Namespace 10)

### Page 193: Template:Incident_Report
**Size:** 445 bytes | **Text ID:** 307 | **Revision ID:** 1082
**Table Fields:** date_time, incident_type, location, description, staff_involved, immediate_actions, severity, management_notified

### Page 194: Template:Complaint_Log
**Size:** 428 bytes | **Text ID:** 308 | **Revision ID:** 1083
**Table Fields:** date_received, customer_name, complaint_type, product_service, description, investigation_status, resolution, status

### Page 195: Template:Food_Traceability_Record
**Size:** 452 bytes | **Text ID:** 309 | **Revision ID:** 1084
**Table Fields:** product_name, batch_lot, supplier, delivery_date, storage_location, usage_date, distributed_to, quantity_distributed

### Page 196: Template:Recall_Notification
**Size:** 457 bytes | **Text ID:** 310 | **Revision ID:** 1085
**Table Fields:** recall_date, product_id, batch_lots, recall_reason, risk_level, quantity_distributed, quantity_recovered, recall_status

### Page 197: Template:Corrective_Action_Plan
**Size:** 435 bytes | **Text ID:** 311 | **Revision ID:** 1086
**Table Fields:** date, issue_description, root_cause, corrective_action, action_owner, target_completion, priority, status

### Page 198: Template:Regulatory_Report
**Size:** 433 bytes | **Text ID:** 312 | **Revision ID:** 1087
**Table Fields:** report_date, regulatory_body, report_type, incident_reference, notification_method, acknowledgment_received, reference_number, status

### Page 199: Template:Root_Cause_Analysis
**Size:** 441 bytes | **Text ID:** 313 | **Revision ID:** 1088
**Table Fields:** analysis_date, incident_reference, problem_statement, root_cause, contributing_factors, evidence, recommended_actions, status

### Page 200: Template:Investigation_Log
**Size:** 444 bytes | **Text ID:** 314 | **Revision ID:** 1089
**Table Fields:** investigation_number, start_date, incident_reference, lead_investigator, investigation_scope, interviews_conducted, documents_reviewed, findings

---

## Form Pages (Pages 201-208, Namespace 0)

### Page 201: Form:Incident_Report
**Size:** 1,125 bytes | **Text ID:** 315 | **Revision ID:** 1090
**Template Reference:** Template:Incident_Report
**Form Fields:** 8 inputs
- Date/Time (datetime-local)
- Incident Type (dropdown: 6 options)
- Location (text)
- Description (textarea)
- Staff Member (text)
- Immediate Actions (textarea)
- Severity (dropdown: 4 options)
- Management Notified (select: 2 options)

**Categories:** `Red:Troubleshooting`, `Incident_Reports`

### Page 202: Form:Complaint_Log
**Size:** 1,275 bytes | **Text ID:** 316 | **Revision ID:** 1091
**Template Reference:** Template:Complaint_Log
**Form Fields:** 8 inputs
- Date Received (date)
- Customer Name (text)
- Complaint Type (dropdown: 8 options)
- Product/Service (text)
- Description (textarea)
- Investigation Status (dropdown: 3 options)
- Resolution (textarea)
- Status (dropdown: 4 options)

**Categories:** `Red:Troubleshooting`, `Complaint_Logs`

### Page 203: Form:Food_Traceability_Record
**Size:** 1,128 bytes | **Text ID:** 317 | **Revision ID:** 1092
**Template Reference:** Template:Food_Traceability_Record
**Form Fields:** 9 inputs
- Product Name (text)
- Batch/Lot Number (text)
- Supplier (text)
- Delivery Date (date)
- Storage Location (text)
- Usage Date (date)
- Distributed To (textarea)
- Quantity (number)
- Unit (dropdown: 4 options)

**Categories:** `Red:Troubleshooting`, `Traceability_Records`

### Page 204: Form:Recall_Notification
**Size:** 1,181 bytes | **Text ID:** 318 | **Revision ID:** 1093
**Template Reference:** Template:Recall_Notification
**Form Fields:** 8 inputs
- Recall Date (date)
- Product ID (text)
- Batch/Lots (textarea)
- Recall Reason (dropdown: 7 options)
- Risk Level (dropdown: 3 options)
- Quantity Distributed (number)
- Quantity Recovered (number)
- Recall Status (dropdown: 4 options)

**Categories:** `Red:Troubleshooting`, `Recall_Notifications`

### Page 205: Form:Corrective_Action_Plan
**Size:** 1,127 bytes | **Text ID:** 319 | **Revision ID:** 1094
**Template Reference:** Template:Corrective_Action_Plan
**Form Fields:** 8 inputs
- Date (date)
- Issue Description (textarea)
- Root Cause (textarea)
- Corrective Action (textarea)
- Action Owner (text)
- Target Completion (date)
- Priority (dropdown: 4 options)
- Status (dropdown: 5 options)

**Categories:** `Red:Troubleshooting`, `Corrective_Actions`

### Page 206: Form:Regulatory_Report
**Size:** 1,365 bytes | **Text ID:** 320 | **Revision ID:** 1095
**Template Reference:** Template:Regulatory_Report
**Form Fields:** 9 inputs
- Report Date (date)
- Regulatory Body (dropdown: 5 options)
- Report Type (dropdown: 6 options)
- Incident Reference (text)
- Reported By (text)
- Notification Method (dropdown: 5 options)
- Acknowledgment (select: 2 options)
- Reference Number (text)
- Status (dropdown: 5 options)

**Categories:** `Red:Troubleshooting`, `Regulatory_Reports`

### Page 207: Form:Root_Cause_Analysis
**Size:** 1,295 bytes | **Text ID:** 321 | **Revision ID:** 1096
**Template Reference:** Template:Root_Cause_Analysis
**Form Fields:** 9 inputs
- Analysis Date (date)
- Incident Reference (text)
- Problem Statement (textarea)
- Root Cause (textarea)
- Contributing Factors (textarea)
- Evidence (textarea)
- Analysis Method (dropdown: 6 options)
- Recommended Actions (textarea)
- Status (dropdown: 4 options)

**Categories:** `Red:Troubleshooting`, `Root_Cause_Analysis`

### Page 208: Form:Investigation_Log
**Size:** 1,216 bytes | **Text ID:** 322 | **Revision ID:** 1097
**Template Reference:** Template:Investigation_Log
**Form Fields:** 9 inputs
- Investigation Number (text)
- Start Date (date)
- Incident Reference (text)
- Lead Investigator (text)
- Investigation Scope (textarea)
- Interviews Conducted (textarea)
- Documents Reviewed (textarea)
- Investigation Findings (textarea)
- Status (dropdown: 5 options)

**Categories:** `Red:Troubleshooting`, `Investigation_Logs`

---

## Database Schema Mapping

### mediawiki.text Table (20 entries)
| old_id | Size (bytes) | Purpose |
|--------|-------------|---------|
| 303-306 | 2863, 2534, 2431, 2541 | Content pages Know/Do/Show |
| 307-314 | 445-457 | Form templates (8) |
| 315-322 | 1125-1365 | Form pages (8) |

### mediawiki.content Table (20 entries)
All entries reference text IDs 303-322
- content_model: 1 (for all)
- content_address: tt:[old_id]

### mediawiki.revision Table (20 entries)
| rev_id | rev_page | rev_len | Purpose |
|--------|----------|---------|---------|
| 1078 | 189 | 2863 | Something_goes_wrong |
| 1079 | 190 | 2534 | Dealing_complaints |
| 1080 | 191 | 2431 | Tracing_food |
| 1081 | 192 | 2541 | Recalling_food |
| 1082-1089 | 193-200 | 445-457 | Form templates |
| 1090-1097 | 201-208 | 1125-1365 | Form pages |

### mediawiki.slots Table (20 entries)
All entries use:
- slot_role_id: 1
- slot_origin: revision_id (same as slot_revision_id)

### mediawiki.page Table (20 entries)
**Content Pages (Namespace 0):**
- Pages 189-192
- page_namespace: 0

**Form Templates (Namespace 10):**
- Pages 193-200
- page_namespace: 10

**Form Pages (Namespace 0):**
- Pages 201-208
- page_namespace: 0

---

## Integration Notes

### Category Structure
All pages are assigned to categories for organization:
- Primary: `Red:Troubleshooting`
- Secondary: Specific form/content categories
  - `Incident_Reports`
  - `Complaint_Logs`
  - `Traceability_Records`
  - `Recall_Notifications`
  - `Corrective_Actions`
  - `Regulatory_Reports`
  - `Root_Cause_Analysis`
  - `Investigation_Logs`

### MediaWiki Integration
- Forms use PageForms extension syntax
- Templates use MediaWiki table syntax with parameter placeholders
- All categories properly linked using `[[Category:...]]` syntax
- __NOTOC__ directive on templates to suppress table of contents

### Namespace Notes
- Content pages: Namespace 0 (main namespace)
- Templates: Namespace 10 (template namespace)
- Form definitions: Namespace 0 (main namespace)

---

## Verification Steps

### Step 1: Page Count
```sql
SELECT COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 189 AND 208;
-- Expected: 20
```

### Step 2: Text Entries
```sql
SELECT COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 303 AND 322;
-- Expected: 20
```

### Step 3: Revisions
```sql
SELECT COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1078 AND 1097;
-- Expected: 20
```

### Step 4: Content Integrity
```sql
SELECT page_id, page_namespace, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 189 AND 208
ORDER BY page_id;
```

### Step 5: MediaWiki UI Verification
- Access: http://mediawiki.local/wiki/Form:Incident_Report
- Test: Submit form data
- Verify: New page creation from form submission

### Step 6: Cache Clearing (if needed)
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php
```

---

## Maintenance Checklist

- [ ] SQL script executed successfully
- [ ] All 20 pages verified in database
- [ ] Content pages display correctly with Know/Do/Show sections
- [ ] Form templates render as wikitables
- [ ] Form pages accept form submissions
- [ ] Categories properly assigned
- [ ] MediaWiki cache cleared
- [ ] UI verification completed
- [ ] Documentation updated
- [ ] Project archive created (if applicable)

---

## Historical Context

**Preceding Sections:**
- Orange (Serving/Selling): Pages 122-141
- Purple (Closing): Pages 169-188

**This Section:**
- Red (Troubleshooting): Pages 189-208

**Potential Future Sections:**
- Additional regulatory sections as needed
- Integration sections linking all colors

---

## Support

For issues or questions:
1. Check `RED_QUICK_REFERENCE.md` for troubleshooting
2. Review `RED_BYTE_CALCULATIONS.txt` for data verification
3. Consult existing `PURPLE_SECTION_INDEX.md` for pattern reference
