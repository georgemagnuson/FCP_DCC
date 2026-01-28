-- ============================================================================
-- FCP_DCC MediaWiki Database Insert Script
-- Purpose: Insert Orange, Purple, Red, and Teal section pages
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- Fixed: Removed SHA1() function calls (PostgreSQL doesn't have built-in SHA1)
-- ============================================================================

BEGIN;

-- Helper function to calculate SHA1 if needed
CREATE OR REPLACE FUNCTION sha1_text(text) RETURNS text AS $$
  SELECT encode(digest($1, 'sha1'), 'hex');
$$ LANGUAGE SQL IMMUTABLE;

-- ============================================================================
-- ORANGE SECTION - Serving & Selling (6 pages)
-- ============================================================================

-- Page 1: Keeping food hot
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (225, 'FCP:Serving_Selling:Keeping food hot - Know: Temperature danger zone 5-60C, Hot food kept above 60C, Check every 2 hours. Do: Use calibrated thermometer, follow manufacturer instructions, reheat to 75C if below 60C. Show: Temperature records, procedures documentation.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (225, 250, '', 'wikitext', 'tt:225');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1000, 122, '20260128051245', 1, 0, 0, 250, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1000, 1, 225, 1000);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (122, 6, 'Keeping_food_hot', 0, 1, 1000, 250);

-- Page 2: Transporting food
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (226, 'FCP:Serving_Selling:Transporting food - Know: Keep out of danger zone 5-60C, Use appropriate equipment. Do: Cold food at/below 5C, hot food above 60C, record temperature. Show: Equipment and procedures, temperature records.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (226, 220, '', 'wikitext', 'tt:226');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1001, 123, '20260128051246', 1, 0, 0, 220, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1001, 1, 226, 1001);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (123, 6, 'Transporting_food', 0, 1, 1001, 220);

-- Page 3: Displaying food
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (227, 'FCP:Serving_Selling:Displaying food - Know: Food on display can be contaminated by sick people. Do: Pre-wrap or use sneeze guards, follow hot/cold keeping rules, dedicated utensils for allergens. Show: Display setup and procedures.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (227, 230, '', 'wikitext', 'tt:227');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1002, 124, '20260128051247', 1, 0, 0, 230, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1002, 1, 227, 1002);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (124, 6, 'Displaying_food', 0, 1, 1002, 230);

-- Page 4: Knowing allergens
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (228, 'FCP:Serving_Selling:Allergens - Know: Common allergens list, food allergies can be life-threatening. Do: Know ingredients, tell staff about allergens, check all components. Show: Allergen information, ingredient knowledge.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (228, 220, '', 'wikitext', 'tt:228');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1003, 125, '20260128051248', 1, 0, 0, 220, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1003, 1, 228, 1003);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (125, 6, 'Allergens', 0, 1, 1003, 220);

-- Page 5: Labelling food
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (229, 'FCP:Serving_Selling:Labelling - Know: Not all foods require labelling but must declare allergens. Do: Include name, ingredients, date mark, storage conditions, allergen declarations. Show: Food labels, labelling procedures.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (229, 230, '', 'wikitext', 'tt:229');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1004, 126, '20260128051249', 1, 0, 0, 230, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1004, 1, 229, 1004);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (126, 6, 'Labelling', 0, 1, 1004, 230);

-- Page 6: B2B sales
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (230, 'FCP:Serving_Selling:B2B - Know: Can sell to other businesses if no change to main purpose. Do: Keep records of businesses supplied, provide food safety information, inform about storage requirements. Show: Supply records and documentation.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (230, 240, '', 'wikitext', 'tt:230');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1005, 127, '20260128051250', 1, 0, 0, 240, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1005, 1, 230, 1005);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (127, 6, 'B2B', 0, 1, 1005, 240);

-- ============================================================================
-- PURPLE SECTION - Closing (2 pages)
-- ============================================================================

-- Page 7: Cleaning and closing
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (231, 'FCP:Closing:Cleaning - Know: Cleaning removes dirt and bugs, sanitizing kills remaining bugs. Do: Clean and sanitize surfaces daily, remove rubbish, use clean water. Show: Cleaning procedures, maintenance records.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (231, 240, '', 'wikitext', 'tt:231');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1006, 128, '20260128051251', 1, 0, 0, 240, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1006, 1, 231, 1006);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (128, 6, 'Cleaning_up_and_closing', 0, 1, 1006, 240);

-- Page 8: Equipment maintenance
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (232, 'FCP:Closing:Maintenance - Know: Broken equipment allows pests, water pipes need checking, equipment needs calibration. Do: Check premises for deterioration, service equipment regularly, calibrate thermometers. Show: Maintenance records and calibration logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (232, 260, '', 'wikitext', 'tt:232');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1007, 129, '20260128051252', 1, 0, 0, 260, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1007, 1, 232, 1007);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (129, 6, 'Maintaining_equipment_and_facilities', 0, 1, 1007, 260);

-- ============================================================================
-- RED SECTION - Troubleshooting (4 pages)
-- ============================================================================

-- Page 9: When something goes wrong
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (233, 'FCP:Troubleshooting:Problems - Know: Must have plan for problems, record what went wrong. Do: Take immediate action, identify problem source, record details. Show: Problem logs and corrective actions taken.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (233, 250, '', 'wikitext', 'tt:233');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1008, 130, '20260128051253', 1, 0, 0, 250, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1008, 1, 233, 1008);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (130, 6, 'When_something_goes_wrong', 0, 1, 1008, 250);

-- Page 10: Customer complaints
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (234, 'FCP:Troubleshooting:Complaints - Know: Must identify if complaint is safety, suitability or quality issue. Do: Identify responsible person, address food safety issues immediately. Show: Complaint records and actions taken.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (234, 260, '', 'wikitext', 'tt:234');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1009, 131, '20260128051254', 1, 0, 0, 260, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1009, 1, 234, 1009);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (131, 6, 'Dealing_with_customer_complaints', 0, 1, 1009, 260);

-- Page 11: Tracing food
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (235, 'FCP:Troubleshooting:Tracing - Know: Must trace food back to supplier, two options for tracing method. Do: Choose tracing method, keep records of suppliers and ingredients. Show: Trace records and supplier information.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (235, 250, '', 'wikitext', 'tt:235');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1010, 132, '20260128051255', 1, 0, 0, 250, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1010, 1, 235, 1010);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (132, 6, 'Tracing_your_food', 0, 1, 1010, 250);

-- Page 12: Recalling food
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (236, 'FCP:Troubleshooting:Recalls - Know: May need to recall if unsafe/unsuitable, two types of recalls. Do: Identify affected product, follow MPI procedures, document recall process. Show: Recall records and documentation.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (236, 250, '', 'wikitext', 'tt:236');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1011, 133, '20260128051256', 1, 0, 0, 250, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1011, 1, 236, 1011);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (133, 6, 'Recalling_your_food', 0, 1, 1011, 250);

-- ============================================================================
-- TEAL SECTION - Specialist Procedures (6 pages)
-- ============================================================================

-- Page 13: Making sushi
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (237, 'FCP:Specialist:Sushi - Know: Can use acidified or non-acidified rice, pH must be 3.0-4.3. Do: Test pH of acidified rice, cool properly, don''t mix batches. Show: pH testing records, cooling logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (237, 260, '', 'wikitext', 'tt:237');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1012, 134, '20260128051257', 1, 0, 0, 260, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1012, 1, 237, 1012);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (134, 6, 'Making_sushi', 0, 1, 1012, 260);

-- Page 14: Chinese roast duck
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (238, 'FCP:Specialist:Duck - Know: Drying at room temperature too long allows bug toxins. Do: Don''t hang above 5C for >6 hours, check core temp <= 25C. Show: Temperature records, drying logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (238, 240, '', 'wikitext', 'tt:238');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1013, 135, '20260128051258', 1, 0, 0, 240, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1013, 1, 238, 1013);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (135, 6, 'Making_Chinese_style_roast_duck', 0, 1, 1013, 240);

-- Page 15: Doner kebabs
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (239, 'FCP:Specialist:Kebab - Know: Raw meat contains bugs that contaminate ready-to-eat food. Do: Thoroughly cook before slicing, keep elements on, further cook if needed. Show: Cooking records and temperatures.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (239, 250, '', 'wikitext', 'tt:239');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1014, 136, '20260128051259', 1, 0, 0, 250, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1014, 1, 239, 1014);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (136, 6, 'Making_doner_kebabs', 0, 1, 1014, 250);

-- Page 16: Sous vide
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (240, 'FCP:Specialist:Sous_vide - Know: Cooked in danger zone, lower temps take longer to kill bugs. Do: Calibrate water bath monthly, keep temp above 55C/60C, test temperature. Show: Water bath records and temperature logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (240, 260, '', 'wikitext', 'tt:240');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1015, 137, '20260128051260', 1, 0, 0, 260, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1015, 1, 240, 1015);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (137, 6, 'Cooking_using_sous_vide', 0, 1, 1015, 260);

-- Page 17: Preparing red meat
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (241, 'FCP:Specialist:Red_meat - Know: Only beef/lamb/venison, searing/blanching/sanitizing required for raw service. Do: Choose surface treatment method, store <=5C, use within 48 hours. Show: Treatment records and temperature logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (241, 270, '', 'wikitext', 'tt:241');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1016, 138, '20260128051261', 1, 0, 0, 270, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1016, 1, 241, 1016);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (138, 6, 'Preparing_red_meat_for_mincing_and_serving_lightly-cooked_or_raw', 0, 1, 1016, 270);

-- Page 18: Making biltong
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (242, 'FCP:Specialist:Biltong - Know: Only red meat from registered processors, dry to aw <0.85. Do: Use proper marinade ratio (salt/vinegar min 30g per kg), check water activity. Show: Water activity testing records and batch logs.', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (242, 280, '', 'wikitext', 'tt:242');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES (1017, 139, '20260128051262', 1, 0, 0, 280, NULL, '', 'wikitext', 'text/x-wiki');
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1017, 1, 242, 1017);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES (139, 6, 'Making_biltong', 0, 1, 1017, 280);

-- Commit transaction
COMMIT;

-- Verify insertion
SELECT 'Pages created:' AS check, COUNT(*) FROM mediawiki.page WHERE page_id >= 122 AND page_id <= 139;
SELECT 'Text records created:' AS check, COUNT(*) FROM mediawiki.text WHERE old_id >= 225 AND old_id <= 242;
