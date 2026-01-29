-- Red (Troubleshooting) Section - 20 Pages Total
-- 4 Content Pages (189-192) + 8 Templates (193-200 namespace 10) + 8 Forms (201-208 namespace 0)
-- Text IDs: 303-322 (20 entries)
-- Revision IDs: 1078-1097 (20 entries)
-- Categories: Red:Troubleshooting

BEGIN;

-- ============================================================================
-- CONTENT PAGES (4 pages, IDs 189-192)
-- ============================================================================

-- ============================================================================
-- PAGE 189: FCP:Troubleshooting:Something_goes_wrong (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (303, 'FCP:Troubleshooting:Something_goes_wrong

== Know ==
* Something will inevitably go wrong in food service operations - equipment will fail, staff will make mistakes, accidents happen, and customer issues arise
* A systematic approach to incident management prevents small problems from becoming major food safety incidents
* Rapid response and documentation are crucial for food safety compliance and protecting customers
* Different types of incidents require different response protocols - equipment failure is handled differently from a customer complaint or contamination event
* All staff need to know what to do immediately when an incident occurs
* Incident severity ranges from minor operational issues to critical food safety threats
* Transparent incident management builds customer trust and demonstrates compliance commitment
* Every incident is an opportunity to identify and prevent similar future incidents through root cause analysis

== Do ==
* Establish an incident response team with clear roles and responsibilities
* Create an incident reporting procedure that all staff understand and follow
* Ensure all staff know how to report incidents immediately to management
* Classify incidents by severity: Low (minor issues), Medium (operational impacts), High (food safety risk), Critical (immediate health threat)
* For Critical incidents: Immediately stop operations in affected area, notify management, isolate affected product, assess customer impact
* For High incidents: Notify management within 30 minutes, assess scope, begin investigation, notify customers if needed
* For Medium incidents: Log in incident register, notify supervisor, investigate root cause
* For Low incidents: Log in incident register, address cause, monitor for recurrence
* Document all incidents with date, time, description, immediate actions taken, and person reporting
* Preserve evidence (equipment samples, remaining product, photos) for investigation
* Communicate transparently with affected customers - early notification builds trust
* Contact regulatory authorities for incidents involving potential food safety risks
* Review all incidents in team meetings to identify patterns and prevention opportunities
* Implement corrective actions to prevent incident recurrence

== Show ==
* Incident reporting procedures posted in work areas
* Incident register showing all reported incidents with classification, response actions, and outcomes
* Evidence of immediate response to critical incidents (communication logs, timestamps)
* Documentation of corrective actions implemented
* Staff training records on incident response procedures
* Management review meeting minutes discussing incidents and prevention measures
* Evidence of regulatory authority notifications where required', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (303, 2863, '', 1, 'tt:303');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1078, 189, 1, 1, NOW(), 0, 0, 2863, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1078, 1, 303, 1078);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (189, 0, 'FCP:Troubleshooting:Something_goes_wrong', 0, 1, RANDOM(), NOW(), 1078, 2863);

-- ============================================================================
-- PAGE 190: FCP:Troubleshooting:Dealing_complaints (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (304, 'FCP:Troubleshooting:Dealing_complaints

== Know ==
* Customer complaints are valuable information about food safety performance - they highlight issues that internal checks may have missed
* All complaints must be taken seriously regardless of how minor they seem, as they may indicate a food safety problem
* Prompt and professional complaint handling protects customer health, builds customer loyalty, and demonstrates compliance
* Complaints can reveal systemic problems - multiple similar complaints indicate a process failure that needs fixing
* Different complaint types require different responses: food quality issues, food safety concerns, allergen issues, service quality
* Documentation of all complaints and responses is a regulatory requirement and essential for trend identification
* Staff need training to receive complaints professionally without being defensive
* Transparent investigation and honest communication about actions taken build customer trust
* Some complaints may require regulatory authority notification if they involve food safety risks
* Complaint investigation should determine root cause to enable effective corrective action

== Do ==
* Train all customer-facing staff to receive complaints professionally and with empathy
* Listen to the full complaint without interruption or defensiveness
* Record complaint details immediately: date received, time, customer name, contact details, person receiving complaint
* Thank the customer for reporting the issue
* Ask clarifying questions to understand exactly what happened (product name, date purchased/served, symptoms, etc.)
* Advise customer what immediate actions you will take (investigation, follow-up contact, etc.)
* Provide reasonable compensation if appropriate (replacement product, refund, sincere apology)
* For food safety complaints (illness, contamination, foreign objects), escalate to management immediately
* Investigate complaint promptly - preserve product samples and evidence
* Determine root cause through systematic investigation
* Implement corrective actions to prevent recurrence
* Follow up with customer within agreed timeframe with investigation results
* Document customer feedback and satisfaction with resolution
* Review complaint patterns in management meetings
* Report food safety complaints to regulatory authorities if customer health at risk
* Implement system improvements based on complaint trends

== Show ==
* Complaint log showing all received complaints with dates, details, and outcomes
* Records of customer contact and investigation process
* Evidence of root cause analysis for each complaint
* Documentation of corrective actions taken
* Evidence of customer follow-up communication
* Records of regulatory notifications (if applicable)
* Staff training on complaint handling procedures
* Management meeting minutes discussing complaint trends and improvements', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (304, 2534, '', 1, 'tt:304');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1079, 190, 1, 1, NOW(), 0, 0, 2534, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1079, 1, 304, 1079);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (190, 0, 'FCP:Troubleshooting:Dealing_complaints', 0, 1, RANDOM(), NOW(), 1079, 2534);

-- ============================================================================
-- PAGE 191: FCP:Troubleshooting:Tracing_food (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (305, 'FCP:Troubleshooting:Tracing_food

== Know ==
* Effective food traceability is the foundation of being able to respond quickly to food safety incidents
* You must be able to trace food back to suppliers and forward to customers within hours to contain a potential food safety issue
* Traceability breaks down into two directions: backward traceability (where did product come from) and forward traceability (where did it go)
* Complete traceability requires documentation of every product movement: from supplier, through storage, through preparation, to customer
* Batch/lot numbers are essential for targeted recalls - without them you may have to recall all product made that day
* Poor traceability can result in over-cautious recalls affecting more customers and product than necessary
* Traceability records must be maintained for the shelf-life of the product plus a safety margin
* Regular traceability testing (periodic checks that you can actually trace a product through the system) ensures your system works
* Different product types may require different traceability approaches (fresh items need faster tracking, dry goods may use longer cycles)

== Do ==
* Establish a unique identification system for all products received: record batch/lot numbers, supplier, delivery date, quantity
* Maintain clear storage location records - know exactly where product is stored
* When product is used or sold, record when it was used, which customers received it, what happened to unused portions
* For prepared food, link the finished product to all ingredient batches used
* Maintain a current supplier list with contact information
* Maintain a current customer list (for retail this is less detailed, but for food service you need exact information)
* Regularly test your traceability system by selecting a product and tracing it both directions
* For high-risk products, test traceability more frequently
* Document traceability test results
* Keep records for appropriate timeframe (minimum shelf-life plus 6 months for food safety products)
* Make records easily accessible for rapid retrieval in an emergency
* Review and update traceability system annually or when operations change
* Train all staff on traceability procedures

== Show ==
* Supplier records with names, contacts, and products supplied
* Customer records (especially food service customers)
* Product receipt and storage records showing batch/lot numbers
* Daily usage records linking product to customers or preparation activities
* Records of traceability testing conducted (date, product tested, result)
* Procedure documentation for your traceability system
* Staff training records on traceability procedures', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (305, 2431, '', 1, 'tt:305');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1080, 191, 1, 1, NOW(), 0, 0, 2431, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1080, 1, 305, 1080);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (191, 0, 'FCP:Troubleshooting:Tracing_food', 0, 1, RANDOM(), NOW(), 1080, 2431);

-- ============================================================================
-- PAGE 192: FCP:Troubleshooting:Recalling_food (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (306, 'FCP:Troubleshooting:Recalling_food

== Know ==
* A product recall is a serious but necessary action to protect customer health when a food safety risk is identified
* Recalls can be voluntary (initiated by business) or mandatory (required by regulatory authority)
* The speed and effectiveness of a recall depends entirely on how good your traceability system is
* There are three levels of recall: Class 1 (serious health threat requiring immediate action), Class 2 (potential health threat), Class 3 (unlikely to cause health threat)
* Regulatory authorities must be notified of recalls involving health risks
* Transparency during a recall is essential - customers and the public must trust your response
* Recalls are expensive and disruptive, but failing to recall contaminated product is far worse
* Some recalls turn into significant media events - being prepared and transparent protects your reputation
* All staff need to know what to do during a recall - it requires coordinated action
* After a recall, you must investigate what happened and implement corrective actions to prevent recurrence

== Do ==
* Identify clearly when a recall is needed: when you discover product that may have a food safety hazard
* Classify the recall appropriately by severity: assess the health risk level
* Notify management and regulatory authority immediately for Class 1 recalls
* For Class 2/3 recalls, contact regulatory authority for guidance
* Use your traceability system to identify exactly which batches/lots are affected
* Determine where the product was distributed using your customer records
* Prepare a recall notification message that clearly identifies the product and explains the issue
* Contact all customers who received the product (phone, email, letter, social media as appropriate)
* Instruct customers what to do with the product (return, dispose, storage precautions)
* Simultaneously notify retail partners and the public if product was sold through multiple channels
* Track how much product is recovered
* Keep detailed records of all recall activities and communications
* After product is recovered and destroyed, document completion
* Complete a formal recall report documenting what happened, why, and how you prevented future occurrences
* Share lessons learned with staff
* Conduct root cause analysis and implement corrective actions

== Show ==
* Recall notification letter/email demonstrating clear communication
* List of customers/distributors contacted with dates and methods
* Records of product recovery and destruction
* Documentation of quantity distributed vs. quantity recovered
* Formal recall report documenting the incident
* Root cause analysis and corrective actions
* Evidence of regulatory authority communication and approval
* Staff communication about the incident and lessons learned', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (306, 2541, '', 1, 'tt:306');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1081, 192, 1, 1, NOW(), 0, 0, 2541, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1081, 1, 306, 1081);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (192, 0, 'FCP:Troubleshooting:Recalling_food', 0, 1, RANDOM(), NOW(), 1081, 2541);

-- ============================================================================
-- FORM TEMPLATES (8 templates, IDs 193-200, namespace 10)
-- ============================================================================

-- ============================================================================
-- PAGE 193: Template:Incident_Report (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (307, '<noinclude>
This is a template for the Incident Report form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Incident Type
! Location
! Description
! Staff Involved
! Immediate Actions
! Severity
! Management Notified
|-
| {{{date_time|}}}
| {{{incident_type|}}}
| {{{location|}}}
| {{{description|}}}
| {{{staff_involved|}}}
| {{{immediate_actions|}}}
| {{{severity|}}}
| {{{management_notified|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (307, 445, '', 1, 'tt:307');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1082, 193, 1, 1, NOW(), 0, 0, 445, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1082, 1, 307, 1082);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (193, 10, 'Template:Incident_Report', 0, 1, RANDOM(), NOW(), 1082, 445);

-- ============================================================================
-- PAGE 194: Template:Complaint_Log (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (308, '<noinclude>
This is a template for the Complaint Log form.
</noinclude>

{| class="wikitable"
|-
! Date Received
! Customer Name
! Complaint Type
! Product/Service
! Description
! Investigation Status
! Resolution
! Status
|-
| {{{date_received|}}}
| {{{customer_name|}}}
| {{{complaint_type|}}}
| {{{product_service|}}}
| {{{description|}}}
| {{{investigation_status|}}}
| {{{resolution|}}}
| {{{status|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (308, 428, '', 1, 'tt:308');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1083, 194, 1, 1, NOW(), 0, 0, 428, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1083, 1, 308, 1083);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (194, 10, 'Template:Complaint_Log', 0, 1, RANDOM(), NOW(), 1083, 428);

-- ============================================================================
-- PAGE 195: Template:Food_Traceability_Record (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (309, '<noinclude>
This is a template for the Food Traceability Record form.
</noinclude>

{| class="wikitable"
|-
! Product Name
! Batch/Lot Number
! Supplier
! Delivery Date
! Storage Location
! Usage Date
! Distributed To
! Quantity Distributed
|-
| {{{product_name|}}}
| {{{batch_lot|}}}
| {{{supplier|}}}
| {{{delivery_date|}}}
| {{{storage_location|}}}
| {{{usage_date|}}}
| {{{distributed_to|}}}
| {{{quantity_distributed|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (309, 452, '', 1, 'tt:309');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1084, 195, 1, 1, NOW(), 0, 0, 452, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1084, 1, 309, 1084);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (195, 10, 'Template:Food_Traceability_Record', 0, 1, RANDOM(), NOW(), 1084, 452);

-- ============================================================================
-- PAGE 196: Template:Recall_Notification (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (310, '<noinclude>
This is a template for the Recall Notification form.
</noinclude>

{| class="wikitable"
|-
! Recall Date
! Product Identification
! Batch/Lot Numbers
! Reason for Recall
! Health Risk Level
! Quantity Distributed
! Quantity Recovered
! Recall Status
|-
| {{{recall_date|}}}
| {{{product_id|}}}
| {{{batch_lots|}}}
| {{{recall_reason|}}}
| {{{risk_level|}}}
| {{{quantity_distributed|}}}
| {{{quantity_recovered|}}}
| {{{recall_status|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (310, 457, '', 1, 'tt:310');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1085, 196, 1, 1, NOW(), 0, 0, 457, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1085, 1, 310, 1085);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (196, 10, 'Template:Recall_Notification', 0, 1, RANDOM(), NOW(), 1085, 457);

-- ============================================================================
-- PAGE 197: Template:Corrective_Action_Plan (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (311, '<noinclude>
This is a template for the Corrective Action Plan form.
</noinclude>

{| class="wikitable"
|-
! Date
! Issue Description
! Root Cause
! Corrective Action
! Action Owner
! Target Completion
! Priority
! Status
|-
| {{{date|}}}
| {{{issue_description|}}}
| {{{root_cause|}}}
| {{{corrective_action|}}}
| {{{action_owner|}}}
| {{{target_completion|}}}
| {{{priority|}}}
| {{{status|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (311, 435, '', 1, 'tt:311');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1086, 197, 1, 1, NOW(), 0, 0, 435, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1086, 1, 311, 1086);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (197, 10, 'Template:Corrective_Action_Plan', 0, 1, RANDOM(), NOW(), 1086, 435);

-- ============================================================================
-- PAGE 198: Template:Regulatory_Report (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (312, '<noinclude>
This is a template for the Regulatory Report form.
</noinclude>

{| class="wikitable"
|-
! Report Date
! Regulatory Body
! Report Type
! Incident Reference
! Notification Method
! Acknowledgment Received
! Reference Number
! Status
|-
| {{{report_date|}}}
| {{{regulatory_body|}}}
| {{{report_type|}}}
| {{{incident_reference|}}}
| {{{notification_method|}}}
| {{{acknowledgment_received|}}}
| {{{reference_number|}}}
| {{{status|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (312, 433, '', 1, 'tt:312');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1087, 198, 1, 1, NOW(), 0, 0, 433, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1087, 1, 312, 1087);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (198, 10, 'Template:Regulatory_Report', 0, 1, RANDOM(), NOW(), 1087, 433);

-- ============================================================================
-- PAGE 199: Template:Root_Cause_Analysis (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (313, '<noinclude>
This is a template for the Root Cause Analysis form.
</noinclude>

{| class="wikitable"
|-
! Analysis Date
! Incident Reference
! Problem Statement
! Root Cause Identified
! Contributing Factors
! Evidence
! Recommended Actions
! Status
|-
| {{{analysis_date|}}}
| {{{incident_reference|}}}
| {{{problem_statement|}}}
| {{{root_cause|}}}
| {{{contributing_factors|}}}
| {{{evidence|}}}
| {{{recommended_actions|}}}
| {{{status|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (313, 441, '', 1, 'tt:313');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1088, 199, 1, 1, NOW(), 0, 0, 441, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1088, 1, 313, 1088);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (199, 10, 'Template:Root_Cause_Analysis', 0, 1, RANDOM(), NOW(), 1088, 441);

-- ============================================================================
-- PAGE 200: Template:Investigation_Log (namespace 10)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (314, '<noinclude>
This is a template for the Investigation Log form.
</noinclude>

{| class="wikitable"
|-
! Investigation Number
! Start Date
! Incident Reference
! Lead Investigator
! Investigation Scope
! Interviews Conducted
! Documents Reviewed
! Findings
|-
| {{{investigation_number|}}}
| {{{start_date|}}}
| {{{incident_reference|}}}
| {{{lead_investigator|}}}
| {{{investigation_scope|}}}
| {{{interviews_conducted|}}}
| {{{documents_reviewed|}}}
| {{{findings|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (314, 444, '', 1, 'tt:314');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1089, 200, 1, 1, NOW(), 0, 0, 444, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1089, 1, 314, 1089);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (200, 10, 'Template:Investigation_Log', 0, 1, RANDOM(), NOW(), 1089, 444);

-- ============================================================================
-- FORM PAGES (8 forms, IDs 201-208, namespace 0)
-- ============================================================================

-- ============================================================================
-- PAGE 201: Form:Incident_Report (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (315, '<form>
{{{for template|Incident_Report}}}
|-
! Date and Time of Incident:
| <input type="datetime-local" name="date_time" />
|-
! Incident Type:
| <select name="incident_type"><option>Food safety</option><option>Equipment failure</option><option>Personnel injury</option><option>Customer incident</option><option>Contamination</option><option>Other</option></select>
|-
! Location/Area Affected:
| <input type="text" name="location" size="40" />
|-
! Description of Incident:
| <textarea name="description" rows="4" cols="50"></textarea>
|-
! Staff Member Involved:
| <input type="text" name="staff_involved" size="40" />
|-
! Immediate Actions Taken:
| <textarea name="immediate_actions" rows="3" cols="50"></textarea>
|-
! Severity Level:
| <select name="severity"><option>Low</option><option>Medium</option><option>High</option><option>Critical</option></select>
|-
! Management Notified:
| <select name="management_notified"><option>Yes</option><option>No</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Incident_Reports]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (315, 1125, '', 1, 'tt:315');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1090, 201, 1, 1, NOW(), 0, 0, 1125, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1090, 1, 315, 1090);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (201, 0, 'Form:Incident_Report', 0, 1, RANDOM(), NOW(), 1090, 1125);

-- ============================================================================
-- PAGE 202: Form:Complaint_Log (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (316, '<form>
{{{for template|Complaint_Log}}}
|-
! Date Received:
| <input type="date" name="date_received" />
|-
! Customer Name:
| <input type="text" name="customer_name" size="40" />
|-
! Complaint Type:
| <select name="complaint_type"><option>Food quality</option><option>Food safety</option><option>Service quality</option><option>Allergen concern</option><option>Illness report</option><option>Contamination</option><option>Foreign object</option><option>Other</option></select>
|-
! Product/Service Involved:
| <input type="text" name="product_service" size="40" />
|-
! Description of Complaint:
| <textarea name="description" rows="4" cols="50"></textarea>
|-
! Investigation Status:
| <select name="investigation_status"><option>Not started</option><option>In progress</option><option>Completed</option></select>
|-
! Resolution Action Taken:
| <textarea name="resolution" rows="3" cols="50"></textarea>
|-
! Status:
| <select name="status"><option>Open</option><option>In progress</option><option>Resolved</option><option>Closed</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Complaint_Logs]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (316, 1275, '', 1, 'tt:316');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1091, 202, 1, 1, NOW(), 0, 0, 1275, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1091, 1, 316, 1091);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (202, 0, 'Form:Complaint_Log', 0, 1, RANDOM(), NOW(), 1091, 1275);

-- ============================================================================
-- PAGE 203: Form:Food_Traceability_Record (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (317, '<form>
{{{for template|Food_Traceability_Record}}}
|-
! Product Name:
| <input type="text" name="product_name" size="40" />
|-
! Batch/Lot Number:
| <input type="text" name="batch_lot" size="30" />
|-
! Supplier Name:
| <input type="text" name="supplier" size="40" />
|-
! Delivery Date:
| <input type="date" name="delivery_date" />
|-
! Storage Location:
| <input type="text" name="storage_location" size="40" />
|-
! Date Product Used/Prepared:
| <input type="date" name="usage_date" />
|-
! Distributed To (Customer/Area):
| <textarea name="distributed_to" rows="2" cols="50"></textarea>
|-
! Quantity Distributed:
| <input type="number" name="quantity_distributed" step="0.01" />
|-
! Unit of Measure:
| <select name="unit"><option>Kg</option><option>Litres</option><option>Units</option><option>Portions</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Traceability_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (317, 1128, '', 1, 'tt:317');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1092, 203, 1, 1, NOW(), 0, 0, 1128, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1092, 1, 317, 1092);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (203, 0, 'Form:Food_Traceability_Record', 0, 1, RANDOM(), NOW(), 1092, 1128);

-- ============================================================================
-- PAGE 204: Form:Recall_Notification (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (318, '<form>
{{{for template|Recall_Notification}}}
|-
! Recall Date:
| <input type="date" name="recall_date" />
|-
! Product Identification:
| <input type="text" name="product_id" size="40" />
|-
! Batch/Lot Numbers Affected:
| <textarea name="batch_lots" rows="2" cols="50"></textarea>
|-
! Reason for Recall:
| <select name="recall_reason"><option>Contamination</option><option>Allergen not declared</option><option>Foreign object</option><option>Pathogen detected</option><option>Spoilage</option><option>Labelling error</option><option>Other</option></select>
|-
! Health Risk Level:
| <select name="risk_level"><option>Low</option><option>Medium</option><option>High</option></select>
|-
! Quantity Distributed:
| <input type="number" name="quantity_distributed" step="0.01" />
|-
! Quantity Recovered:
| <input type="number" name="quantity_recovered" step="0.01" />
|-
! Recall Status:
| <select name="recall_status"><option>Active</option><option>In progress</option><option>Completed</option><option>Closed</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Recall_Notifications]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (318, 1181, '', 1, 'tt:318');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1093, 204, 1, 1, NOW(), 0, 0, 1181, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1093, 1, 318, 1093);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (204, 0, 'Form:Recall_Notification', 0, 1, RANDOM(), NOW(), 1093, 1181);

-- ============================================================================
-- PAGE 205: Form:Corrective_Action_Plan (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (319, '<form>
{{{for template|Corrective_Action_Plan}}}
|-
! Date Issued:
| <input type="date" name="date" />
|-
! Issue Description:
| <textarea name="issue_description" rows="3" cols="50"></textarea>
|-
! Root Cause Identified:
| <textarea name="root_cause" rows="3" cols="50"></textarea>
|-
! Corrective Action Required:
| <textarea name="corrective_action" rows="3" cols="50"></textarea>
|-
! Action Owner:
| <input type="text" name="action_owner" size="40" />
|-
! Target Completion Date:
| <input type="date" name="target_completion" />
|-
! Priority Level:
| <select name="priority"><option>Low</option><option>Medium</option><option>High</option><option>Urgent</option></select>
|-
! Status:
| <select name="status"><option>Planned</option><option>In progress</option><option>Completed</option><option>Verified</option><option>Closed</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Corrective_Actions]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (319, 1127, '', 1, 'tt:319');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1094, 205, 1, 1, NOW(), 0, 0, 1127, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1094, 1, 319, 1094);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (205, 0, 'Form:Corrective_Action_Plan', 0, 1, RANDOM(), NOW(), 1094, 1127);

-- ============================================================================
-- PAGE 206: Form:Regulatory_Report (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (320, '<form>
{{{for template|Regulatory_Report}}}
|-
! Report Date:
| <input type="date" name="report_date" />
|-
! Regulatory Body:
| <select name="regulatory_body"><option>MPI - Ministry for Primary Industries</option><option>Local Council</option><option>Regional Health</option><option>WorkSafe NZ</option><option>Other</option></select>
|-
! Report Type:
| <select name="report_type"><option>Incident notification</option><option>Recall notification</option><option>Complaint notification</option><option>Routine report</option><option>Audit response</option><option>Other</option></select>
|-
! Incident/Issue Reference:
| <input type="text" name="incident_reference" size="40" />
|-
! Reported By:
| <input type="text" name="reported_by" size="40" />
|-
! Notification Method:
| <select name="notification_method"><option>Online portal</option><option>Email</option><option>Phone</option><option>Letter</option><option>In-person</option></select>
|-
! Acknowledgment Received:
| <select name="acknowledgment_received"><option>Yes</option><option>No</option></select>
|-
! Reference Number:
| <input type="text" name="reference_number" size="30" />
|-
! Status:
| <select name="status"><option>Submitted</option><option>Acknowledged</option><option>Under review</option><option>Resolved</option><option>Closed</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Regulatory_Reports]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (320, 1365, '', 1, 'tt:320');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1095, 206, 1, 1, NOW(), 0, 0, 1365, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1095, 1, 320, 1095);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (206, 0, 'Form:Regulatory_Report', 0, 1, RANDOM(), NOW(), 1095, 1365);

-- ============================================================================
-- PAGE 207: Form:Root_Cause_Analysis (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (321, '<form>
{{{for template|Root_Cause_Analysis}}}
|-
! Analysis Date:
| <input type="date" name="analysis_date" />
|-
! Incident/Issue Reference:
| <input type="text" name="incident_reference" size="40" />
|-
! Problem Statement:
| <textarea name="problem_statement" rows="3" cols="50"></textarea>
|-
! Root Cause Identified:
| <textarea name="root_cause" rows="3" cols="50"></textarea>
|-
! Contributing Factors:
| <textarea name="contributing_factors" rows="3" cols="50"></textarea>
|-
! Supporting Evidence:
| <textarea name="evidence" rows="3" cols="50"></textarea>
|-
! Analysis Method Used:
| <select name="analysis_method"><option>5 Whys</option><option>Fishbone diagram</option><option>Fault tree analysis</option><option>Pareto analysis</option><option>Timeline analysis</option><option>Other</option></select>
|-
! Recommended Actions:
| <textarea name="recommended_actions" rows="3" cols="50"></textarea>
|-
! Status:
| <select name="status"><option>Draft</option><option>Under review</option><option>Approved</option><option>Implemented</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Root_Cause_Analysis]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (321, 1295, '', 1, 'tt:321');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1096, 207, 1, 1, NOW(), 0, 0, 1295, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1096, 1, 321, 1096);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (207, 0, 'Form:Root_Cause_Analysis', 0, 1, RANDOM(), NOW(), 1096, 1295);

-- ============================================================================
-- PAGE 208: Form:Investigation_Log (namespace 0)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (322, '<form>
{{{for template|Investigation_Log}}}
|-
! Investigation Number:
| <input type="text" name="investigation_number" size="30" />
|-
! Start Date:
| <input type="date" name="start_date" />
|-
! Incident/Complaint Reference:
| <input type="text" name="incident_reference" size="40" />
|-
! Lead Investigator:
| <input type="text" name="lead_investigator" size="40" />
|-
! Investigation Scope:
| <textarea name="investigation_scope" rows="3" cols="50"></textarea>
|-
! Interviews Conducted:
| <textarea name="interviews_conducted" rows="3" cols="50"></textarea>
|-
! Documents Reviewed:
| <textarea name="documents_reviewed" rows="3" cols="50"></textarea>
|-
! Investigation Findings:
| <textarea name="findings" rows="4" cols="50"></textarea>
|-
! Status:
| <select name="status"><option>Active</option><option>In progress</option><option>Report draft</option><option>Report final</option><option>Closed</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Red:Troubleshooting]] [[Category:Investigation_Logs]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (322, 1216, '', 1, 'tt:322');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1097, 208, 1, 1, NOW(), 0, 0, 1216, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1097, 1, 322, 1097);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (208, 0, 'Form:Investigation_Log', 0, 1, RANDOM(), NOW(), 1097, 1216);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check total pages created
SELECT COUNT(*) as total_pages_created FROM mediawiki.page WHERE page_id BETWEEN 189 AND 208;

-- Check text entries
SELECT COUNT(*) as total_text_entries FROM mediawiki.text WHERE old_id BETWEEN 303 AND 322;

-- Check revisions
SELECT COUNT(*) as total_revisions FROM mediawiki.revision WHERE rev_id BETWEEN 1078 AND 1097;

-- List all created pages
SELECT page_id, page_namespace, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 189 AND 208
ORDER BY page_id;

COMMIT;
