-- FCP MediaWiki Pages Insert Script - Final Corrected Version
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- 18 pages: 6 Orange + 2 Purple + 4 Red + 6 Teal
-- Page IDs: 122-139, Revision IDs: 1000-1017, Text IDs: 225-242

BEGIN;

-- ============================================================================
-- ORANGE PAGES (6 pages)
-- ============================================================================

-- Orange Page 1: Keeping food hot (Page ID: 122)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (225, 'Content for Keeping food hot', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (225, 35, '', 1, 'tt:225');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1000, 122, '2024-01-01 10:00:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 225);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1000, 1, 225, 1000);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (122, 0, 'Keeping_food_hot', 1, 1000);

-- Orange Page 2: Transporting food (Page ID: 123)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (226, 'Content for Transporting food', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (226, 36, '', 1, 'tt:226');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1001, 123, '2024-01-01 10:01:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 226);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1001, 1, 226, 1001);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (123, 0, 'Transporting_food', 1, 1001);

-- Orange Page 3: Displaying food (Page ID: 124)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (227, 'Content for Displaying food', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (227, 33, '', 1, 'tt:227');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1002, 124, '2024-01-01 10:02:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 227);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1002, 1, 227, 1002);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (124, 0, 'Displaying_food', 1, 1002);

-- Orange Page 4: Allergens (Page ID: 125)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (228, 'Content for Allergens', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (228, 26, '', 1, 'tt:228');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1003, 125, '2024-01-01 10:03:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 228);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1003, 1, 228, 1003);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (125, 0, 'Allergens', 1, 1003);

-- Orange Page 5: Labelling (Page ID: 126)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (229, 'Content for Labelling', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (229, 27, '', 1, 'tt:229');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1004, 126, '2024-01-01 10:04:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 229);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1004, 1, 229, 1004);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (126, 0, 'Labelling', 1, 1004);

-- Orange Page 6: B2B Sales (Page ID: 127)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (230, 'Content for B2B Sales', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (230, 28, '', 1, 'tt:230');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1005, 127, '2024-01-01 10:05:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 230);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1005, 1, 230, 1005);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (127, 0, 'B2B_Sales', 1, 1005);

-- ============================================================================
-- PURPLE PAGES (2 pages)
-- ============================================================================

-- Purple Page 1: Cleaning up and closing (Page ID: 128)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (231, 'Content for Cleaning up and closing', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (231, 42, '', 1, 'tt:231');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1006, 128, '2024-01-01 10:06:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 231);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1006, 1, 231, 1006);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (128, 0, 'Cleaning_up_closing', 1, 1006);

-- Purple Page 2: Maintaining equipment (Page ID: 129)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (232, 'Content for Maintaining equipment', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (232, 38, '', 1, 'tt:232');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1007, 129, '2024-01-01 10:07:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 232);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1007, 1, 232, 1007);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (129, 0, 'Maintaining_equipment', 1, 1007);

-- ============================================================================
-- RED PAGES (4 pages)
-- ============================================================================

-- Red Page 1: When something goes wrong (Page ID: 130)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (233, 'Content for When something goes wrong', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (233, 43, '', 1, 'tt:233');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1008, 130, '2024-01-01 10:08:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 233);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1008, 1, 233, 1008);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (130, 0, 'Something_goes_wrong', 1, 1008);

-- Red Page 2: Dealing with complaints (Page ID: 131)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (234, 'Content for Dealing with complaints', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (234, 40, '', 1, 'tt:234');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1009, 131, '2024-01-01 10:09:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 234);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1009, 1, 234, 1009);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (131, 0, 'Dealing_complaints', 1, 1009);

-- Red Page 3: Tracing food (Page ID: 132)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (235, 'Content for Tracing food', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (235, 28, '', 1, 'tt:235');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1010, 132, '2024-01-01 10:10:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 235);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1010, 1, 235, 1010);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (132, 0, 'Tracing_food', 1, 1010);

-- Red Page 4: Recalling food (Page ID: 133)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (236, 'Content for Recalling food', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (236, 30, '', 1, 'tt:236');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1011, 133, '2024-01-01 10:11:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 236);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1011, 1, 236, 1011);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (133, 0, 'Recalling_food', 1, 1011);

-- ============================================================================
-- TEAL PAGES (6 pages)
-- ============================================================================

-- Teal Page 1: Making sushi (Page ID: 134)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (237, 'Content for Making sushi', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (237, 29, '', 1, 'tt:237');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1012, 134, '2024-01-01 10:12:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 237);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1012, 1, 237, 1012);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (134, 0, 'Making_sushi', 1, 1012);

-- Teal Page 2: Chinese roast duck (Page ID: 135)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (238, 'Content for Chinese roast duck', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (238, 36, '', 1, 'tt:238');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1013, 135, '2024-01-01 10:13:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 238);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1013, 1, 238, 1013);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (135, 0, 'Chinese_roast_duck', 1, 1013);

-- Teal Page 3: Doner kebabs (Page ID: 136)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (239, 'Content for Doner kebabs', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (239, 30, '', 1, 'tt:239');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1014, 136, '2024-01-01 10:14:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 239);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1014, 1, 239, 1014);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (136, 0, 'Doner_kebabs', 1, 1014);

-- Teal Page 4: Sous vide (Page ID: 137)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (240, 'Content for Sous vide', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (240, 27, '', 1, 'tt:240');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1015, 137, '2024-01-01 10:15:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 240);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1015, 1, 240, 1015);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (137, 0, 'Sous_vide', 1, 1015);

-- Teal Page 5: Preparing red meat (Page ID: 138)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (241, 'Content for Preparing red meat', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (241, 35, '', 1, 'tt:241');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1016, 138, '2024-01-01 10:16:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 241);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1016, 1, 241, 1016);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (138, 0, 'Preparing_red_meat', 1, 1016);

-- Teal Page 6: Making biltong (Page ID: 139)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (242, 'Content for Making biltong', 'utf-8');
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (242, 31, '', 1, 'tt:242');
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_user_text, rev_comment, rev_content_model, rev_content_format, rev_sha1, rev_text_id) VALUES (1017, 139, '2024-01-01 10:17:00', 0, 'System', 'Initial content', 'wikitext', 'text/x-wiki', '', 242);
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (1017, 1, 242, 1017);
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_content_model, page_latest) VALUES (139, 0, 'Making_biltong', 1, 1017);

COMMIT;

-- Verify insertions
SELECT 'Text records' as record_type, COUNT(*) FROM mediawiki.text WHERE old_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Content records', COUNT(*) FROM mediawiki.content WHERE content_id BETWEEN 225 AND 242
UNION ALL
SELECT 'Revision records', COUNT(*) FROM mediawiki.revision WHERE rev_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Slots records', COUNT(*) FROM mediawiki.slots WHERE slot_revision_id BETWEEN 1000 AND 1017
UNION ALL
SELECT 'Page records', COUNT(*) FROM mediawiki.page WHERE page_id BETWEEN 122 AND 139;
