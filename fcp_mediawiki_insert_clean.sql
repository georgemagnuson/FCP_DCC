-- FCP MediaWiki Pages Insert Script
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- 18 pages: 6 Orange + 2 Purple + 4 Red + 6 Teal
-- Page IDs: 122-139, Revision IDs: 1000-1017, Text IDs: 225-242, Slot IDs: 500-517

BEGIN;

-- ============================================================================
-- ORANGE PAGES (6 pages)
-- ============================================================================

-- Orange Page 1: Keeping food hot (Page ID: 122)
INSERT INTO text (old_id, old_text, old_flags) VALUES (225, 'Content for Keeping food hot', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (225, 'tt:225');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1000, 122, '2024-01-01 10:00:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 225);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (500, 1000, 1, 225, 1000);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (122, 0, 'Keeping_food_hot', 'wikitext', 1000);

-- Orange Page 2: Transporting food (Page ID: 123)
INSERT INTO text (old_id, old_text, old_flags) VALUES (226, 'Content for Transporting food', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (226, 'tt:226');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1001, 123, '2024-01-01 10:05:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 226);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (501, 1001, 1, 226, 1001);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (123, 0, 'Transporting_food', 'wikitext', 1001);

-- Orange Page 3: Displaying food (Page ID: 124)
INSERT INTO text (old_id, old_text, old_flags) VALUES (227, 'Content for Displaying food', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (227, 'tt:227');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1002, 124, '2024-01-01 10:10:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 227);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (502, 1002, 1, 227, 1002);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (124, 0, 'Displaying_food', 'wikitext', 1002);

-- Orange Page 4: Allergens (Page ID: 125)
INSERT INTO text (old_id, old_text, old_flags) VALUES (228, 'Content for Allergens', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (228, 'tt:228');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1003, 125, '2024-01-01 10:15:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 228);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (503, 1003, 1, 228, 1003);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (125, 0, 'Allergens', 'wikitext', 1003);

-- Orange Page 5: Labelling (Page ID: 126)
INSERT INTO text (old_id, old_text, old_flags) VALUES (229, 'Content for Labelling', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (229, 'tt:229');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1004, 126, '2024-01-01 10:20:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 229);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (504, 1004, 1, 229, 1004);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (126, 0, 'Labelling', 'wikitext', 1004);

-- Orange Page 6: B2B sales (Page ID: 127)
INSERT INTO text (old_id, old_text, old_flags) VALUES (230, 'Content for B2B sales', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (230, 'tt:230');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1005, 127, '2024-01-01 10:25:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 230);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (505, 1005, 1, 230, 1005);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (127, 0, 'B2B_sales', 'wikitext', 1005);

-- ============================================================================
-- PURPLE PAGES (2 pages)
-- ============================================================================

-- Purple Page 1: Cleaning up and closing (Page ID: 128)
INSERT INTO text (old_id, old_text, old_flags) VALUES (231, 'Content for Cleaning up and closing', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (231, 'tt:231');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1006, 128, '2024-01-01 10:30:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 231);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (506, 1006, 1, 231, 1006);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (128, 0, 'Cleaning_up_and_closing', 'wikitext', 1006);

-- Purple Page 2: Maintaining equipment and facilities (Page ID: 129)
INSERT INTO text (old_id, old_text, old_flags) VALUES (232, 'Content for Maintaining equipment and facilities', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (232, 'tt:232');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1007, 129, '2024-01-01 10:35:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 232);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (507, 1007, 1, 232, 1007);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (129, 0, 'Maintaining_equipment_and_facilities', 'wikitext', 1007);

-- ============================================================================
-- RED PAGES (4 pages)
-- ============================================================================

-- Red Page 1: When something goes wrong (Page ID: 130)
INSERT INTO text (old_id, old_text, old_flags) VALUES (233, 'Content for When something goes wrong', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (233, 'tt:233');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1008, 130, '2024-01-01 10:40:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 233);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (508, 1008, 1, 233, 1008);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (130, 0, 'When_something_goes_wrong', 'wikitext', 1008);

-- Red Page 2: Dealing with complaints (Page ID: 131)
INSERT INTO text (old_id, old_text, old_flags) VALUES (234, 'Content for Dealing with complaints', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (234, 'tt:234');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1009, 131, '2024-01-01 10:45:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 234);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (509, 1009, 1, 234, 1009);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (131, 0, 'Dealing_with_complaints', 'wikitext', 1009);

-- Red Page 3: Tracing food (Page ID: 132)
INSERT INTO text (old_id, old_text, old_flags) VALUES (235, 'Content for Tracing food', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (235, 'tt:235');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1010, 132, '2024-01-01 10:50:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 235);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (510, 1010, 1, 235, 1010);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (132, 0, 'Tracing_food', 'wikitext', 1010);

-- Red Page 4: Recalling food (Page ID: 133)
INSERT INTO text (old_id, old_text, old_flags) VALUES (236, 'Content for Recalling food', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (236, 'tt:236');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1011, 133, '2024-01-01 10:55:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 236);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (511, 1011, 1, 236, 1011);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (133, 0, 'Recalling_food', 'wikitext', 1011);

-- ============================================================================
-- TEAL PAGES (6 pages)
-- ============================================================================

-- Teal Page 1: Making sushi (Page ID: 134)
INSERT INTO text (old_id, old_text, old_flags) VALUES (237, 'Content for Making sushi', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (237, 'tt:237');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1012, 134, '2024-01-01 11:00:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 237);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (512, 1012, 1, 237, 1012);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (134, 0, 'Making_sushi', 'wikitext', 1012);

-- Teal Page 2: Chinese roast duck (Page ID: 135)
INSERT INTO text (old_id, old_text, old_flags) VALUES (238, 'Content for Chinese roast duck', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (238, 'tt:238');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1013, 135, '2024-01-01 11:05:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 238);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (513, 1013, 1, 238, 1013);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (135, 0, 'Chinese_roast_duck', 'wikitext', 1013);

-- Teal Page 3: Doner kebabs (Page ID: 136)
INSERT INTO text (old_id, old_text, old_flags) VALUES (239, 'Content for Doner kebabs', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (239, 'tt:239');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1014, 136, '2024-01-01 11:10:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 239);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (514, 1014, 1, 239, 1014);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (136, 0, 'Doner_kebabs', 'wikitext', 1014);

-- Teal Page 4: Sous vide (Page ID: 137)
INSERT INTO text (old_id, old_text, old_flags) VALUES (240, 'Content for Sous vide', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (240, 'tt:240');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1015, 137, '2024-01-01 11:15:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 240);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (515, 1015, 1, 240, 1015);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (137, 0, 'Sous_vide', 'wikitext', 1015);

-- Teal Page 5: Preparing red meat (Page ID: 138)
INSERT INTO text (old_id, old_text, old_flags) VALUES (241, 'Content for Preparing red meat', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (241, 'tt:241');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1016, 138, '2024-01-01 11:20:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 241);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (516, 1016, 1, 241, 1016);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (138, 0, 'Preparing_red_meat', 'wikitext', 1016);

-- Teal Page 6: Making biltong (Page ID: 139)
INSERT INTO text (old_id, old_text, old_flags) VALUES (242, 'Content for Making biltong', 'utf-8');
INSERT INTO content (content_id, content_address) VALUES (242, 'tt:242');
INSERT INTO revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1017, 139, '2024-01-01 11:25:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 242);
INSERT INTO slots (slot_id, slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (517, 1017, 1, 242, 1017);
INSERT INTO page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (139, 0, 'Making_biltong', 'wikitext', 1017);

-- ============================================================================
-- COMMIT TRANSACTION
-- ============================================================================

COMMIT;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Verify text records inserted
SELECT COUNT(*) AS text_count FROM text WHERE old_id BETWEEN 225 AND 242;

-- Verify content records inserted
SELECT COUNT(*) AS content_count FROM content WHERE content_id BETWEEN 225 AND 242;

-- Verify revision records inserted
SELECT COUNT(*) AS revision_count FROM revision WHERE rev_id BETWEEN 1000 AND 1017;

-- Verify slots records inserted
SELECT COUNT(*) AS slots_count FROM slots WHERE slot_id BETWEEN 500 AND 517;

-- Verify page records inserted
SELECT COUNT(*) AS page_count FROM page WHERE page_id BETWEEN 122 AND 139;

-- Summary verification
SELECT
  (SELECT COUNT(*) FROM text WHERE old_id BETWEEN 225 AND 242) AS text_count,
  (SELECT COUNT(*) FROM content WHERE content_id BETWEEN 225 AND 242) AS content_count,
  (SELECT COUNT(*) FROM revision WHERE rev_id BETWEEN 1000 AND 1017) AS revision_count,
  (SELECT COUNT(*) FROM slots WHERE slot_id BETWEEN 500 AND 517) AS slots_count,
  (SELECT COUNT(*) FROM page WHERE page_id BETWEEN 122 AND 139) AS page_count;
