-- Properly populate empty Dark Blue pages with full data structure
BEGIN;

-- Page 71: Checking the plan is working well (Plan_monitoring)
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (152, 'FCP:Setting Up - Checking the plan is working well

== Know ==
* It is your responsibility as the operator to regularly check that food safety and suitability is being well managed
* You or one of your staff need to be your own internal verifier
* Self-verifying is important - if you wait for someone else to tell you something has gone wrong, it may become costly

== Do ==
* Set up procedures for regularly checking that you and your staff are making safe and suitable food
* Check that staff understand and follow the rules in the Do sections
* Ensure procedures are being followed and are effective
* Ensure facilities and equipment remain suitable
* Ensure staff have equipment and information to handle food safely
* Keep staff committed to food safety
* Follow procedures in the When something goes wrong card if you identify problems

== Show ==
* Show your verifier how you check that your procedures are working well
* Records showing the results of checks you have made when self-verifying', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (152, 650, '', 1, 'tt:152');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES (186, 71, 1, 1, NOW(), 0, 0, 650, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (186, 1, 152, 186);

UPDATE mediawiki.page SET page_latest = 186, page_len = 650, page_touched = NOW() WHERE page_id = 71;

-- Page 73: Training and competency
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (153, 'FCP:Setting Up - Training and competency

== Know ==
* People learn and understand in different ways
* Staff need enough knowledge to manage risks to food safety and suitability
* Not all staff need training in all things, but they need to know how to keep food safe when doing their job
* If you have staff you will need to train them before they start handling food, before you introduce or change a procedure, and whenever you think you need it

== Do ==
* Ensure all staff and visitors know what to do to meet relevant requirements for:
  * Health and hygiene
  * Dealing with high risk foods
  * Cleaning and sanitising
  * Safely sourcing and receiving food
  * Keeping foods separate
  * Managing allergens
  * Other procedures specific to your business
  * Managing customer complaints
  * What to do when something goes wrong
  * Managing food recalls
* Check that staff apply training before they start working
* Keep a record of training completed, including who was trained, when, what was covered, and signatures

== Show ==
* Show your verifier how you know that staff and visitors were competent to do their job
* Records of how and when staff were trained', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (153, 820, '', 1, 'tt:153');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES (187, 73, 1, 1, NOW(), 0, 0, 820, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (187, 1, 153, 187);

UPDATE mediawiki.page SET page_latest = 187, page_len = 820, page_touched = NOW() WHERE page_id = 73;

-- Page 74: Managing places and equipment
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (154, 'FCP:Setting Up - Managing places and equipment

== Know ==
* When choosing places and equipment consider:
  * What the place has been previously used for
  * That rooms and equipment can be easily cleaned and maintained
  * That there is adequate lighting, ventilation and services
  * That equipment is designed for food use and for the process you intend
* Places and equipment are the foundation of your business
* Holes in buildings, uncleaned equipment, and unsuitable materials can result in contamination

== Do ==
* Manage any food safety or suitability hazards associated with places and equipment
* Check previous use of land and buildings
* If neighbours do things that could make your food unsafe, minimize the risk
* Only operate out of places with enough space and good workflow
* Design workflow so food moves safely through your business
* Buildings and equipment must be made of materials that will not contaminate food
* Ensure all areas where food will be processed can be easily cleaned and sanitised
* Limit dust, dirt, fumes or pests that can get into food areas
* Provide storage for cleaning chemicals away from food
* Make hand washing areas available close to food handling areas
* Provide rubbish areas away from food processing areas
* Use equipment that is accurate and working properly for measuring control points

== Show ==
* Show your verifier how you know the location has not previously been used for something that will make food unsafe
* How you manage risks from neighbouring activities
* Why you chose the equipment you are using
* Your verifier will observe workflow and whether staff can easily maintain good food safety practices', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (154, 1250, '', 1, 'tt:154');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES (188, 74, 1, 1, NOW(), 0, 0, 1250, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (188, 1, 154, 188);

UPDATE mediawiki.page SET page_latest = 188, page_len = 1250, page_touched = NOW() WHERE page_id = 74;

-- Page 75: Managing water supply provided by registered supplier
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (155, 'FCP:Setting Up - Managing water supply provided by a registered drinking water supplier

== Know ==
* Water can carry harmful bugs and chemicals which can make people sick
* You must only use safe uncontaminated water for food preparation
* Water can become contaminated when being stored on-site and distributed around premises
* It is recommended to flush taps by filling a large cup and throwing it out when first turning on
* You need enough safe water available for cleaning and hand washing
* If your registered drinking water supplier notifies you the water is unsafe, follow their advice
* A registered drinking water supplier owns or operates a water supply

== Do ==
* Provide the name of your registered drinking water supplier
* Always use water which is safe for food preparation, cleaning and washing hands
* If your supplier advises water is unsafe, you must either:
  * Not use it, or
  * Boil it for at least 1 minute before use, or
  * Disinfect it with chlorine before use, or
  * Use another supply you know is safe
* Always throw out any food contaminated by unsafe water
* Always clean and sanitise any food contact surfaces contaminated by unsafe water
* Only use water tanks, pipes and taps connected to safe water sources

== Show ==
* Show your verifier a record of any maintenance you have done', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (155, 900, '', 1, 'tt:155');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES (189, 75, 1, 1, NOW(), 0, 0, 900, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (189, 1, 155, 189);

UPDATE mediawiki.page SET page_latest = 189, page_len = 900, page_touched = NOW() WHERE page_id = 75;

-- Page 76: Managing self-supply water
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES (156, 'FCP:Setting Up - Managing self-supply water

== Know ==
* If you are using self-supplied water you must ensure that it is safe
* Water can carry harmful bugs and chemicals which can make people sick
* You need to know what contaminants may be in your water and what treatment is needed
* You need to know what nearby activities and naturally occurring chemicals could make your water unsafe
* Any water treatment equipment needs to be maintained
* You need enough safe water available for cleaning and hand washing

== Do ==
* Identify where you get your water from: roof water, surface water, or ground water
* Always use safe water for food preparation, cleaning and washing hands
* If your water becomes unsafe you must either:
  * Not use it, or
  * Boil it for at least 1 minute, or
  * Disinfect it with chlorine, or
  * Use another source you know is safe
* Always throw out any food contaminated by unsafe water
* Test your water before first use, or if you do not have records of testing
* Your water must meet limits for Escherichia coli, turbidity, chlorine and pH
* Retest water no later than 1 week after getting water from a new source
* If water does not meet requirements, it must be treated before use
* Maintain equipment used for water supply
* Clearly mark taps, tanks and pipes that do not contain safe water
* For surface and ground water sources, water intakes must be at least 10m from livestock and at least 50m from potential sources of contamination
* Identify any nearby activities and chemical hazards that could make water supply unsafe

== Show ==
* Show your verifier a record of your water test results
* A list of all nearby activities which might affect the safety of your water
* How you know your water treatment system is working properly
* Any chemical hazards you have identified and how you control them', 'utf-8');

INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES (156, 1380, '', 1, 'tt:156');

INSERT INTO mediawiki.revision (rev_id, rev_page, rev_comment_id, rev_actor, rev_timestamp, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1) VALUES (190, 76, 1, 1, NOW(), 0, 0, 1380, NULL, '');

INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES (190, 1, 156, 190);

UPDATE mediawiki.page SET page_latest = 190, page_len = 1380, page_touched = NOW() WHERE page_id = 76;

COMMIT;

-- Verify the updates
SELECT page_id, page_title,
       CASE WHEN t.old_text IS NULL OR LENGTH(t.old_text) = 0 THEN 'EMPTY' ELSE 'HAS CONTENT' END as status,
       LENGTH(COALESCE(t.old_text, '')) as text_length
FROM mediawiki.page p
LEFT JOIN mediawiki.revision r ON p.page_latest = r.rev_id
LEFT JOIN mediawiki.slots s ON r.rev_id = s.slot_revision_id
LEFT JOIN mediawiki.content c ON s.slot_content_id = c.content_id
LEFT JOIN mediawiki.text t ON c.content_id = t.old_id
WHERE p.page_id IN (71, 73, 74, 75, 76)
ORDER BY p.page_id;
