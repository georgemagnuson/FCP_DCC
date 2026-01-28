-- Orange Forms Creation - 7 Forms (Templates + Form Pages)
-- Using simple direct insertion method

BEGIN;

-- ============================================================================
-- FORM 1: Hot Holding Temperature Log
-- ============================================================================

-- Template for Hot Holding Temperature Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (231, '<noinclude>
This is a template for the Hot Holding Temperature Log form.
</noinclude>

{| class="wikitable"
|-
! Food Item
! Date/Time Placed
! Initial Temperature (°C)
! 2hr Check Temp (°C)
! 4hr Check Temp (°C)
! 6hr Check Temp (°C)
! Corrective Actions
! Pass/Fail
|-
| {{{food_item|}}}
| {{{date_placed|}}}
| {{{initial_temp|}}}
| {{{2hr_temp|}}}
| {{{4hr_temp|}}}
| {{{6hr_temp|}}}
| {{{corrective_actions|}}}
| {{{pass_fail|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (231, 380, '', 1, 'tt:231');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1006, 128, 1, 1, NOW(), 0, 0, 380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1006, 1, 231, 1006);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (128, 10, 'Template:HotHoldingTemperatureLog', 0, 1, RANDOM(), NOW(), 1006, 380);

-- Form Page for Hot Holding Temperature Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (232, '<form>
{{{for template|HotHoldingTemperatureLog}}}
! Food Item:
| <input type="text" name="food_item" size="30" />
|-
! Date/Time Placed:
| <input type="date" name="date_placed" />
|-
! Initial Temperature (°C):
| <input type="number" name="initial_temp" step="0.1" />
|-
! 2hr Check Temperature (°C):
| <input type="number" name="2hr_temp" step="0.1" />
|-
! 4hr Check Temperature (°C):
| <input type="number" name="4hr_temp" step="0.1" />
|-
! 6hr Check Temperature (°C):
| <input type="number" name="6hr_temp" step="0.1" />
|-
! Corrective Actions:
| <textarea name="corrective_actions" rows="3" cols="40"></textarea>
|-
! Pass/Fail:
| <select name="pass_fail"><option>Pass</option><option>Fail</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Temperature_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (232, 650, '', 1, 'tt:232');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1007, 129, 1, 1, NOW(), 0, 0, 650, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1007, 1, 232, 1007);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (129, 0, 'Form:HotHoldingTemperatureLog', 0, 1, RANDOM(), NOW(), 1007, 650);

-- ============================================================================
-- FORM 2: Food Transport Log
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (233, '<noinclude>
This is a template for the Food Transport Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Food Items
! Transport Method
! Departure Temp (°C)
! Arrival Temp (°C)
! Duration (mins)
! In Danger Zone >4hrs?
! Staff
|-
| {{{date|}}}
| {{{food_items|}}}
| {{{transport_method|}}}
| {{{departure_temp|}}}
| {{{arrival_temp|}}}
| {{{duration|}}}
| {{{danger_zone|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (233, 340, '', 1, 'tt:233');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1008, 130, 1, 1, NOW(), 0, 0, 340, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1008, 1, 233, 1008);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (130, 10, 'Template:FoodTransportLog', 0, 1, RANDOM(), NOW(), 1008, 340);

-- Form Page for Food Transport Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (234, '<form>
{{{for template|FoodTransportLog}}}
! Date:
| <input type="date" name="date" />
|-
! Food Items:
| <textarea name="food_items" rows="2" cols="40"></textarea>
|-
! Transport Method/Equipment:
| <input type="text" name="transport_method" size="30" />
|-
! Departure Temperature (°C):
| <input type="number" name="departure_temp" step="0.1" />
|-
! Arrival Temperature (°C):
| <input type="number" name="arrival_temp" step="0.1" />
|-
! Transport Duration (minutes):
| <input type="number" name="duration" />
|-
! In Danger Zone >4 Hours?:
| <select name="danger_zone"><option>No</option><option>Yes - Discard</option></select>
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Transport_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (234, 700, '', 1, 'tt:234');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1009, 131, 1, 1, NOW(), 0, 0, 700, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1009, 1, 234, 1009);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (131, 0, 'Form:FoodTransportLog', 0, 1, RANDOM(), NOW(), 1009, 700);

-- ============================================================================
-- FORM 3: Live Shellfish Display Log
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (235, '<noinclude>
This is a template for the Live Shellfish Display Log form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Temperature (°C)
! Salinity (%)
! Water Changed
! Foreign Matter Removed
! Dead/Broken Removed
! Pass/Fail
! Staff
|-
| {{{datetime|}}}
| {{{temperature|}}}
| {{{salinity|}}}
| {{{water_changed|}}}
| {{{foreign_matter|}}}
| {{{dead_removed|}}}
| {{{pass_fail|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (235, 340, '', 1, 'tt:235');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1010, 132, 1, 1, NOW(), 0, 0, 340, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1010, 1, 235, 1010);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (132, 10, 'Template:LiveShellfish DisplayLog', 0, 1, RANDOM(), NOW(), 1010, 340);

-- Form Page for Live Shellfish Display Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (236, '<form>
{{{for template|LiveShellfishDisplayLog}}}
! Date and Time:
| <input type="datetime-local" name="datetime" />
|-
! Temperature (°C - Must be ≤10°C):
| <input type="number" name="temperature" step="0.1" />
|-
! Salinity (% - Must be 3.3%):
| <input type="number" name="salinity" step="0.1" />
|-
! Water Changed:
| <select name="water_changed"><option>Yes</option><option>No</option></select>
|-
! Foreign Matter Removed:
| <select name="foreign_matter"><option>Yes</option><option>No</option></select>
|-
! Dead/Broken Shellfish Removed:
| <select name="dead_removed"><option>Yes</option><option>No</option></select>
|-
! Pass/Fail:
| <select name="pass_fail"><option>Pass</option><option>Fail</option></select>
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Shellfish_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (236, 750, '', 1, 'tt:236');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1011, 133, 1, 1, NOW(), 0, 0, 750, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1011, 1, 236, 1011);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (133, 0, 'Form:LiveShellfishDisplayLog', 0, 1, RANDOM(), NOW(), 1011, 750);

-- ============================================================================
-- FORM 4: Self-Service Display Checklist
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (237, '<noinclude>
This is a template for the Self-Service Display Checklist form.
</noinclude>

{| class="wikitable"
|-
! Date/Time
! Food Items
! Use-By Date OK?
! Sneeze Guards OK?
! Utensils Clean?
! Temperature OK?
! Pass/Fail
! Staff
|-
| {{{datetime|}}}
| {{{food_items|}}}
| {{{usebydate|}}}
| {{{sneeze_guards|}}}
| {{{utensils|}}}
| {{{temperature|}}}
| {{{pass_fail|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (237, 340, '', 1, 'tt:237');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1012, 134, 1, 1, NOW(), 0, 0, 340, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1012, 1, 237, 1012);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (134, 10, 'Template:SelfServiceDisplayChecklist', 0, 1, RANDOM(), NOW(), 1012, 340);

-- Form Page for Self-Service Display Checklist
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (238, '<form>
{{{for template|SelfServiceDisplayChecklist}}}
! Date and Time:
| <input type="datetime-local" name="datetime" />
|-
! Food Items on Display:
| <textarea name="food_items" rows="2" cols="40"></textarea>
|-
! All Use-By Dates Within Date?:
| <select name="usebydate"><option>Yes</option><option>No</option></select>
|-
! Sneeze Guards/Covers in Place?:
| <select name="sneeze_guards"><option>Yes</option><option>No</option></select>
|-
! Utensils Clean and Properly Positioned?:
| <select name="utensils"><option>Yes</option><option>No</option></select>
|-
! Temperature Compliance (if applicable)?:
| <select name="temperature"><option>Yes</option><option>No</option><option>N/A</option></select>
|-
! Pass/Fail:
| <select name="pass_fail"><option>Pass</option><option>Fail</option></select>
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Display_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (238, 780, '', 1, 'tt:238');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1013, 135, 1, 1, NOW(), 0, 0, 780, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1013, 1, 238, 1013);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (135, 0, 'Form:SelfServiceDisplayChecklist', 0, 1, RANDOM(), NOW(), 1013, 780);

-- ============================================================================
-- FORM 5: Ingredient and Allergen Register
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (239, '<noinclude>
This is a template for the Ingredient and Allergen Register form.
</noinclude>

{| class="wikitable"
|-
! Ingredient/Product
! Supplier
! Allergens
! Food Additives
! Last Checked
! Recipes Using
|-
| {{{ingredient|}}}
| {{{supplier|}}}
| {{{allergens|}}}
| {{{additives|}}}
| {{{last_checked|}}}
| {{{recipes|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (239, 320, '', 1, 'tt:239');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1014, 136, 1, 1, NOW(), 0, 0, 320, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1014, 1, 239, 1014);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (136, 10, 'Template:IngredientAllergenRegister', 0, 1, RANDOM(), NOW(), 1014, 320);

-- Form Page for Ingredient and Allergen Register
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (240, '<form>
{{{for template|IngredientAllergenRegister}}}
! Ingredient/Product Name:
| <input type="text" name="ingredient" size="30" />
|-
! Supplier:
| <input type="text" name="supplier" size="30" />
|-
! Allergens Present (22 major allergens):
| <textarea name="allergens" rows="3" cols="40">Peanuts, Tree nuts, Milk, Eggs, Fish, Shellfish, Sesame, Soy, Mustard, Celery, Sulfites, Lupin, Molluscs, Wheat, Gluten, Crustaceans, Kiwi, Mangoes, Latex, Bananas, Avocados</textarea>
|-
! Food Additives:
| <textarea name="additives" rows="2" cols="40"></textarea>
|-
! Date Last Checked:
| <input type="date" name="last_checked" />
|-
! Recipes Using This Ingredient:
| <textarea name="recipes" rows="2" cols="40"></textarea>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Allergen_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (240, 800, '', 1, 'tt:240');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1015, 137, 1, 1, NOW(), 0, 0, 800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1015, 1, 240, 1015);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (137, 0, 'Form:IngredientAllergenRegister', 0, 1, RANDOM(), NOW(), 1015, 800);

-- ============================================================================
-- FORM 6: Food Label Specifications
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (241, '<noinclude>
This is a template for the Food Label Specifications form.
</noinclude>

{| class="wikitable"
|-
! Product Name
! Label Elements Complete?
! Shelf-Life Calc Method
! Date Mark Type
! Approval Date
! Review Date
! Compliant?
|-
| {{{product_name|}}}
| {{{elements_complete|}}}
| {{{shelf_life_method|}}}
| {{{date_mark_type|}}}
| {{{approval_date|}}}
| {{{review_date|}}}
| {{{compliant|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (241, 360, '', 1, 'tt:241');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1016, 138, 1, 1, NOW(), 0, 0, 360, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1016, 1, 241, 1016);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (138, 10, 'Template:FoodLabelSpecifications', 0, 1, RANDOM(), NOW(), 1016, 360);

-- Form Page for Food Label Specifications
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (242, '<form>
{{{for template|FoodLabelSpecifications}}}
! Product Name:
| <input type="text" name="product_name" size="40" />
|-
! All 11 Mandatory Label Elements Complete?:
| <select name="elements_complete"><option>Yes</option><option>No</option></select>
|-
! Shelf-Life Calculation Method:
| <textarea name="shelf_life_method" rows="2" cols="40"></textarea>
|-
! Date Mark Type (Use-By/Best Before/Baked On-For):
| <select name="date_mark_type"><option>Use-By</option><option>Best Before</option><option>Baked On-For</option></select>
|-
! Label Approval Date:
| <input type="date" name="approval_date" />
|-
! Next Review Date:
| <input type="date" name="review_date" />
|-
! Label Compliant?:
| <select name="compliant"><option>Yes</option><option>No</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:Label_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (242, 750, '', 1, 'tt:242');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1017, 139, 1, 1, NOW(), 0, 0, 750, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1017, 1, 242, 1017);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (139, 0, 'Form:FoodLabelSpecifications', 0, 1, RANDOM(), NOW(), 1017, 750);

-- ============================================================================
-- FORM 7: B2B Customer and Supply Register
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (243, '<noinclude>
This is a template for the B2B Customer and Supply Register form.
</noinclude>

{| class="wikitable"
|-
! Business Name
! Contact Name
! Products Supplied
! Amount
! Date Supplied
! Direct to Consumer Only?
! Product Info Provided?
! Staff
|-
| {{{business_name|}}}
| {{{contact_name|}}}
| {{{products_supplied|}}}
| {{{amount|}}}
| {{{date_supplied|}}}
| {{{direct_consumer|}}}
| {{{product_info|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (243, 360, '', 1, 'tt:243');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1018, 140, 1, 1, NOW(), 0, 0, 360, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1018, 1, 243, 1018);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (140, 10, 'Template:B2BCustomerSupplyRegister', 0, 1, RANDOM(), NOW(), 1018, 360);

-- Form Page for B2B Customer and Supply Register
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (244, '<form>
{{{for template|B2BCustomerSupplyRegister}}}
! Business Name:
| <input type="text" name="business_name" size="40" />
|-
! Contact Name and Details:
| <textarea name="contact_name" rows="2" cols="40"></textarea>
|-
! Products Supplied:
| <textarea name="products_supplied" rows="2" cols="40"></textarea>
|-
! Amount Supplied:
| <input type="text" name="amount" size="30" />
|-
! Date Supplied:
| <input type="date" name="date_supplied" />
|-
! Only Sell Direct to Consumers?:
| <select name="direct_consumer"><option>Yes</option><option>No</option></select>
|-
! Product Information Provided (ingredients, allergens, storage)?:
| <select name="product_info"><option>Yes</option><option>No</option></select>
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Orange:Serving_Selling]] [[Category:B2B_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (244, 800, '', 1, 'tt:244');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1019, 141, 1, 1, NOW(), 0, 0, 800, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1019, 1, 244, 1019);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (141, 0, 'Form:B2BCustomerSupplyRegister', 0, 1, RANDOM(), NOW(), 1019, 800);

COMMIT;

-- Verification
SELECT 'All 7 Orange Forms Created (14 pages total: 7 templates + 7 forms)' as result;
SELECT COUNT(*) as total_form_pages FROM mediawiki.page WHERE page_id BETWEEN 128 AND 141;
SELECT page_id, page_title, page_namespace FROM mediawiki.page WHERE page_id BETWEEN 128 AND 141 ORDER BY page_id;
