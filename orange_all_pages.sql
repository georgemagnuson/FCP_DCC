-- Orange Pages Insertion - All 6 Orange Serving & Selling Pages
-- Direct database approach - no script complications

BEGIN;

-- ============================================================================
-- ORANGE PAGE 2: Transporting Food
-- ============================================================================
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (226, 'FCP:Serving:Transporting food

== Know ==
* Food can be contaminated during transport
* Temperature must be maintained throughout journey
* Cold food must stay at/below 5°C
* Hot food must stay above 60°C
* Containers must be clean and food-safe

== Do ==
* Use insulated containers for temperature control
* Record starting and ending temperatures
* Transport for shortest time possible
* Never mix raw and cooked foods in same container
* Place food at bottom of vehicle, away from heat sources

== Show ==
* Transport containers and equipment
* Temperature records before and after transport
* Vehicle inspection records
* Separation procedures for different food types', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (226, 520, '', 1, 'tt:226');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1001, 123, 1, 1, NOW(), 0, 0, 520, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1001, 1, 226, 1001);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (123, 0, 'FCP:Serving:Transporting_food', 0, 1, RANDOM(), NOW(), 1001, 520);

-- ============================================================================
-- ORANGE PAGE 3: Displaying Food
-- ============================================================================
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (227, 'FCP:Serving:Displaying food

== Know ==
* Food on display can be contaminated by sick people
* Display areas must be protected from contamination
* Temperature control must continue during display
* Allergens must be clearly identified
* Display equipment must be clean

== Do ==
* Use sneeze guards or pre-wrap food
* Keep hot food above 60°C, cold food at/below 5°C
* Display only food marked with Use-By date
* Use dedicated utensils for allergen foods
* Clean display areas regularly (minimum twice daily)

== Show ==
* Display setup photographs
* Temperature monitoring records
* Cleaning schedules and records
* Allergen signage and labeling
* Use-By date checking procedures', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (227, 520, '', 1, 'tt:227');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1002, 124, 1, 1, NOW(), 0, 0, 520, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1002, 1, 227, 1002);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (124, 0, 'FCP:Serving:Displaying_food', 0, 1, RANDOM(), NOW(), 1002, 520);

-- ============================================================================
-- ORANGE PAGE 4: Knowing Allergens
-- ============================================================================
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (228, 'FCP:Serving:Allergens

== Know ==
* 22 major allergens must be identified
* Allergens: peanuts, tree nuts, milk, eggs, fish, shellfish, sesame, soy, mustard, celery, sulfites, lupin, molluscs, wheat, gluten, crustaceans, kiwi, mangoes, latex, bananas, avocados
* Cross-contamination can cause severe reactions
* Food allergies can be life-threatening
* Staff must know which foods contain which allergens

== Do ==
* Keep allergen list visible in food preparation area
* Train all staff on allergen identification
* Check all product ingredients and labels
* Use separate equipment for allergen-free foods
* Ask customers about allergies before serving
* Label all foods with allergen information

== Show ==
* Allergen training certificates
* Allergen list posted in kitchen
* Product ingredient labels and checks
* Communication with customers about allergens
* Equipment separation procedures', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (228, 680, '', 1, 'tt:228');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1003, 125, 1, 1, NOW(), 0, 0, 680, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1003, 1, 228, 1003);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (125, 0, 'FCP:Serving:Allergens', 0, 1, RANDOM(), NOW(), 1003, 680);

-- ============================================================================
-- ORANGE PAGE 5: Labelling Food
-- ============================================================================
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (229, 'FCP:Serving:Labelling

== Know ==
* Not all foods require labelling (some exemptions apply)
* ALL foods with allergens must be labeled
* Labels must include: product name, ingredients, allergen warnings
* Use-By date is mandatory
* Storage conditions must be stated
* Customer must be able to read label

== Do ==
* Include full ingredient list on label
* Highlight or clearly mark allergen information
* Use Use-By date (not just Sell-By)
* Include storage temperature and conditions
* State cooking instructions if applicable
* Use clear, readable fonts (minimum 8pt)

== Show ==
* Sample food labels
* Label templates in use
* Allergen highlighting examples
* Date marking procedures
* Label checking checklist', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (229, 550, '', 1, 'tt:229');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1004, 126, 1, 1, NOW(), 0, 0, 550, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1004, 1, 229, 1004);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (126, 0, 'FCP:Serving:Labelling', 0, 1, RANDOM(), NOW(), 1004, 550);

-- ============================================================================
-- ORANGE PAGE 6: B2B Sales
-- ============================================================================
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (230, 'FCP:Serving:B2B_Sales

== Know ==
* Selling to other businesses has different requirements than retail
* Business customers need food safety information
* Traceability becomes more important
* Invoice records must show allergen information
* Business buyer may conduct their own inspections

== Do ==
* Provide clear allergen information on every invoice
* Include temperature during transport on documentation
* Provide food safety certification if available
* Use business-appropriate containers and labeling
* Maintain batch/production date records
* Respond to business customer inquiries about food safety

== Show ==
* Business invoices with allergen details
* Food safety certificates
* Temperature recording during transport
* Batch identification system
* Business customer communication records
* Traceability documentation', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (230, 570, '', 1, 'tt:230');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1005, 127, 1, 1, NOW(), 0, 0, 570, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1005, 1, 230, 1005);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (127, 0, 'FCP:Serving:B2B_Sales', 0, 1, RANDOM(), NOW(), 1005, 570);

COMMIT;

-- Verification
SELECT 'All 6 Orange pages created' as result;
SELECT COUNT(*) as pages_created FROM mediawiki.page WHERE page_id BETWEEN 122 AND 127;
SELECT page_id, page_title FROM mediawiki.page WHERE page_id BETWEEN 122 AND 127 ORDER BY page_id;
