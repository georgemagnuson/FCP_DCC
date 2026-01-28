-- FCP MediaWiki Pages Insert Script - Production Ready
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- MediaWiki Version: 1.43.5 (Modern Schema with rev_comment_id, rev_actor)
-- PostgreSQL Version: 17.0
-- 18 pages: 6 Orange + 2 Purple + 4 Red + 6 Teal
-- Page IDs: 122-139, Revision IDs: 1000-1017, Text IDs: 225-242, Content IDs: 225-242
-- Comment IDs: 10-27, Actor ID: 5 (Maintenance script)

BEGIN;

-- ============================================================================
-- 1. INSERT COMMENT RECORDS (Comment IDs: 10-27)
-- ============================================================================
-- These must be inserted first as they are referenced by rev_comment_id

-- Orange Comments
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (10, 18732421, 'Initial page content: Keeping food hot', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (11, 18732422, 'Initial page content: Transporting food', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (12, 18732423, 'Initial page content: Displaying food', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (13, 18732424, 'Initial page content: Allergens', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (14, 18732425, 'Initial page content: Labelling', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (15, 18732426, 'Initial page content: B2B Sales', NULL);

-- Purple Comments
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (16, 18732427, 'Initial page content: Cleaning up closing', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (17, 18732428, 'Initial page content: Maintaining equipment', NULL);

-- Red Comments
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (18, 18732429, 'Initial page content: Something goes wrong', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (19, 18732430, 'Initial page content: Dealing complaints', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (20, 18732431, 'Initial page content: Tracing food', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (21, 18732432, 'Initial page content: Recalling food', NULL);

-- Teal Comments
INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (22, 18732433, 'Initial page content: Making sushi', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (23, 18732434, 'Initial page content: Chinese roast duck', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (24, 18732435, 'Initial page content: Doner kebabs', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (25, 18732436, 'Initial page content: Sous vide', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (26, 18732437, 'Initial page content: Preparing red meat', NULL);

INSERT INTO mediawiki.comment (comment_id, comment_hash, comment_text, comment_data)
VALUES (27, 18732438, 'Initial page content: Making biltong', NULL);

-- ============================================================================
-- ORANGE PAGES (6 pages)
-- ============================================================================

-- Orange Page 1: Keeping food hot (Page ID: 122, Revision ID: 1000)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (225, '= Know =

This section covers the key principles for keeping food hot.

== Key Points ==
* Understanding the importance of maintaining proper food temperatures
* Best practices for heat retention
* Equipment and methods for keeping food hot
* Health and safety compliance requirements

= Do =

== Practical Steps ==
1. Review temperature maintenance procedures
2. Use appropriate heating equipment
3. Monitor food temperatures regularly
4. Document temperature checks
5. Report any equipment failures

= Show =

== Evidence of Compliance ==
* Temperature monitoring records
* Equipment maintenance logs
* Training certificates
* Inspection results

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (225, 614, '', 1, 'tt:225');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1000, 122, 10, 5, '2024-01-15 10:00:00', 0, 0, 614, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1000, 1, 225, 1000);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (122, 0, 'Keeping_food_hot', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1000, 614, 1);

-- Orange Page 2: Transporting food (Page ID: 123, Revision ID: 1001)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (226, '= Know =

This section covers the key principles for transporting food.

== Key Points ==
* Understanding food safety during transport
* Temperature maintenance in transit
* Hygiene and contamination prevention
* Legal requirements for food transport
* Vehicle and equipment standards

= Do =

== Practical Steps ==
1. Inspect vehicles and containers before use
2. Maintain proper temperature during transit
3. Minimize transport time
4. Prevent cross-contamination
5. Keep transport records

= Show =

== Evidence of Compliance ==
* Vehicle inspection checklists
* Temperature logs during transit
* Transport documentation
* Training records
* Insurance certificates

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (226, 618, '', 1, 'tt:226');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1001, 123, 11, 5, '2024-01-15 10:01:00', 0, 0, 618, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1001, 1, 226, 1001);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (123, 0, 'Transporting_food', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1001, 618, 1);

-- Orange Page 3: Displaying food (Page ID: 124, Revision ID: 1002)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (227, '= Know =

This section covers the key principles for displaying food.

== Key Points ==
* Visual presentation standards
* Food safety during display
* Temperature control for displayed items
* Hygiene requirements
* Customer communication through display

= Do =

== Practical Steps ==
1. Arrange food according to standards
2. Maintain temperature controls
3. Prevent contamination
4. Update displays regularly
5. Monitor food freshness

= Show =

== Evidence of Compliance ==
* Display setup photographs
* Temperature records
* Cleaning logs
* Staff training records
* Inspection reports

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (227, 583, '', 1, 'tt:227');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1002, 124, 12, 5, '2024-01-15 10:02:00', 0, 0, 583, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1002, 1, 227, 1002);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (124, 0, 'Displaying_food', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1002, 583, 1);

-- Orange Page 4: Allergens (Page ID: 125, Revision ID: 1003)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (228, '= Know =

This section covers allergen management and disclosure.

== Key Points ==
* Understanding common food allergens
* Allergen identification and labelling
* Cross-contamination risks
* Regulatory requirements for allergen disclosure
* Customer safety and responsibility

= Do =

== Practical Steps ==
1. Identify all allergens in products
2. Label products clearly
3. Prevent cross-contamination
4. Train staff on allergen handling
5. Maintain allergen records

= Show =

== Evidence of Compliance ==
* Allergen identification lists
* Product labels with allergen warnings
* Staff training certificates
* Cross-contamination prevention logs
* Customer communication records

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (228, 562, '', 1, 'tt:228');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1003, 125, 13, 5, '2024-01-15 10:03:00', 0, 0, 562, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1003, 1, 228, 1003);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (125, 0, 'Allergens', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1003, 562, 1);

-- Orange Page 5: Labelling (Page ID: 126, Revision ID: 1004)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (229, '= Know =

This section covers proper food labelling requirements.

== Key Points ==
* Legal labelling requirements
* Information that must be included
* Labelling standards and formats
* Date coding and shelf-life labelling
* Nutritional information requirements

= Do =

== Practical Steps ==
1. Design compliant labels
2. Apply labels to all products
3. Include required information
4. Use correct date coding
5. Verify label accuracy

= Show =

== Evidence of Compliance ==
* Label templates and examples
* Labelling procedures
* Staff training records
* Label audit logs
* Regulatory compliance certificates

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (229, 531, '', 1, 'tt:229');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1004, 126, 14, 5, '2024-01-15 10:04:00', 0, 0, 531, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1004, 1, 229, 1004);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (126, 0, 'Labelling', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1004, 531, 1);

-- Orange Page 6: B2B Sales (Page ID: 127, Revision ID: 1005)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (230, '= Know =

This section covers business-to-business food sales procedures.

== Key Points ==
* B2B sales requirements and standards
* Documentation and record-keeping
* Food safety certifications needed
* Customer requirements and expectations
* Quality assurance procedures

= Do =

== Practical Steps ==
1. Prepare B2B documentation
2. Obtain necessary certifications
3. Establish quality standards
4. Maintain customer accounts
5. Document all transactions

= Show =

== Evidence of Compliance ==
* Sales contracts and agreements
* Quality certifications
* Food safety documentation
* Customer compliance reports
* Transaction records

[[Category:FCP]]
[[Category:Orange]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (230, 545, '', 1, 'tt:230');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1005, 127, 15, 5, '2024-01-15 10:05:00', 0, 0, 545, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1005, 1, 230, 1005);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (127, 0, 'B2B_Sales', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1005, 545, 1);

-- ============================================================================
-- PURPLE PAGES (2 pages)
-- ============================================================================

-- Purple Page 1: Cleaning up and closing (Page ID: 128, Revision ID: 1006)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (231, '= Know =

This section covers end-of-day cleaning and closing procedures.

== Key Points ==
* Importance of thorough cleaning
* Food safety during closure
* Equipment shutdown procedures
* Hygiene standards for closing
* Security and facility protection

= Do =

== Practical Steps ==
1. Clean all food preparation areas
2. Sanitize equipment and surfaces
3. Dispose of waste properly
4. Secure the facility
5. Document closing procedures

= Show =

== Evidence of Compliance ==
* Cleaning checklists
* Facility inspection logs
* Equipment maintenance records
* Staff sign-off sheets
* Security logs

[[Category:FCP]]
[[Category:Purple]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (231, 557, '', 1, 'tt:231');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1006, 128, 16, 5, '2024-01-15 10:06:00', 0, 0, 557, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1006, 1, 231, 1006);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (128, 0, 'Cleaning_up_closing', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1006, 557, 1);

-- Purple Page 2: Maintaining equipment (Page ID: 129, Revision ID: 1007)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (232, '= Know =

This section covers equipment maintenance and care procedures.

== Key Points ==
* Importance of equipment maintenance
* Regular maintenance schedules
* Equipment servicing requirements
* Preventive maintenance best practices
* Food safety impact of equipment condition

= Do =

== Practical Steps ==
1. Follow maintenance schedules
2. Perform regular inspections
3. Clean and sanitize equipment
4. Document maintenance activities
5. Report equipment failures

= Show =

== Evidence of Compliance ==
* Maintenance schedules
* Service records
* Inspection logs
* Repair documentation
* Equipment certification records

[[Category:FCP]]
[[Category:Purple]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (232, 550, '', 1, 'tt:232');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1007, 129, 17, 5, '2024-01-15 10:07:00', 0, 0, 550, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1007, 1, 232, 1007);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (129, 0, 'Maintaining_equipment', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1007, 550, 1);

-- ============================================================================
-- RED PAGES (4 pages)
-- ============================================================================

-- Red Page 1: Something goes wrong (Page ID: 130, Revision ID: 1008)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (233, '= Know =

This section covers incident response and problem-solving procedures.

== Key Points ==
* Recognizing when something goes wrong
* Immediate response procedures
* Safety and customer protection
* Incident reporting requirements
* Regulatory notification obligations

= Do =

== Practical Steps ==
1. Identify the problem
2. Stop affected operations
3. Assess impact and risk
4. Notify management immediately
5. Document the incident

= Show =

== Evidence of Compliance ==
* Incident reports
* Response logs
* Corrective action records
* Regulatory notifications
* Training records

[[Category:FCP]]
[[Category:Red]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (233, 535, '', 1, 'tt:233');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1008, 130, 18, 5, '2024-01-15 10:08:00', 0, 0, 535, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1008, 1, 233, 1008);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (130, 0, 'Something_goes_wrong', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1008, 535, 1);

-- Red Page 2: Dealing with complaints (Page ID: 131, Revision ID: 1009)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (234, '= Know =

This section covers complaint handling and resolution procedures.

== Key Points ==
* Customer complaint types and categories
* Complaint investigation procedures
* Root cause analysis
* Resolution strategies
* Documentation requirements

= Do =

== Practical Steps ==
1. Listen to and record the complaint
2. Investigate the issue
3. Identify the root cause
4. Develop corrective action
5. Follow up with customer

= Show =

== Evidence of Compliance ==
* Complaint logs
* Investigation reports
* Corrective action plans
* Resolution documentation
* Customer feedback records

[[Category:FCP]]
[[Category:Red]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (234, 532, '', 1, 'tt:234');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1009, 131, 19, 5, '2024-01-15 10:09:00', 0, 0, 532, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1009, 1, 234, 1009);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (131, 0, 'Dealing_complaints', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1009, 532, 1);

-- Red Page 3: Tracing food (Page ID: 132, Revision ID: 1010)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (235, '= Know =

This section covers food traceability and trace procedures.

== Key Points ==
* Importance of food traceability
* Record keeping requirements
* Supplier documentation
* Product batch tracking
* Recall preparation

= Do =

== Practical Steps ==
1. Maintain supplier records
2. Track product batches
3. Document product movement
4. Establish traceability systems
5. Test traceability procedures

= Show =

== Evidence of Compliance ==
* Supplier documentation
* Batch tracking records
* Movement logs
* Traceability test results
* System audit reports

[[Category:FCP]]
[[Category:Red]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (235, 502, '', 1, 'tt:235');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1010, 132, 20, 5, '2024-01-15 10:10:00', 0, 0, 502, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1010, 1, 235, 1010);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (132, 0, 'Tracing_food', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1010, 502, 1);

-- Red Page 4: Recalling food (Page ID: 133, Revision ID: 1011)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (236, '= Know =

This section covers food recall procedures and implementation.

== Key Points ==
* Recall triggers and categories
* Regulatory notification requirements
* Communication procedures
* Product identification and retrieval
* Documentation and record-keeping

= Do =

== Practical Steps ==
1. Identify affected product
2. Notify regulatory bodies
3. Communicate with customers
4. Retrieve product from distribution
5. Document all actions

= Show =

== Evidence of Compliance ==
* Recall notices
* Regulatory notifications
* Customer communications
* Product recovery records
* Recall effectiveness reports

[[Category:FCP]]
[[Category:Red]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (236, 510, '', 1, 'tt:236');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1011, 133, 21, 5, '2024-01-15 10:11:00', 0, 0, 510, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1011, 1, 236, 1011);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (133, 0, 'Recalling_food', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1011, 510, 1);

-- ============================================================================
-- TEAL PAGES (6 pages)
-- ============================================================================

-- Teal Page 1: Making sushi (Page ID: 134, Revision ID: 1012)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (237, '= Know =

This section covers the principles and techniques for making sushi.

== Key Points ==
* Understanding sushi components
* Rice preparation and seasoning
* Fish quality and safety
* Ingredient sourcing and handling
* Cultural and food safety considerations

= Do =

== Practical Steps ==
1. Select quality ingredients
2. Prepare sushi rice properly
3. Handle fish safely
4. Master rolling techniques
5. Plate and present professionally

= Show =

== Evidence of Compliance ==
* Recipe documentation
* Staff training certificates
* Quality control records
* Ingredient sourcing logs
* Customer feedback

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (237, 537, '', 1, 'tt:237');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1012, 134, 22, 5, '2024-01-15 10:12:00', 0, 0, 537, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1012, 1, 237, 1012);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (134, 0, 'Making_sushi', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1012, 537, 1);

-- Teal Page 2: Chinese roast duck (Page ID: 135, Revision ID: 1013)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (238, '= Know =

This section covers the preparation and cooking of Chinese roast duck.

== Key Points ==
* Duck selection and preparation
* Marinating techniques
* Roasting methods and temperatures
* Achieving proper skin quality
* Flavor development and authenticity

= Do =

== Practical Steps ==
1. Select quality duck
2. Prepare and clean thoroughly
3. Apply marinade
4. Roast at proper temperature
5. Monitor cooking progress
6. Carve and present

= Show =

== Evidence of Compliance ==
* Preparation procedures
* Temperature monitoring logs
* Quality standards documentation
* Staff training records
* Customer satisfaction surveys

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (238, 569, '', 1, 'tt:238');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1013, 135, 23, 5, '2024-01-15 10:13:00', 0, 0, 569, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1013, 1, 238, 1013);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (135, 0, 'Chinese_roast_duck', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1013, 569, 1);

-- Teal Page 3: Doner kebabs (Page ID: 136, Revision ID: 1014)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (239, '= Know =

This section covers the preparation and cooking of doner kebabs.

== Key Points ==
* Meat selection and quality
* Marinade ingredients and preparation
* Layering and stacking techniques
* Vertical spit cooking method
* Slicing and presentation

= Do =

== Practical Steps ==
1. Select quality meat cuts
2. Prepare marinading spice mix
3. Layer meat on vertical spit
4. Monitor cooking and browning
5. Carve meat fresh for service
6. Maintain proper temperature

= Show =

== Evidence of Compliance ==
* Recipe documentation
* Meat sourcing records
* Temperature logs
* Staff certification
* Food safety records

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (239, 543, '', 1, 'tt:239');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1014, 136, 24, 5, '2024-01-15 10:14:00', 0, 0, 543, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1014, 1, 239, 1014);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (136, 0, 'Doner_kebabs', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1014, 543, 1);

-- Teal Page 4: Sous vide (Page ID: 137, Revision ID: 1015)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (240, '= Know =

This section covers sous vide cooking techniques and applications.

== Key Points ==
* Understanding sous vide technology
* Vacuum sealing procedures
* Temperature and time precision
* Food safety in sous vide cooking
* Equipment operation and maintenance

= Do =

== Practical Steps ==
1. Prepare and season ingredients
2. Vacuum seal food items
3. Set precise temperature
4. Cook for recommended time
5. Finish and serve appropriately
6. Maintain equipment

= Show =

== Evidence of Compliance ==
* Equipment manual and logs
* Temperature verification records
* Vacuum seal quality checks
* Safety documentation
* Staff training certificates

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (240, 526, '', 1, 'tt:240');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1015, 137, 25, 5, '2024-01-15 10:15:00', 0, 0, 526, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1015, 1, 240, 1015);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (137, 0, 'Sous_vide', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1015, 526, 1);

-- Teal Page 5: Preparing red meat (Page ID: 138, Revision ID: 1016)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (241, '= Know =

This section covers the selection and preparation of red meat.

== Key Points ==
* Red meat cuts and grades
* Sourcing quality meat
* Storage and handling procedures
* Preparation techniques
* Cooking methods and temperatures
* Food safety standards

= Do =

== Practical Steps ==
1. Source from certified suppliers
2. Inspect meat quality
3. Store at proper temperature
4. Trim and portion as needed
5. Cook to safe temperatures
6. Rest and carve properly

= Show =

== Evidence of Compliance ==
* Supplier certifications
* Temperature logs
* Storage records
* Cooking temperature records
* Quality inspections

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (241, 563, '', 1, 'tt:241');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1016, 138, 26, 5, '2024-01-15 10:16:00', 0, 0, 563, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1016, 1, 241, 1016);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (138, 0, 'Preparing_red_meat', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1016, 563, 1);

-- Teal Page 6: Making biltong (Page ID: 139, Revision ID: 1017)
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (242, '= Know =

This section covers the preparation and drying of biltong.

== Key Points ==
* Beef selection for biltong
* Spice blending traditions
* Cutting and slicing techniques
* Drying methods and duration
* Environmental control during drying
* Food safety in dried meat production

= Do =

== Practical Steps ==
1. Select quality beef cuts
2. Mix traditional spices
3. Slice meat to proper thickness
4. Apply spice mixture
5. Hang in drying environment
6. Monitor moisture and time
7. Package appropriately

= Show =

== Evidence of Compliance ==
* Recipe documentation
* Sourcing records
* Drying logs
* Moisture testing records
* Food safety certifications

[[Category:FCP]]
[[Category:Teal]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (242, 586, '', 1, 'tt:242');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1017, 139, 27, 5, '2024-01-15 10:17:00', 0, 0, 586, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1017, 1, 242, 1017);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_links_updated, page_latest, page_len, page_content_model)
VALUES (139, 0, 'Making_biltong', 0, 1, RANDOM()::double precision, NOW(), NOW(), 1017, 586, 1);

-- ============================================================================
-- COMMIT TRANSACTION
-- ============================================================================

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================
-- Run these after the transaction to verify data integrity

-- Verify all comment records were inserted
SELECT COUNT(*) as comment_count FROM mediawiki.comment
WHERE comment_id BETWEEN 10 AND 27;

-- Verify all text records were inserted
SELECT COUNT(*) as text_count FROM mediawiki.text
WHERE old_id BETWEEN 225 AND 242;

-- Verify all content records were inserted
SELECT COUNT(*) as content_count FROM mediawiki.content
WHERE content_id BETWEEN 225 AND 242;

-- Verify all revision records were inserted with proper comment_id and actor references
SELECT COUNT(*) as revision_count FROM mediawiki.revision
WHERE rev_id BETWEEN 1000 AND 1017
AND rev_comment_id BETWEEN 10 AND 27
AND rev_actor = 5;

-- Verify all slot records were inserted
SELECT COUNT(*) as slot_count FROM mediawiki.slots
WHERE slot_revision_id BETWEEN 1000 AND 1017;

-- Verify all page records were inserted
SELECT COUNT(*) as page_count FROM mediawiki.page
WHERE page_id BETWEEN 122 AND 139;

-- Detailed verification: List all inserted pages with their revisions
SELECT
  p.page_id,
  p.page_title,
  p.page_latest,
  r.rev_id,
  c.comment_text,
  a.actor_name
FROM mediawiki.page p
JOIN mediawiki.revision r ON p.page_latest = r.rev_id
JOIN mediawiki.comment c ON r.rev_comment_id = c.comment_id
JOIN mediawiki.actor a ON r.rev_actor = a.actor_id
WHERE p.page_id BETWEEN 122 AND 139
ORDER BY p.page_id;

-- Verify content integrity: Check text/content/slot linking
SELECT
  t.old_id,
  c.content_id,
  c.content_model,
  s.slot_revision_id,
  LENGTH(t.old_text) as text_length,
  c.content_size
FROM mediawiki.text t
JOIN mediawiki.content c ON t.old_id = c.content_id
JOIN mediawiki.slots s ON c.content_id = s.slot_content_id
WHERE t.old_id BETWEEN 225 AND 242
ORDER BY t.old_id;

-- Summary statistics
SELECT
  'Comments' as entity, COUNT(*) as count FROM mediawiki.comment WHERE comment_id BETWEEN 10 AND 27
UNION ALL
SELECT 'Text Records', COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Content Records', COUNT(*) FROM mediawiki.content WHERE content_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Revisions', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Slots', COUNT(*) FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Pages', COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
