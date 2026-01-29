# Red (Troubleshooting) Section - Detailed Structure & Specifications

**Generated:** 2026-01-29
**Project:** FCP_DCC (Food Compliance Protocol - Digital Content Conversion)
**Section:** Red (Troubleshooting) - Pages 189-208
**Status:** Production Ready

---

## Table of Contents

1. [Content Pages Wikitext](#content-pages-wikitext)
2. [Form Template Specifications](#form-template-specifications)
3. [Form Page Definitions](#form-page-definitions)
4. [Database Integration](#database-integration)
5. [Deployment Checklist](#deployment-checklist)

---

## Content Pages Wikitext

### PAGE 189: FCP:Troubleshooting:Something_goes_wrong

**Namespace:** 0 (Main)
**Page Type:** Content/Information
**Word Count:** ~1,200 words
**Subsections:** 3 (Know, Do, Show)

#### Structure

**Know Section** - Core Concepts (650 words):
- Premise that incidents are inevitable in food operations
- Importance of systematic incident management
- Documentation and rapid response procedures
- Classification systems (by severity level)
- Staff awareness and training needs
- Turning incidents into learning opportunities

**Do Section** - Action Procedures (400 words):
- Establish incident response team
- Create reporting procedures
- Classify incidents by severity (Low/Medium/High/Critical)
- Define response protocols for each level
- Documentation requirements
- Evidence preservation procedures
- Customer communication guidelines
- Regulatory authority contact procedures
- Post-incident review and improvement

**Show Section** - Evidence Requirements (150 words):
- Incident reporting procedures (written)
- Incident register/log with classifications
- Documentation of immediate response actions
- Corrective action records
- Staff training documentation
- Management meeting minutes discussing incidents
- Regulatory notification records

---

### PAGE 190: FCP:Troubleshooting:Dealing_complaints

**Namespace:** 0 (Main)
**Page Type:** Content/Information
**Word Count:** ~1,100 words
**Subsections:** 3 (Know, Do, Show)

#### Structure

**Know Section** - Core Concepts (550 words):
- Complaints as valuable feedback
- Importance of taking all complaints seriously
- Professional and prompt response benefits
- Different complaint categories (quality, safety, service)
- Documentation and legal requirements
- Staff training necessity
- Transparent investigation importance
- Complaints reveal systemic problems
- System improvement from complaint analysis

**Do Section** - Action Procedures (380 words):
- Staff training on professional complaint receipt
- Active listening procedures
- Immediate documentation protocols
- Customer contact and explanation procedures
- Compensation guidelines
- Food safety complaint escalation
- Investigation procedures
- Root cause analysis
- Corrective action implementation
- Customer follow-up communication
- Complaint pattern identification
- Management review procedures
- Regulatory reporting for serious complaints

**Show Section** - Evidence Requirements (170 words):
- Complaint log/register
- Investigation documentation
- Root cause analysis reports
- Corrective action records
- Customer communication records
- Regulatory notification letters
- Staff training documentation
- Management review meeting minutes

---

### PAGE 191: FCP:Troubleshooting:Tracing_food

**Namespace:** 0 (Main)
**Page Type:** Content/Information
**Word Count:** ~1,050 words
**Subsections:** 3 (Know, Do, Show)

#### Structure

**Know Section** - Core Concepts (550 words):
- Foundation of rapid incident response
- Speed requirements for product recalls
- Backward and forward traceability definitions
- Complete documentation requirements
- Batch/lot number critical importance
- Prevention of over-cautious recalls
- Record retention timeframes
- Regular system testing requirements
- Variations by product type

**Do Section** - Action Procedures (350 words):
- Establish unique product identification system
- Batch/lot number recording procedures
- Storage location documentation
- Product usage/preparation documentation
- Prepared food linking to ingredients
- Supplier list maintenance and updates
- Customer list maintenance (particularly food service)
- Regular traceability testing procedures
- High-risk product prioritization
- Record retention and accessibility
- Annual system review
- Staff training on traceability
- Supplier and customer communication

**Show Section** - Evidence Requirements (150 words):
- Supplier records with contact information
- Customer records (especially food service)
- Product receipt documentation with batch numbers
- Daily usage records and linkages
- Traceability test results and dates
- Traceability system procedure documentation
- Staff training records
- Annual system review documents

---

### PAGE 192: FCP:Troubleshooting:Recalling_food

**Namespace:** 0 (Main)
**Page Type:** Content/Information
**Word Count:** ~1,100 words
**Subsections:** 3 (Know, Do, Show)

#### Structure

**Know Section** - Core Concepts (600 words):
- Recall definition and necessity
- Voluntary vs mandatory recalls
- Dependence on traceability system
- Recall classification (Class 1, 2, 3)
- Regulatory authority notification requirements
- Transparency importance
- Media event preparation and management
- Staff coordination in emergencies
- Post-recall investigation and improvement

**Do Section** - Action Procedures (380 words):
- Recall identification procedures
- Recall classification assessment
- Immediate management notification
- Regulatory authority contact
- Traceability system deployment
- Affected batch/lot identification
- Customer identification and location
- Recall notification preparation
- Customer contact via appropriate channels
- Retail partner and distributor notification
- Recovery tracking and documentation
- Detailed record keeping throughout
- Product destruction documentation
- Formal recall report generation
- Lessons learned dissemination
- Root cause analysis
- Preventive action implementation

**Show Section** - Evidence Requirements (120 words):
- Recall notification communication
- Customer contact lists and methods
- Contact timestamps and logs
- Product recovery records
- Recovery vs distribution statistics
- Formal recall report documentation
- Root cause analysis findings
- Corrective action implementation records
- Regulatory authority communication
- Staff communication and training records

---

## Form Template Specifications

### Template Design Patterns

All templates follow this structure:
```
<noinclude>
  [Brief description]
</noinclude>

{| class="wikitable"
|-
! Field Names
...
|-
| {{{placeholder|}}} style parameters
...
|}

__NOTOC__
```

### PAGE 193: Template:Incident_Report

**Purpose:** Display incident data in tabular format
**Table Fields (8):**
1. date_time - When incident occurred
2. incident_type - Category of incident
3. location - Where it happened
4. description - What happened
5. staff_involved - Who was involved
6. immediate_actions - What was done immediately
7. severity - How serious (Low/Medium/High/Critical)
8. management_notified - Yes/No

**MediaWiki Markup:**
- Table class: wikitable
- 8 columns, 1 data row template
- Parameter placeholders with `{{{field|}}}`

---

### PAGE 194: Template:Complaint_Log

**Purpose:** Display complaint data in standardized format
**Table Fields (8):**
1. date_received - When complaint was received
2. customer_name - Customer/complainant name
3. complaint_type - Category of complaint
4. product_service - What the complaint was about
5. description - Details of complaint
6. investigation_status - Progress of investigation
7. resolution - What action was taken
8. status - Current complaint status

---

### PAGE 195: Template:Food_Traceability_Record

**Purpose:** Display product tracking information
**Table Fields (8):**
1. product_name - Name of product
2. batch_lot - Batch or lot identifier
3. supplier - Supplier name
4. delivery_date - When received
5. storage_location - Where stored
6. usage_date - When product was used
7. distributed_to - Customers/areas it went to
8. quantity_distributed - How much distributed

---

### PAGE 196: Template:Recall_Notification

**Purpose:** Display recall event information
**Table Fields (8):**
1. recall_date - When recall initiated
2. product_id - Product identification
3. batch_lots - Affected batch/lot numbers
4. recall_reason - Why recall was issued
5. risk_level - Health risk severity
6. quantity_distributed - How much was distributed
7. quantity_recovered - How much was recovered
8. recall_status - Current status of recall

---

### PAGE 197: Template:Corrective_Action_Plan

**Purpose:** Display corrective action tracking
**Table Fields (8):**
1. date - Date plan was created
2. issue_description - What problem needs fixing
3. root_cause - Why the problem occurred
4. corrective_action - What action will be taken
5. action_owner - Who is responsible
6. target_completion - When it should be done
7. priority - Urgency level
8. status - Current progress status

---

### PAGE 198: Template:Regulatory_Report

**Purpose:** Display regulatory notification records
**Table Fields (8):**
1. report_date - When report was sent
2. regulatory_body - Which authority
3. report_type - Type of notification
4. incident_reference - Related incident ID
5. notification_method - How it was sent
6. acknowledgment_received - Yes/No confirmation
7. reference_number - Regulatory reference number
8. status - Current status with authority

---

### PAGE 199: Template:Root_Cause_Analysis

**Purpose:** Display root cause investigation results
**Table Fields (8):**
1. analysis_date - When analysis was conducted
2. incident_reference - What incident triggered this
3. problem_statement - Description of problem
4. root_cause - Underlying cause identified
5. contributing_factors - Other contributing factors
6. evidence - Supporting evidence
7. recommended_actions - What should be done
8. status - Progress of implementation

---

### PAGE 200: Template:Investigation_Log

**Purpose:** Display investigation tracking information
**Table Fields (8):**
1. investigation_number - Investigation ID
2. start_date - Investigation start date
3. incident_reference - What incident is being investigated
4. lead_investigator - Who is leading
5. investigation_scope - What is being investigated
6. interviews_conducted - Who was interviewed
7. documents_reviewed - What was reviewed
8. findings - What was discovered

---

## Form Page Definitions

### Form Page Design Pattern

All form pages follow this structure:
```
<form>
{{{for template|TemplateName}}}

|-
! Label:
| <input type="type" name="field" attributes />

...

{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Specific_Category]]
```

---

### PAGE 201: Form:Incident_Report

**Associated Template:** Template:Incident_Report
**Purpose:** Collect incident report information
**Form Type:** structured data entry
**Fields (8):**

1. **Date and Time of Incident**
   - Type: datetime-local
   - Required: Yes
   - Placeholder: None

2. **Incident Type**
   - Type: select dropdown
   - Options: Food safety | Equipment failure | Personnel injury | Customer incident | Contamination | Other
   - Default: (blank)

3. **Location/Area Affected**
   - Type: text input
   - Size: 40 characters
   - Placeholder: None

4. **Description of Incident**
   - Type: textarea
   - Rows: 4
   - Columns: 50

5. **Staff Member Involved**
   - Type: text input
   - Size: 40 characters

6. **Immediate Actions Taken**
   - Type: textarea
   - Rows: 3
   - Columns: 50

7. **Severity Level**
   - Type: select dropdown
   - Options: Low | Medium | High | Critical

8. **Management Notified**
   - Type: select dropdown
   - Options: Yes | No

**Categories:** `Red:Troubleshooting`, `Incident_Reports`
**Size:** 1,125 bytes

---

### PAGE 202: Form:Complaint_Log

**Associated Template:** Template:Complaint_Log
**Purpose:** Collect customer complaint information
**Form Type:** structured data entry
**Fields (8):**

1. **Date Received** - date input
2. **Customer Name** - text input (40 chars)
3. **Complaint Type** - dropdown (8 options: Food quality, Food safety, Service quality, Allergen concern, Illness report, Contamination, Foreign object, Other)
4. **Product/Service Involved** - text input (40 chars)
5. **Description of Complaint** - textarea (4x50)
6. **Investigation Status** - dropdown (Not started, In progress, Completed)
7. **Resolution Action Taken** - textarea (3x50)
8. **Status** - dropdown (Open, In progress, Resolved, Closed)

**Categories:** `Red:Troubleshooting`, `Complaint_Logs`
**Size:** 1,275 bytes

---

### PAGE 203: Form:Food_Traceability_Record

**Associated Template:** Template:Food_Traceability_Record
**Purpose:** Collect product traceability information
**Form Type:** structured data entry
**Fields (9):**

1. **Product Name** - text input (40 chars)
2. **Batch/Lot Number** - text input (30 chars)
3. **Supplier Name** - text input (40 chars)
4. **Delivery Date** - date input
5. **Storage Location** - text input (40 chars)
6. **Date Product Used/Prepared** - date input
7. **Distributed To (Customer/Area)** - textarea (2x50)
8. **Quantity Distributed** - number input (step=0.01)
9. **Unit of Measure** - dropdown (Kg, Litres, Units, Portions)

**Categories:** `Red:Troubleshooting`, `Traceability_Records`
**Size:** 1,128 bytes

---

### PAGE 204: Form:Recall_Notification

**Associated Template:** Template:Recall_Notification
**Purpose:** Collect product recall information
**Form Type:** structured data entry
**Fields (8):**

1. **Recall Date** - date input
2. **Product Identification** - text input (40 chars)
3. **Batch/Lot Numbers Affected** - textarea (2x50)
4. **Reason for Recall** - dropdown (7 options: Contamination, Allergen not declared, Foreign object, Pathogen detected, Spoilage, Labelling error, Other)
5. **Health Risk Level** - dropdown (Low, Medium, High)
6. **Quantity Distributed** - number input (step=0.01)
7. **Quantity Recovered** - number input (step=0.01)
8. **Recall Status** - dropdown (Active, In progress, Completed, Closed)

**Categories:** `Red:Troubleshooting`, `Recall_Notifications`
**Size:** 1,181 bytes

---

### PAGE 205: Form:Corrective_Action_Plan

**Associated Template:** Template:Corrective_Action_Plan
**Purpose:** Collect corrective action information
**Form Type:** structured data entry
**Fields (8):**

1. **Date Issued** - date input
2. **Issue Description** - textarea (3x50)
3. **Root Cause Identified** - textarea (3x50)
4. **Corrective Action Required** - textarea (3x50)
5. **Action Owner** - text input (40 chars)
6. **Target Completion Date** - date input
7. **Priority Level** - dropdown (Low, Medium, High, Urgent)
8. **Status** - dropdown (Planned, In progress, Completed, Verified, Closed)

**Categories:** `Red:Troubleshooting`, `Corrective_Actions`
**Size:** 1,127 bytes

---

### PAGE 206: Form:Regulatory_Report

**Associated Template:** Template:Regulatory_Report
**Purpose:** Collect regulatory notification information
**Form Type:** structured data entry
**Fields (9):**

1. **Report Date** - date input
2. **Regulatory Body** - dropdown (5 options: MPI - Ministry for Primary Industries, Local Council, Regional Health, WorkSafe NZ, Other)
3. **Report Type** - dropdown (6 options: Incident notification, Recall notification, Complaint notification, Routine report, Audit response, Other)
4. **Incident/Issue Reference** - text input (40 chars)
5. **Reported By** - text input (40 chars)
6. **Notification Method** - dropdown (5 options: Online portal, Email, Phone, Letter, In-person)
7. **Acknowledgment Received** - select (Yes, No)
8. **Reference Number** - text input (30 chars)
9. **Status** - dropdown (5 options: Submitted, Acknowledged, Under review, Resolved, Closed)

**Categories:** `Red:Troubleshooting`, `Regulatory_Reports`
**Size:** 1,365 bytes

---

### PAGE 207: Form:Root_Cause_Analysis

**Associated Template:** Template:Root_Cause_Analysis
**Purpose:** Collect root cause analysis information
**Form Type:** structured data entry
**Fields (9):**

1. **Analysis Date** - date input
2. **Incident/Issue Reference** - text input (40 chars)
3. **Problem Statement** - textarea (3x50)
4. **Root Cause Identified** - textarea (3x50)
5. **Contributing Factors** - textarea (3x50)
6. **Supporting Evidence** - textarea (3x50)
7. **Analysis Method Used** - dropdown (6 options: 5 Whys, Fishbone diagram, Fault tree analysis, Pareto analysis, Timeline analysis, Other)
8. **Recommended Actions** - textarea (3x50)
9. **Status** - dropdown (4 options: Draft, Under review, Approved, Implemented)

**Categories:** `Red:Troubleshooting`, `Root_Cause_Analysis`
**Size:** 1,295 bytes

---

### PAGE 208: Form:Investigation_Log

**Associated Template:** Template:Investigation_Log
**Purpose:** Collect investigation tracking information
**Form Type:** structured data entry
**Fields (9):**

1. **Investigation Number** - text input (30 chars)
2. **Start Date** - date input
3. **Incident/Complaint Reference** - text input (40 chars)
4. **Lead Investigator** - text input (40 chars)
5. **Investigation Scope** - textarea (3x50)
6. **Interviews Conducted** - textarea (3x50)
7. **Documents Reviewed** - textarea (3x50)
8. **Investigation Findings** - textarea (4x50)
9. **Status** - dropdown (5 options: Active, In progress, Report draft, Report final, Closed)

**Categories:** `Red:Troubleshooting`, `Investigation_Logs`
**Size:** 1,216 bytes

---

## Database Integration

### MediaWiki Schema Mapping

#### mediawiki.text Table
```sql
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (text_id, 'page_content_here', 'utf-8');
```

| Text ID | Page Type | Content Size | Purpose |
|---------|-----------|--------------|---------|
| 303 | Content | 2,863 B | Page 189 wikitext |
| 304 | Content | 2,534 B | Page 190 wikitext |
| 305 | Content | 2,431 B | Page 191 wikitext |
| 306 | Content | 2,541 B | Page 192 wikitext |
| 307-314 | Template | 445-457 B | Template definitions |
| 315-322 | Form | 1,125-1,365 B | Form definitions |

#### mediawiki.content Table
```sql
INSERT INTO mediawiki.content
  (content_id, content_size, content_sha1, content_model, content_address)
VALUES (text_id, byte_size, '', 1, 'tt:text_id');
```

- All content_model: 1 (wikitext)
- All content_address: tt:[text_id]
- content_sha1: Empty string (as per pattern)

#### mediawiki.revision Table
```sql
INSERT INTO mediawiki.revision
  (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp,
   rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (rev_id, page_id, 1, 1, NOW(), 0, 0, byte_length, NULL, '');
```

- rev_comment_id: 1 (default)
- rev_actor: 1 (default)
- rev_timestamp: NOW() (current timestamp)
- rev_minor_edit: 0 (not minor edit)
- rev_deleted: 0 (not deleted)
- rev_parent_id: NULL (no parent revision)

#### mediawiki.slots Table
```sql
INSERT INTO mediawiki.slots
  (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (rev_id, 1, text_id, rev_id);
```

- slot_role_id: 1 (main role)
- slot_origin: rev_id (self-reference for new pages)

#### mediawiki.page Table
```sql
INSERT INTO mediawiki.page
  (page_id, page_namespace, page_title, page_is_redirect, page_is_new,
   page_random, page_touched, page_latest, page_len)
VALUES (page_id, namespace, 'Page_Title', 0, 1,
        RANDOM(), NOW(), rev_id, byte_length);
```

- page_namespace: 0 (main) or 10 (template)
- page_is_redirect: 0 (not a redirect)
- page_is_new: 1 (new page)
- page_random: RANDOM() function
- page_touched: NOW() (current timestamp)
- page_latest: rev_id (latest revision)

---

## Category Structure

### Primary Category
All pages use:
```
[[Category:Red:Troubleshooting]]
```

### Secondary Categories by Type

**Content Pages:**
- Page 189: (No secondary, only primary)
- Page 190: (No secondary, only primary)
- Page 191: (No secondary, only primary)
- Page 192: (No secondary, only primary)

**Form Pages:**
- Page 201: `[[Category:Incident_Reports]]`
- Page 202: `[[Category:Complaint_Logs]]`
- Page 203: `[[Category:Traceability_Records]]`
- Page 204: `[[Category:Recall_Notifications]]`
- Page 205: `[[Category:Corrective_Actions]]`
- Page 206: `[[Category:Regulatory_Reports]]`
- Page 207: `[[Category:Root_Cause_Analysis]]`
- Page 208: `[[Category:Investigation_Logs]]`

**Forms Category (all forms):**
```
[[Category:Forms]]
```

---

## Deployment Checklist

### Pre-Deployment
- [ ] SQL script syntax verified
- [ ] All byte sizes pre-calculated
- [ ] ID ranges confirmed (189-208, 303-322, 1078-1097)
- [ ] Database backup created
- [ ] Test environment validated

### Deployment
- [ ] Connect to PostgreSQL: `psql -U postgres -d mediawiki -h 192.168.2.30`
- [ ] Execute SQL script
- [ ] Verify transaction committed successfully
- [ ] Check PostgreSQL logs for errors

### Post-Deployment Verification
- [ ] Count pages: Should be 20
- [ ] Count text entries: Should be 20
- [ ] Count revisions: Should be 20
- [ ] Verify namespace distribution (12 namespace 0, 8 namespace 10)
- [ ] Spot-check page content in database

### MediaWiki UI Verification
- [ ] Access content pages (189-192)
- [ ] Verify Know/Do/Show sections display correctly
- [ ] Access form pages (201-208)
- [ ] Verify forms display with proper fields
- [ ] Test form submission on one form
- [ ] Verify categories are linkable
- [ ] Check search indexing

### Cache Management
- [ ] Clear MediaWiki cache
- [ ] Run maintenance jobs
- [ ] Verify UI responsiveness

### Final Verification
- [ ] All 20 pages accessible in MediaWiki UI
- [ ] All forms submit successfully
- [ ] Data displays correctly in templates
- [ ] No database errors in logs
- [ ] Documentation updated with completion date

---

## Support & Troubleshooting

**SQL Execution Issues:**
1. Check database connectivity
2. Verify credentials
3. Review error message in detail
4. Check PostgreSQL logs

**Data Display Issues:**
1. Clear MediaWiki cache
2. Verify template names match form references
3. Check category syntax
4. Test individual page loading

**Form Submission Issues:**
1. Verify PageForms extension installed
2. Check template exists and is accessible
3. Review form definition syntax
4. Test template rendering separately

---

**Document Version:** 1.0
**Last Updated:** 2026-01-29
**Status:** Production Ready
