-- ============================================================================
-- FCP_DCC MediaWiki Database Insert Script
-- Purpose: Insert Orange, Purple, Red, and Teal section pages
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- Generated: Wed Jan 28 18:12:45 NZDT 2026
-- ============================================================================

-- Start transaction
BEGIN;

-- ============================================================================
-- ORANGE SECTION - Serving & Selling (6 pages)
-- Color Code: Orange
-- ============================================================================


-- ============================================================================
-- Page: FCP:Serving_Selling:Keeping_food_hot
-- Section: Serving_Selling (Orange)
-- IDs: Text=225, Page=122, Revision=1000
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(225, '= Know =

This section covers the key principles for Serving Selling:Keeping food hot.

== Key Points ==
* Understanding the importance of Serving Selling:Keeping food hot
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Keeping food hot
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Keeping food hot procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(225, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 225), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 225)::bytea), 
 'wikitext', 'tt:225');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1000, 122, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1000, 1, 225, 1000);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(122, 6, 'Keeping_food_hot', 0, 1, 1000, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(122, 'smw_id', '122');


-- ============================================================================
-- Page: FCP:Serving_Selling:Transporting_food
-- Section: Serving_Selling (Orange)
-- IDs: Text=226, Page=123, Revision=1001
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(226, '= Know =

This section covers the key principles for Serving Selling:Transporting food.

== Key Points ==
* Understanding the importance of Serving Selling:Transporting food
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Transporting food
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Transporting food procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(226, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 226), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 226)::bytea), 
 'wikitext', 'tt:226');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1001, 123, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1001, 1, 226, 1001);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(123, 6, 'Transporting_food', 0, 1, 1001, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(123, 'smw_id', '123');


-- ============================================================================
-- Page: FCP:Serving_Selling:Displaying_food
-- Section: Serving_Selling (Orange)
-- IDs: Text=227, Page=124, Revision=1002
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(227, '= Know =

This section covers the key principles for Serving Selling:Displaying food.

== Key Points ==
* Understanding the importance of Serving Selling:Displaying food
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Displaying food
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Displaying food procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(227, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 227), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 227)::bytea), 
 'wikitext', 'tt:227');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1002, 124, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1002, 1, 227, 1002);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(124, 6, 'Displaying_food', 0, 1, 1002, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(124, 'smw_id', '124');


-- ============================================================================
-- Page: FCP:Serving_Selling:Allergens
-- Section: Serving_Selling (Orange)
-- IDs: Text=228, Page=125, Revision=1003
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(228, '= Know =

This section covers the key principles for Serving Selling:Allergens.

== Key Points ==
* Understanding the importance of Serving Selling:Allergens
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Allergens
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Allergens procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(228, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 228), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 228)::bytea), 
 'wikitext', 'tt:228');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1003, 125, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1003, 1, 228, 1003);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(125, 6, 'Allergens', 0, 1, 1003, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(125, 'smw_id', '125');


-- ============================================================================
-- Page: FCP:Serving_Selling:Labelling
-- Section: Serving_Selling (Orange)
-- IDs: Text=229, Page=126, Revision=1004
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(229, '= Know =

This section covers the key principles for Serving Selling:Labelling.

== Key Points ==
* Understanding the importance of Serving Selling:Labelling
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:Labelling
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:Labelling procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(229, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 229), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 229)::bytea), 
 'wikitext', 'tt:229');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1004, 126, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1004, 1, 229, 1004);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(126, 6, 'Labelling', 0, 1, 1004, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(126, 'smw_id', '126');


-- ============================================================================
-- Page: FCP:Serving_Selling:B2B
-- Section: Serving_Selling (Orange)
-- IDs: Text=230, Page=127, Revision=1005
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(230, '= Know =

This section covers the key principles for Serving Selling:B2B.

== Key Points ==
* Understanding the importance of Serving Selling:B2B
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Serving Selling:B2B
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Serving Selling:B2B procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Serving_Selling|Serving_Selling]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Serving_Selling]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(230, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 230), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 230)::bytea), 
 'wikitext', 'tt:230');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1005, 127, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1005, 1, 230, 1005);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(127, 6, 'B2B', 0, 1, 1005, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(127, 'smw_id', '127');


-- ============================================================================
-- PURPLE SECTION - Closing (2 pages)
-- Color Code: Purple
-- ============================================================================


-- ============================================================================
-- Page: FCP:Closing:Cleaning_up_and_closing
-- Section: Closing (Purple)
-- IDs: Text=231, Page=128, Revision=1006
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(231, '= Know =

This section covers the key principles for Closing:Cleaning up and closing.

== Key Points ==
* Understanding the importance of Closing:Cleaning up and closing
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Closing:Cleaning up and closing
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Closing:Cleaning up and closing procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Closing|Closing]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Closing]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(231, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 231), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 231)::bytea), 
 'wikitext', 'tt:231');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1006, 128, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1006, 1, 231, 1006);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(128, 6, 'Cleaning_up_and_closing', 0, 1, 1006, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(128, 'smw_id', '128');


-- ============================================================================
-- Page: FCP:Closing:Maintaining_equipment
-- Section: Closing (Purple)
-- IDs: Text=232, Page=129, Revision=1007
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(232, '= Know =

This section covers the key principles for Closing:Maintaining equipment.

== Key Points ==
* Understanding the importance of Closing:Maintaining equipment
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Closing:Maintaining equipment
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Closing:Maintaining equipment procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Closing|Closing]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Closing]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(232, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 232), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 232)::bytea), 
 'wikitext', 'tt:232');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1007, 129, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1007, 1, 232, 1007);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(129, 6, 'Maintaining_equipment', 0, 1, 1007, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(129, 'smw_id', '129');


-- ============================================================================
-- RED SECTION - Troubleshooting (4 pages)
-- Color Code: Red
-- ============================================================================


-- ============================================================================
-- Page: FCP:Troubleshooting:When_something_goes_wrong
-- Section: Troubleshooting (Red)
-- IDs: Text=233, Page=130, Revision=1008
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(233, '= Know =

This section covers the key principles for Troubleshooting:When something goes wrong.

== Key Points ==
* Understanding the importance of Troubleshooting:When something goes wrong
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Troubleshooting:When something goes wrong
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Troubleshooting:When something goes wrong procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Troubleshooting|Troubleshooting]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Troubleshooting]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(233, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 233), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 233)::bytea), 
 'wikitext', 'tt:233');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1008, 130, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1008, 1, 233, 1008);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(130, 6, 'When_something_goes_wrong', 0, 1, 1008, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(130, 'smw_id', '130');


-- ============================================================================
-- Page: FCP:Troubleshooting:Customer_complaints
-- Section: Troubleshooting (Red)
-- IDs: Text=234, Page=131, Revision=1009
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(234, '= Know =

This section covers the key principles for Troubleshooting:Customer complaints.

== Key Points ==
* Understanding the importance of Troubleshooting:Customer complaints
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Troubleshooting:Customer complaints
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Troubleshooting:Customer complaints procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Troubleshooting|Troubleshooting]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Troubleshooting]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(234, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 234), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 234)::bytea), 
 'wikitext', 'tt:234');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1009, 131, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1009, 1, 234, 1009);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(131, 6, 'Customer_complaints', 0, 1, 1009, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(131, 'smw_id', '131');


-- ============================================================================
-- Page: FCP:Troubleshooting:Tracing_your_food
-- Section: Troubleshooting (Red)
-- IDs: Text=235, Page=132, Revision=1010
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(235, '= Know =

This section covers the key principles for Troubleshooting:Tracing your food.

== Key Points ==
* Understanding the importance of Troubleshooting:Tracing your food
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Troubleshooting:Tracing your food
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Troubleshooting:Tracing your food procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Troubleshooting|Troubleshooting]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Troubleshooting]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(235, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 235), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 235)::bytea), 
 'wikitext', 'tt:235');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1010, 132, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1010, 1, 235, 1010);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(132, 6, 'Tracing_your_food', 0, 1, 1010, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(132, 'smw_id', '132');


-- ============================================================================
-- Page: FCP:Troubleshooting:Recalling_your_food
-- Section: Troubleshooting (Red)
-- IDs: Text=236, Page=133, Revision=1011
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(236, '= Know =

This section covers the key principles for Troubleshooting:Recalling your food.

== Key Points ==
* Understanding the importance of Troubleshooting:Recalling your food
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Troubleshooting:Recalling your food
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Troubleshooting:Recalling your food procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Troubleshooting|Troubleshooting]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Troubleshooting]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(236, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 236), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 236)::bytea), 
 'wikitext', 'tt:236');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1011, 133, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1011, 1, 236, 1011);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(133, 6, 'Recalling_your_food', 0, 1, 1011, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(133, 'smw_id', '133');


-- ============================================================================
-- TEAL SECTION - Specialist Cooking Methods (6 pages)
-- Color Code: Teal
-- ============================================================================


-- ============================================================================
-- Page: FCP:Specialist:Making_sushi
-- Section: Specialist (Teal)
-- IDs: Text=237, Page=134, Revision=1012
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(237, '= Know =

This section covers the key principles for Specialist:Making sushi.

== Key Points ==
* Understanding the importance of Specialist:Making sushi
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Making sushi
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Making sushi procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(237, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 237), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 237)::bytea), 
 'wikitext', 'tt:237');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1012, 134, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1012, 1, 237, 1012);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(134, 6, 'Making_sushi', 0, 1, 1012, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(134, 'smw_id', '134');


-- ============================================================================
-- Page: FCP:Specialist:Chinese_roast_duck
-- Section: Specialist (Teal)
-- IDs: Text=238, Page=135, Revision=1013
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(238, '= Know =

This section covers the key principles for Specialist:Chinese roast duck.

== Key Points ==
* Understanding the importance of Specialist:Chinese roast duck
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Chinese roast duck
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Chinese roast duck procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(238, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 238), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 238)::bytea), 
 'wikitext', 'tt:238');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1013, 135, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1013, 1, 238, 1013);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(135, 6, 'Chinese_roast_duck', 0, 1, 1013, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(135, 'smw_id', '135');


-- ============================================================================
-- Page: FCP:Specialist:Doner_kebabs
-- Section: Specialist (Teal)
-- IDs: Text=239, Page=136, Revision=1014
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(239, '= Know =

This section covers the key principles for Specialist:Doner kebabs.

== Key Points ==
* Understanding the importance of Specialist:Doner kebabs
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Doner kebabs
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Doner kebabs procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(239, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 239), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 239)::bytea), 
 'wikitext', 'tt:239');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1014, 136, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1014, 1, 239, 1014);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(136, 6, 'Doner_kebabs', 0, 1, 1014, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(136, 'smw_id', '136');


-- ============================================================================
-- Page: FCP:Specialist:Sous_vide
-- Section: Specialist (Teal)
-- IDs: Text=240, Page=137, Revision=1015
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(240, '= Know =

This section covers the key principles for Specialist:Sous vide.

== Key Points ==
* Understanding the importance of Specialist:Sous vide
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Sous vide
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Sous vide procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(240, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 240), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 240)::bytea), 
 'wikitext', 'tt:240');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1015, 137, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1015, 1, 240, 1015);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(137, 6, 'Sous_vide', 0, 1, 1015, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(137, 'smw_id', '137');


-- ============================================================================
-- Page: FCP:Specialist:Preparing_red_meat
-- Section: Specialist (Teal)
-- IDs: Text=241, Page=138, Revision=1016
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(241, '= Know =

This section covers the key principles for Specialist:Preparing red meat.

== Key Points ==
* Understanding the importance of Specialist:Preparing red meat
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Preparing red meat
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Preparing red meat procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(241, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 241), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 241)::bytea), 
 'wikitext', 'tt:241');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1016, 138, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1016, 1, 241, 1016);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(138, 6, 'Preparing_red_meat', 0, 1, 1016, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(138, 'smw_id', '138');


-- ============================================================================
-- Page: FCP:Specialist:Making_biltong
-- Section: Specialist (Teal)
-- IDs: Text=242, Page=139, Revision=1017
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
(242, '= Know =

This section covers the key principles for Specialist:Making biltong.

== Key Points ==
* Understanding the importance of Specialist:Making biltong
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for Specialist:Making biltong
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of Specialist:Making biltong procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:Specialist|Specialist]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:Specialist]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
(242, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = 242), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = 242)::bytea), 
 'wikitext', 'tt:242');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
(1017, 139, '20260128051245', 1, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
(1017, 1, 242, 1017);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
(139, 6, 'Making_biltong', 0, 1, 1017, 0);

INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
(139, 'smw_id', '139');


-- ============================================================================
-- Summary: 18 pages inserted (6 Orange + 2 Purple + 4 Red + 6 Teal)
-- Starting IDs:
--   Text ID: 225
--   Page ID: 122
--   Revision ID: 1000
-- Ending IDs:
--   Text ID: 242
--   Page ID: 139
--   Revision ID: 1017
-- ============================================================================

-- Commit transaction
COMMIT;

-- Verify insertions
SELECT COUNT(*) as page_count FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= 122;
SELECT COUNT(*) as text_count FROM mediawiki.text WHERE old_id >= 225;

