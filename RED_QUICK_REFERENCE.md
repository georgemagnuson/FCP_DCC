# Red (Troubleshooting) Section - Quick Reference Guide

**Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/red_troubleshooting_section.sql`

**Total Pages:** 20
- 4 Content Pages (IDs 189-192)
- 8 Form Templates (IDs 193-200, namespace 10)
- 8 Form Pages (IDs 201-208, namespace 0)

**Text/Content IDs:** 303-322 (sequential)
**Revision IDs:** 1078-1097 (sequential)

---

## Page ID Allocations

### Content Pages (4)
| Page ID | Title | Text ID | Size | Type |
|---------|-------|---------|------|------|
| 189 | FCP:Troubleshooting:Something_goes_wrong | 303 | 2863 B | Know/Do/Show |
| 190 | FCP:Troubleshooting:Dealing_complaints | 304 | 2534 B | Know/Do/Show |
| 191 | FCP:Troubleshooting:Tracing_food | 305 | 2431 B | Know/Do/Show |
| 192 | FCP:Troubleshooting:Recalling_food | 306 | 2541 B | Know/Do/Show |

### Form Templates (8)
| Page ID | Template Name | Text ID | Size | Form Purpose |
|---------|---------------|---------|------|--------------|
| 193 | Template:Incident_Report | 307 | 445 B | Incident documentation |
| 194 | Template:Complaint_Log | 308 | 428 B | Complaint tracking |
| 195 | Template:Food_Traceability_Record | 309 | 452 B | Product traceability |
| 196 | Template:Recall_Notification | 310 | 457 B | Recall documentation |
| 197 | Template:Corrective_Action_Plan | 311 | 435 B | Corrective actions |
| 198 | Template:Regulatory_Report | 312 | 433 B | Regulatory notifications |
| 199 | Template:Root_Cause_Analysis | 313 | 441 B | Root cause analysis |
| 200 | Template:Investigation_Log | 314 | 444 B | Investigation tracking |

### Form Pages (8)
| Page ID | Form Name | Text ID | Size | Associated Template |
|---------|-----------|---------|------|---------------------|
| 201 | Form:Incident_Report | 315 | 1125 B | Template:Incident_Report |
| 202 | Form:Complaint_Log | 316 | 1275 B | Template:Complaint_Log |
| 203 | Form:Food_Traceability_Record | 317 | 1128 B | Template:Food_Traceability_Record |
| 204 | Form:Recall_Notification | 318 | 1181 B | Template:Recall_Notification |
| 205 | Form:Corrective_Action_Plan | 319 | 1127 B | Template:Corrective_Action_Plan |
| 206 | Form:Regulatory_Report | 320 | 1365 B | Template:Regulatory_Report |
| 207 | Form:Root_Cause_Analysis | 321 | 1295 B | Template:Root_Cause_Analysis |
| 208 | Form:Investigation_Log | 322 | 1216 B | Template:Investigation_Log |

---

## Execution Commands

### Deploy the SQL Script
```bash
cd /Users/georgemagnuson/Documents/GitHub/FCP_DCC
psql -U postgres -d mediawiki -h 192.168.2.30 < red_troubleshooting_section.sql
# Password: rash4z4m!
```

### Or with PGPASSWORD environment variable
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 < red_troubleshooting_section.sql
```

### Verify Deployment (count pages)
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) as page_count FROM mediawiki.page WHERE page_id BETWEEN 189 AND 208;"
# Expected result: 20
```

### Verify All Pages Created (list details)
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT page_id, page_namespace, page_title, page_len FROM mediawiki.page WHERE page_id BETWEEN 189 AND 208 ORDER BY page_id;"
```

### Verify Text Entries
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) as text_count FROM mediawiki.text WHERE old_id BETWEEN 303 AND 322;"
# Expected result: 20
```

### Verify Revisions
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 \
  -c "SELECT COUNT(*) as revision_count FROM mediawiki.revision WHERE rev_id BETWEEN 1078 AND 1097;"
# Expected result: 20
```

---

## Form Field Reference

### Form 1: Incident_Report
**Purpose:** Document incidents and immediate response actions
- Date/time of incident (datetime-local)
- Incident type (dropdown: Food safety, Equipment failure, Personnel injury, Customer incident, Contamination, Other)
- Location/area affected (text)
- Description (textarea)
- Staff member involved (text)
- Immediate actions taken (textarea)
- Severity level (dropdown: Low, Medium, High, Critical)
- Management notified (select: Yes/No)

### Form 2: Complaint_Log
**Purpose:** Track and resolve customer complaints
- Date received (date)
- Customer name (text)
- Complaint type (dropdown: Food quality, Food safety, Service quality, Allergen concern, Illness report, Contamination, Foreign object, Other)
- Product/service involved (text)
- Description (textarea)
- Investigation status (dropdown: Not started, In progress, Completed)
- Resolution action (textarea)
- Status (dropdown: Open, In progress, Resolved, Closed)

### Form 3: Food_Traceability_Record
**Purpose:** Maintain supplier and batch tracking for recalls
- Product name (text)
- Batch/lot number (text)
- Supplier name (text)
- Delivery date (date)
- Storage location (text)
- Date product used/prepared (date)
- Distributed to (textarea)
- Quantity distributed (number)
- Unit of measure (dropdown: Kg, Litres, Units, Portions)

### Form 4: Recall_Notification
**Purpose:** Product recall documentation and tracking
- Recall date (date)
- Product identification (text)
- Batch/lot numbers affected (textarea)
- Reason for recall (dropdown: Contamination, Allergen not declared, Foreign object, Pathogen detected, Spoilage, Labelling error, Other)
- Health risk level (dropdown: Low, Medium, High)
- Quantity distributed (number)
- Quantity recovered (number)
- Recall status (dropdown: Active, In progress, Completed, Closed)

### Form 5: Corrective_Action_Plan
**Purpose:** Document corrective actions for incidents and non-conformances
- Date issued (date)
- Issue description (textarea)
- Root cause identified (textarea)
- Corrective action required (textarea)
- Action owner (text)
- Target completion date (date)
- Priority level (dropdown: Low, Medium, High, Urgent)
- Status (dropdown: Planned, In progress, Completed, Verified, Closed)

### Form 6: Regulatory_Report
**Purpose:** Track regulatory notifications and official reporting
- Report date (date)
- Regulatory body (dropdown: MPI, Local Council, Regional Health, WorkSafe NZ, Other)
- Report type (dropdown: Incident notification, Recall notification, Complaint notification, Routine report, Audit response, Other)
- Incident/issue reference (text)
- Reported by (text)
- Notification method (dropdown: Online portal, Email, Phone, Letter, In-person)
- Acknowledgment received (select: Yes/No)
- Reference number (text)
- Status (dropdown: Submitted, Acknowledged, Under review, Resolved, Closed)

### Form 7: Root_Cause_Analysis
**Purpose:** Systematic investigation of incidents and non-conformances
- Analysis date (date)
- Incident/issue reference (text)
- Problem statement (textarea)
- Root cause identified (textarea)
- Contributing factors (textarea)
- Supporting evidence (textarea)
- Analysis method (dropdown: 5 Whys, Fishbone diagram, Fault tree analysis, Pareto analysis, Timeline analysis, Other)
- Recommended actions (textarea)
- Status (dropdown: Draft, Under review, Approved, Implemented)

### Form 8: Investigation_Log
**Purpose:** Track investigation activities and findings
- Investigation number (text)
- Start date (date)
- Incident/complaint reference (text)
- Lead investigator (text)
- Investigation scope (textarea)
- Interviews conducted (textarea)
- Documents reviewed (textarea)
- Investigation findings (textarea)
- Status (dropdown: Active, In progress, Report draft, Report final, Closed)

---

## Database Statistics

| Metric | Value |
|--------|-------|
| Total Pages | 20 |
| Content Pages | 4 |
| Form Templates | 8 |
| Form Pages | 8 |
| Text Entries | 20 |
| Revision Records | 20 |
| Slot Entries | 20 |
| Total Insert Statements | 100 |
| Content Size | ~29.6 KB |

---

## Troubleshooting

### Pages not showing in MediaWiki UI after deployment
1. Clear the MediaWiki cache:
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
cd /usr/local/www/mediawiki
php maintenance/purgeList.php --db-touch
php maintenance/runJobs.php
```

2. Try accessing directly: `http://mediawiki.local/wiki/Form:Incident_Report`

### Forms not displaying correctly
- Verify PageForms extension is installed and enabled
- Check that Template: pages exist and are properly formatted
- Try accessing the Template page directly to verify content

### Database connection issues
- Verify credentials: User `postgres`, Host `192.168.2.30`
- Test connection: `psql -U postgres -d mediawiki -h 192.168.2.30`
- Ensure firewall allows connection to port 5432

---

## Success Criteria - Post Deployment

✅ All 20 pages created with correct IDs (189-208)
✅ 4 content pages display Know/Do/Show sections
✅ 8 form templates render as wikitable structures
✅ 8 form pages accept form submissions
✅ Categories properly assigned (Red:Troubleshooting)
✅ All verification queries pass
✅ MediaWiki UI accessible and responsive
