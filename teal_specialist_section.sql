-- Teal (Specialist) Section - 20 Pages Total
-- 6 Content Pages (209-214) + 6 Templates (215-220 namespace 10) + 6 Forms (221-226 namespace 0)
-- Text IDs: 323-342 (20 entries)
-- Revision IDs: 1098-1117 (20 entries)
-- Categories: Teal:Specialist

BEGIN;

-- ============================================================================
-- CONTENT PAGES (6 pages, IDs 209-214)
-- ============================================================================

-- ============================================================================
-- PAGE 209: FCP:Specialist:Making_sushi (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (323, 'FCP:Specialist:Making_sushi

== Know ==
* Sushi is a specialized food product with unique food safety requirements
* Rice pH (acidity) is critical for sushi safety - must be acidified to prevent pathogen growth
* Non-acidified rice sushi is high-risk and requires specialized cooling and storage procedures
* pH measurement is essential and requires calibrated equipment
* Proper cooling procedures are critical for food safety
* Storage temperature and display time limits must be strictly followed
* Vinegar solution preparation is part of the acidification process
* Different acidification methods have different safety implications

== Do ==
* For acidified rice sushi:
  * Use vinegar solution with proper acidity (minimum 4% acetic acid)
  * Mix vinegar solution with warm cooked rice (60-70°C temperature)
  * Cool acidified rice to room temperature before use
  * Measure and record pH of rice (target: 3.0-4.3)
  * Use calibrated pH meter for accurate measurements
  * Store acidified rice at room temperature (max 24 hours)

* For non-acidified rice sushi (high-risk):
  * Cool cooked rice rapidly to below 5°C within 90 minutes
  * Use proper cooling methods: spread thinly on trays, ice bath, or blast chiller
  * Maintain cold chain storage at 5°C or below
  * Display time at room temperature must not exceed 2 hours total
  * Discard any non-acidified sushi after 2 hours at room temperature
  * Document all temperature measurements

* All sushi:
  * Use fresh, high-quality ingredients
  * Maintain strict personal hygiene and hand washing
  * Use clean, sanitized equipment
  * Prevent cross-contamination with raw seafood
  * Keep detailed records of pH measurements and cooling procedures

== Show ==
* pH measurement records (must show pH 3.0-4.3 or higher for acidified sushi)
* Calibration records for pH meter (last calibration date)
* Cooling logs for non-acidified sushi showing temperature and timing
* Storage temperature records (refrigeration logs if applicable)
* Display time documentation for room temperature storage
* Equipment and utensil sanitation records
* Staff training records on sushi food safety procedures
* Ingredient sourcing documentation for raw seafood', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (323, 2245, '', 1, 'tt:323');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1098, 209, 1, 1, NOW(), 0, 0, 2245, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1098, 1, 323, 1098);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (209, 0, 'FCP:Specialist:Making_sushi', 0, 1, RANDOM(), NOW(), 1098, 2245);

-- ============================================================================
-- PAGE 210: FCP:Specialist:Making_chinese_roast_duck (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (324, 'FCP:Specialist:Making_chinese_roast_duck

== Know ==
* Chinese style roast duck has specialized food safety requirements
* The boiling water dip with vinegar is a critical surface bug decontamination step
* Drying time and temperature must be carefully controlled - drying is essential for safety
* Drying process takes approximately 4-6 hours maximum above 5°C
* Internal temperature must not exceed 25°C during drying to prevent pathogen growth
* Skin integrity maintenance is critical - damaged skin increases contamination risk
* Proper moisture evaporation is essential for shelf-stability
* Temperature monitoring throughout the process is critical

== Do ==
* Prepare duck: clean thoroughly and remove excess moisture
* Conduct boiling water dip: immerse in boiling water with vinegar solution for 1-2 minutes
  * This kills surface pathogens and prepares skin for drying
  * Water temperature must be at least 100°C
  * Include white vinegar (4-5% acetic acid) in water
* Cool duck slightly after dipping (2-3 minutes) before drying
* Dry duck using proper equipment:
  * Maximum drying time: 6 hours at temperatures above 5°C
  * Internal temperature must not exceed 25°C (use temperature probe)
  * Ensure adequate air circulation during drying
  * Monitor internal temperature at start and mid-way through drying
* Maintain skin integrity throughout - avoid punctures or damage
* Cool dried duck to room temperature before storage
* Store in cool, dry conditions (below 15°C if possible)
* Document all temperature measurements and timing

== Show ==
* Temperature monitoring records:
  * Start of drying: internal temperature recorded
  * Mid-way through drying: internal temperature recorded
  * Maximum internal temperature must not exceed 25°C
* Drying time documentation (start time, finish time)
* Drying equipment maintenance records
* Equipment sanitation records
* Staff training documentation on Chinese roast duck procedures
* Supplier records for duck sourcing
* Storage condition records (temperature and humidity)', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (324, 2132, '', 1, 'tt:324');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1099, 210, 1, 1, NOW(), 0, 0, 2132, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1099, 1, 324, 1099);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (210, 0, 'FCP:Specialist:Making_chinese_roast_duck', 0, 1, RANDOM(), NOW(), 1099, 2132);

-- ============================================================================
-- PAGE 211: FCP:Specialist:Making_doner_kebabs (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (325, 'FCP:Specialist:Making_doner_kebabs

== Know ==
* Doner kebab is a specialized product with specific preparation requirements
* Fresh meat is essential - kebab must be made from fresh (not pre-cooked) meat
* Thorough cooking is essential before any meat is sliced from the kebab
* The vertical grill cooking method requires proper temperature management
* Heating element positioning is critical for even cooking and safety
* Meat shaving and collection procedures must prevent cross-contamination
* Temperature verification ensures food safety
* Proper cooling and storage of cooked meat is necessary

== Do ==
* Source fresh meat appropriate for doner kebab:
  * Lamb, beef, or chicken (depending on product)
  * Fresh from approved supplier
  * Stored at 5°C or below until preparation
* Prepare meat mixture: season and shape on vertical spit
* Cook on vertical grill:
  * Ensure heating element is positioned correctly
  * Monitor temperature during cooking
  * Meat must reach internal temperature of 75°C minimum (for safety)
  * Use meat thermometer to verify temperature
* Allow outer surface to develop crust while maintaining safety
* Shave cooked meat from kebab:
  * Use clean, sanitized shaving tool
  * Shaved meat goes directly into serving container
  * Prevent shaved meat from falling on floor or contaminated surfaces
* Collect shaved meat safely:
  * Use clean containers
  * Transfer to serving area maintaining temperature control
  * Keep warm at 65°C or above for service
* Record cooking temperatures and times

== Show ==
* Meat supplier documentation and approval records
* Cooking logs with:
  * Date and time of preparation
  * Type of meat used
  * Internal temperature verification (75°C minimum)
  * Cooking time and method
* Temperature monitoring records during service (65°C minimum)
* Equipment maintenance and sanitation records
* Staff training records on doner kebab preparation
* Daily cleaning and sanitizing procedures documentation', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (325, 2024, '', 1, 'tt:325');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1100, 211, 1, 1, NOW(), 0, 0, 2024, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1100, 1, 325, 1100);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (211, 0, 'FCP:Specialist:Making_doner_kebabs', 0, 1, RANDOM(), NOW(), 1100, 2024);

-- ============================================================================
-- PAGE 212: FCP:Specialist:Cooking_sous_vide (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (326, 'FCP:Specialist:Cooking_sous_vide

== Know ==
* Sous vide is a high-risk cooking method - mistakes can cause serious illness or death
* ONLY appropriate for whole muscle cuts of meat and poultry (NOT mechanically tenderized, ground, or organ meats)
* Vacuum sealing is essential - any leakage is unsafe
* Water bath temperature control is critical - temperatures must be precise and maintained
* This is a specialized technique requiring strict adherence to procedures
* Temperature and time combinations are not flexible - they must match approved tables
* Different meat types require different temperature/time combinations
* Monthly calibration of water bath equipment is mandatory

== Do ==
* Determine cooking method applicability:
  * ONLY use for: whole muscle beef, lamb, venison (red meat cuts)
  * ONLY use for: whole muscle poultry breast, thigh (poultry cuts)
  * NEVER use for: ground meat, minced meat, mechanically tenderized, organ meats

* Prepare food for vacuum sealing:
  * Season as desired (salt, spices, marinades acceptable)
  * Portion into individual servings
  * Ensure no excess liquid that could compromise seal

* Vacuum seal food:
  * Use proper vacuum sealing equipment
  * Verify complete seal - no air pockets
  * Check seal integrity before cooking
  * Any damaged or improperly sealed packages must be discarded

* Prepare water bath:
  * Calibrate temperature equipment monthly with certified standards
  * Pre-heat water bath to exact required temperature
  * Maintain temperature ±1°C throughout cooking
  * Use precision thermometer to verify temperature

* Cook using approved time/temperature table:
  * Red meat: minimum 55°C for specified time (refer to approved table)
  * Poultry: minimum 60°C for specified time (refer to approved table)
  * Cooking times vary by thickness and target doneness
  * Do NOT reduce time - follow approved table exactly

* Cool cooked food safely:
  * Remove from water bath carefully
  * Cool immediately in ice bath if not serving immediately
  * If serving hot, maintain above 65°C
  * If serving cold, cool to below 5°C within 90 minutes

* Maintain detailed records:
  * Date and time of cooking
  * Food type and cut
  * Weight/thickness
  * Temperature setting used
  * Actual temperature readings during cooking
  * Cooking start and finish times
  * Any temperature deviations and corrective actions

== Show ==
* Approved time/temperature holding table (for specific food types being cooked)
* Water bath calibration records (monthly calibration verification)
* Internal temperature logs (showing temperature maintained throughout cooking)
* Vacuum seal integrity check records
* Cooking logs with full documentation (date, time, temperature, duration, food type)
* Equipment maintenance and sanitation records
* Staff training records (must demonstrate understanding of high-risk nature)
* Written procedure documentation for sous vide cooking
* Evidence of staff competency assessment', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (326, 2863, '', 1, 'tt:326');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1101, 212, 1, 1, NOW(), 0, 0, 2863, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1101, 1, 326, 1101);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (212, 0, 'FCP:Specialist:Cooking_sous_vide', 0, 1, RANDOM(), NOW(), 1101, 2863);

-- ============================================================================
-- PAGE 213: FCP:Specialist:Preparing_red_meat_raw (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (327, 'FCP:Specialist:Preparing_red_meat_raw

== Know ==
* Only beef, lamb, and venison may be prepared for lightly-cooked or raw consumption (NOT pork, poultry, other meats)
* Surface decontamination of raw meat is the critical food safety step
* Surface pathogens (mainly E. coli) must be eliminated before serving raw/lightly-cooked
* Three approved decontamination methods exist: searing, blanching, or sanitizing solution
* Decontaminated meat must be used within 48 hours
* Freezing prior to serving raw is not approved for this procedure
* Cross-contamination with other raw meat is still a risk
* This is a high-risk procedure requiring strict controls

== Do ==
* Source meat:
  * Beef, lamb, or venison only (NO pork, poultry, or other meats)
  * From approved supplier
  * Fresh meat (not previously frozen unless specifically approved)

* Select one decontamination method:

Method 1: Searing
  * Heat oil/fat in pan to high temperature (180-200°C minimum)
  * Sear all exterior surfaces of meat for 1-2 minutes per side
  * Meat interior will remain raw/rare
  * Remove from heat and cool
  * Inspect for any areas not seared - resear if needed

Method 2: Blanching
  * Bring salted water to boil (10g salt per liter)
  * Immerse meat for 1-2 minutes (surfaces submerged)
  * Remove and cool immediately in ice bath
  * Drain thoroughly

Method 3: Sanitizing Solution
  * Use approved sanitizing solution (e.g., 200ppm chlorine solution)
  * Immerse meat for required contact time (per sanitizer instructions)
  * Remove and rinse with potable water
  * Drain thoroughly

* After decontamination:
  * Cool to safe temperature below 5°C if not serving immediately
  * Slice as desired for serving
  * Store below 5°C if holding before service
  * Use within 48 hours of decontamination
  * Keep separate from other raw meat preparations

* Maintain strict records of:
  * Date and time of decontamination
  * Method used (searing, blanching, or solution)
  * Temperature and duration details
  * Any deviations from procedure
  * Usage date/time
  * Customer notification of raw meat status (if applicable)

== Show ==
* Meat supplier approval documentation
* Decontamination procedure documentation for chosen method:
  * Temperature records (for searing method)
  * Blanching water preparation and timing records
  * Sanitizing solution concentration records (if applicable)
* Daily decontamination logs showing:
  * Date and time
  * Decontamination method used
  * Quantity of meat processed
  * Staff member performing procedure
* Storage temperature records (maintained below 5°C)
* Usage records (within 48 hours of decontamination)
* Staff training on raw meat handling procedures
* Customer information materials (if serving raw/lightly-cooked)
* Equipment sanitation records', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (327, 2598, '', 1, 'tt:327');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1102, 213, 1, 1, NOW(), 0, 0, 2598, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1102, 1, 327, 1102);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (213, 0, 'FCP:Specialist:Preparing_red_meat_raw', 0, 1, RANDOM(), NOW(), 1102, 2598);

-- ============================================================================
-- PAGE 214: FCP:Specialist:Making_biltong (namespace 0, content page)
-- ============================================================================

INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (328, 'FCP:Specialist:Making_biltong

== Know ==
* Biltong is a dried meat product with specific food safety requirements
* ONLY red meat from registered New Zealand meat processor may be used
* Water activity below 0.85 is essential for food safety and shelf-stability
* Marinade salt and vinegar content are critical for safety
* Marinating must occur at 5°C or below
* Dedicated drying space prevents cross-contamination with other products
* Drying time and equipment settings are critical
* Shelf-life is determined by water activity measurement
* Biltong safety depends on multiple control points working together

== Do ==
* Source meat:
  * ONLY red meat (beef, lamb, venison)
  * ONLY from registered New Zealand meat processor
  * Fresh meat in good condition

* Prepare marinade:
  * Minimum 30g salt per kg of meat
  * Minimum 30g vinegar per kg of meat (5% acetic acid)
  * Total marinade volume sufficient to submerge meat
  * May add spices (optional): coriander, pepper, garlic, etc.

* Marinate meat:
  * Submerge meat completely in marinade
  * Temperature must be 5°C or below throughout marination
  * Marinate minimum 10 hours (typically 12-24 hours)
  * Stir/rotate meat occasionally to ensure even marinating
  * Document marinating start and finish times

* Prepare for drying:
  * Remove meat from marinade
  * Pat dry with clean towels
  * Trim any excess fat (fat can become rancid)
  * Arrange on drying racks ensuring good air circulation

* Dry meat in dedicated space:
  * Use dedicated drying area (no cross-contamination with other products)
  * Temperature: 15-25°C (optimal around 20°C)
  * Humidity: 45-65% (controlled environment ideal)
  * Air circulation: good ventilation without direct sun/heat
  * Drying time: typically 5-10 days (depends on thickness and environment)
  * Monitor for mold growth - remove any affected meat
  * Document drying conditions and dates

* Verify safety:
  * Measure water activity when dry (must be below 0.85 for safety)
  * Use calibrated water activity meter
  * Test at least 3 samples per batch
  * Record all water activity measurements
  * If above 0.85, continue drying and retest

* Package and storage:
  * Cool to room temperature before packaging
  * Package in airtight containers
  * Store in cool, dry conditions (below 15°C ideal)
  * Determine shelf-life based on water activity level
  * Label with date dried and best-before date
  * Document all batch information

== Show ==
* Meat supplier registration verification (registered NZ processor)
* Marinade preparation records:
  * Date prepared
  * Salt quantity (minimum 30g per kg)
  * Vinegar quantity (minimum 30g per kg)
  * Temperature control verification (≤5°C)
* Marinating logs:
  * Meat quantity
  * Start date/time
  * Finish date/time
  * Temperature checks (at least start and end)
* Drying logs:
  * Start date/time
  * Environmental conditions (temperature, humidity)
  * Daily monitoring notes
  * Finish date/time
  * Any problems encountered and solutions
* Water activity test results:
  * Test date
  * Meter calibration verification
  * Water activity values (must be <0.85)
  * Number of samples tested per batch
* Equipment maintenance records (water activity meter calibration)
* Batch records linking all information
* Storage temperature records
* Staff training on biltong procedures and food safety', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (328, 2947, '', 1, 'tt:328');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1103, 214, 1, 1, NOW(), 0, 0, 2947, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1103, 1, 328, 1103);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (214, 0, 'FCP:Specialist:Making_biltong', 0, 1, RANDOM(), NOW(), 1103, 2947);

-- ============================================================================
-- FORM TEMPLATES (6 templates, IDs 215-220, namespace 10)
-- ============================================================================

-- PAGE 215: Template:Sushi_pH_Record
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (329, '<noinclude>
This is a template for the Sushi pH Record form.
</noinclude>

{| class="wikitable"
|-
! Date
! Rice Type
! pH Reading
! Meter Calibration
! Cooling Method
! Storage Temp
! Display Time
! Staff
|-
| {{{date|}}}
| {{{rice_type|}}}
| {{{ph_reading|}}}
| {{{meter_calibration|}}}
| {{{cooling_method|}}}
| {{{storage_temp|}}}
| {{{display_time|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (329, 398, '', 1, 'tt:329');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1104, 215, 1, 1, NOW(), 0, 0, 398, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1104, 1, 329, 1104);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (215, 10, 'Template:Sushi_pH_Record', 0, 1, RANDOM(), NOW(), 1104, 398);

-- PAGE 216: Template:Roast_Duck_Temperature_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (330, '<noinclude>
This is a template for the Roast Duck Temperature Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Start Time
! Finish Time
! Start Temp
! Mid-Drying Temp
! Max Temp Allowed
! Drying Duration
! Equipment Used
! Staff
|-
| {{{date|}}}
| {{{start_time|}}}
| {{{finish_time|}}}
| {{{start_temp|}}}
| {{{mid_temp|}}}
| {{{max_temp|}}}
| {{{duration|}}}
| {{{equipment|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (330, 430, '', 1, 'tt:330');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1105, 216, 1, 1, NOW(), 0, 0, 430, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1105, 1, 330, 1105);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (216, 10, 'Template:Roast_Duck_Temperature_Log', 0, 1, RANDOM(), NOW(), 1105, 430);

-- PAGE 217: Template:Doner_Kebab_Cooking_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (331, '<noinclude>
This is a template for the Doner Kebab Cooking Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Meat Type
! Cook Start
! Cook Finish
! Internal Temp
! Min Temp Req
! Service Temp
! Staff
|-
| {{{date|}}}
| {{{meat_type|}}}
| {{{cook_start|}}}
| {{{cook_finish|}}}
| {{{internal_temp|}}}
| {{{min_temp|}}}
| {{{service_temp|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (331, 390, '', 1, 'tt:331');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1106, 217, 1, 1, NOW(), 0, 0, 390, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1106, 1, 331, 1106);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (217, 10, 'Template:Doner_Kebab_Cooking_Log', 0, 1, RANDOM(), NOW(), 1106, 390);

-- PAGE 218: Template:Sous_Vide_Cooking_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (332, '<noinclude>
This is a template for the Sous Vide Cooking Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Food Type
! Thickness
! Target Temp
! Actual Temp
! Cook Time
! Seal Check
! Calibration
! Staff
|-
| {{{date|}}}
| {{{food_type|}}}
| {{{thickness|}}}
| {{{target_temp|}}}
| {{{actual_temp|}}}
| {{{cook_time|}}}
| {{{seal_check|}}}
| {{{calibration|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (332, 390, '', 1, 'tt:332');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1107, 218, 1, 1, NOW(), 0, 0, 390, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1107, 1, 332, 1107);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (218, 10, 'Template:Sous_Vide_Cooking_Log', 0, 1, RANDOM(), NOW(), 1107, 390);

-- PAGE 219: Template:Raw_Meat_Decontamination_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (333, '<noinclude>
This is a template for the Raw Meat Decontamination Log form.
</noinclude>

{| class="wikitable"
|-
! Date
! Meat Type
! Quantity
! Method
! Temperature
! Duration
! Staff
! Used Within 48hrs
|-
| {{{date|}}}
| {{{meat_type|}}}
| {{{quantity|}}}
| {{{method|}}}
| {{{temperature|}}}
| {{{duration|}}}
| {{{staff|}}}
| {{{used_within_48hrs|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (333, 396, '', 1, 'tt:333');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1108, 219, 1, 1, NOW(), 0, 0, 396, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1108, 1, 333, 1108);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (219, 10, 'Template:Raw_Meat_Decontamination_Log', 0, 1, RANDOM(), NOW(), 1108, 396);

-- PAGE 220: Template:Biltong_Production_Record
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (334, '<noinclude>
This is a template for the Biltong Production Record form.
</noinclude>

{| class="wikitable"
|-
! Date Started
! Meat Type
! Quantity
! Salt (g/kg)
! Vinegar (g/kg)
! Marinade Temp
! Marinate Hours
! Drying Temp
! Drying Days
! Water Activity
! Staff
|-
| {{{date_started|}}}
| {{{meat_type|}}}
| {{{quantity|}}}
| {{{salt_qty|}}}
| {{{vinegar_qty|}}}
| {{{marinade_temp|}}}
| {{{marinate_hours|}}}
| {{{drying_temp|}}}
| {{{drying_days|}}}
| {{{water_activity|}}}
| {{{staff|}}}
|}

__NOTOC__', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (334, 448, '', 1, 'tt:334');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1109, 220, 1, 1, NOW(), 0, 0, 448, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1109, 1, 334, 1109);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (220, 10, 'Template:Biltong_Production_Record', 0, 1, RANDOM(), NOW(), 1109, 448);

-- ============================================================================
-- FORM PAGES (6 forms, IDs 221-226, namespace 0)
-- ============================================================================

-- PAGE 221: Form:Sushi_pH_Record
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (335, '<form>
{{{for template|Sushi_pH_Record}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Rice Type:
| <select name="rice_type"><option>Acidified (vinegar)</option><option>Non-acidified</option></select>
|-
! pH Reading:
| <input type="number" name="ph_reading" min="0" max="14" step="0.1" />
|-
! pH Meter Last Calibrated:
| <input type="date" name="meter_calibration" />
|-
! Cooling Method (if non-acidified):
| <select name="cooling_method"><option>Spread on trays</option><option>Ice bath</option><option>Blast chiller</option><option>N/A - acidified</option></select>
|-
! Storage Temperature:
| <input type="number" name="storage_temp" /> °C
|-
! Display Time at Room Temperature:
| <input type="number" name="display_time" /> minutes
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Sushi_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (335, 1056, '', 1, 'tt:335');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1110, 221, 1, 1, NOW(), 0, 0, 1056, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1110, 1, 335, 1110);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (221, 0, 'Form:Sushi_pH_Record', 0, 1, RANDOM(), NOW(), 1110, 1056);

-- PAGE 222: Form:Roast_Duck_Temperature_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (336, '<form>
{{{for template|Roast_Duck_Temperature_Log}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Start Time:
| <input type="time" name="start_time" />
|-
! Finish Time:
| <input type="time" name="finish_time" />
|-
! Internal Temperature at Start:
| <input type="number" name="start_temp" /> °C
|-
! Internal Temperature (Mid-Drying):
| <input type="number" name="mid_temp" /> °C
|-
! Maximum Temperature Allowed:
| <input type="number" name="max_temp" value="25" /> °C (must not exceed)
|-
! Drying Duration:
| <input type="number" name="duration" /> minutes (max 6 hours = 360 min)
|-
! Equipment Used:
| <input type="text" name="equipment" size="30" />
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Roast_Duck_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (336, 1032, '', 1, 'tt:336');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1111, 222, 1, 1, NOW(), 0, 0, 1032, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1111, 1, 336, 1111);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (222, 0, 'Form:Roast_Duck_Temperature_Log', 0, 1, RANDOM(), NOW(), 1111, 1032);

-- PAGE 223: Form:Doner_Kebab_Cooking_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (337, '<form>
{{{for template|Doner_Kebab_Cooking_Log}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Meat Type:
| <select name="meat_type"><option>Lamb</option><option>Beef</option><option>Chicken</option></select>
|-
! Cooking Start Time:
| <input type="time" name="cook_start" />
|-
! Cooking Finish Time:
| <input type="time" name="cook_finish" />
|-
! Internal Temperature Reached:
| <input type="number" name="internal_temp" /> °C
|-
! Minimum Temperature Required:
| <input type="number" name="min_temp" value="75" /> °C
|-
! Service Temperature Maintained:
| <input type="number" name="service_temp" /> °C (must be 65°C or above)
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Doner_Kebab_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (337, 1023, '', 1, 'tt:337');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1112, 223, 1, 1, NOW(), 0, 0, 1023, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1112, 1, 337, 1112);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (223, 0, 'Form:Doner_Kebab_Cooking_Log', 0, 1, RANDOM(), NOW(), 1112, 1023);

-- PAGE 224: Form:Sous_Vide_Cooking_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (338, '<form>
{{{for template|Sous_Vide_Cooking_Log}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Food Type:
| <select name="food_type"><option>Beef - red meat</option><option>Lamb - red meat</option><option>Venison - red meat</option><option>Poultry - chicken breast</option><option>Poultry - chicken thigh</option></select>
|-
! Meat Thickness:
| <input type="number" name="thickness" step="0.1" /> cm
|-
! Target Temperature:
| <input type="number" name="target_temp" /> °C (min 55°C red meat, 60°C poultry)
|-
! Actual Water Bath Temperature Maintained:
| <input type="number" name="actual_temp" /> °C
|-
! Cooking Time:
| <input type="time" name="cook_time" />
|-
! Vacuum Seal Check:
| <select name="seal_check"><option>Pass - completely sealed</option><option>Fail - air pockets detected</option></select>
|-
! Water Bath Last Calibrated:
| <input type="date" name="calibration" /> (must be within 30 days)
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Sous_Vide_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (338, 1289, '', 1, 'tt:338');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1113, 224, 1, 1, NOW(), 0, 0, 1289, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1113, 1, 338, 1113);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (224, 0, 'Form:Sous_Vide_Cooking_Log', 0, 1, RANDOM(), NOW(), 1113, 1289);

-- PAGE 225: Form:Raw_Meat_Decontamination_Log
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (339, '<form>
{{{for template|Raw_Meat_Decontamination_Log}}}
|-
! Date:
| <input type="date" name="date" />
|-
! Meat Type (beef, lamb, or venison only):
| <select name="meat_type"><option>Beef</option><option>Lamb</option><option>Venison</option></select>
|-
! Quantity:
| <input type="number" name="quantity" step="0.1" /> kg
|-
! Decontamination Method:
| <select name="method"><option>Searing (high heat)</option><option>Blanching (boiling water)</option><option>Sanitizing solution (chemical)</option></select>
|-
! Temperature (if searing):
| <input type="number" name="temperature" /> °C
|-
! Duration:
| <input type="number" name="duration" /> minutes
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
|-
! Used Within 48 Hours:
| <select name="used_within_48hrs"><option>Yes</option><option>No</option><option>Not yet used</option></select>
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Raw_Meat_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (339, 1134, '', 1, 'tt:339');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1114, 225, 1, 1, NOW(), 0, 0, 1134, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1114, 1, 339, 1114);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (225, 0, 'Form:Raw_Meat_Decontamination_Log', 0, 1, RANDOM(), NOW(), 1114, 1134);

-- PAGE 226: Form:Biltong_Production_Record
INSERT INTO mediawiki.text (old_id, old_text, old_flags)
VALUES (340, '<form>
{{{for template|Biltong_Production_Record}}}
|-
! Date Started:
| <input type="date" name="date_started" />
|-
! Meat Type (red meat only):
| <select name="meat_type"><option>Beef</option><option>Lamb</option><option>Venison</option></select>
|-
! Quantity:
| <input type="number" name="quantity" step="0.1" /> kg
|-
! Salt Quantity (minimum 30g per kg):
| <input type="number" name="salt_qty" /> grams
|-
! Vinegar Quantity (minimum 30g per kg):
| <input type="number" name="vinegar_qty" /> grams
|-
! Marinade Temperature (must be ≤5°C):
| <input type="number" name="marinade_temp" /> °C
|-
! Marinating Duration:
| <input type="number" name="marinate_hours" /> hours (minimum 10 hours)
|-
! Drying Temperature:
| <input type="number" name="drying_temp" /> °C (typically 15-25°C)
|-
! Drying Duration:
| <input type="number" name="drying_days" /> days (typically 5-10 days)
|-
! Final Water Activity:
| <input type="number" name="water_activity" min="0" max="1" step="0.01" /> (must be <0.85)
|-
! Staff Member:
| <input type="text" name="staff" size="30" />
{{{end form}}}
</form>

[[Category:Forms]] [[Category:Teal:Specialist]] [[Category:Biltong_Records]]', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address)
VALUES (340, 1317, '', 1, 'tt:340');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1)
VALUES (1115, 226, 1, 1, NOW(), 0, 0, 1317, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin)
VALUES (1115, 1, 340, 1115);

INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_random, page_touched, page_latest, page_len)
VALUES (226, 0, 'Form:Biltong_Production_Record', 0, 1, RANDOM(), NOW(), 1115, 1317);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check total pages created
SELECT COUNT(*) as total_pages_created FROM mediawiki.page WHERE page_id BETWEEN 209 AND 226;

-- Check text entries
SELECT COUNT(*) as total_text_entries FROM mediawiki.text WHERE old_id BETWEEN 323 AND 342;

-- Check revisions
SELECT COUNT(*) as total_revisions FROM mediawiki.revision WHERE rev_id BETWEEN 1098 AND 1117;

-- List all created pages
SELECT page_id, page_namespace, page_title, page_len
FROM mediawiki.page
WHERE page_id BETWEEN 209 AND 226
ORDER BY page_id;

COMMIT;
