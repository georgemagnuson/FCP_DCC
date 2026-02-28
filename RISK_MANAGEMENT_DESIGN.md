# Risk Management Section - Design Specification

**Date:** 2026-02-28
**Pattern:** Business subpage structure (`Business:The Jitsu/Risk_Management`)

---

## Repeatable Field Groups Design

### Field Group Structure: Risk + Control Measure

Each risk entry consists of a paired group:

#### Group 1: Risk/Hazard (5 repeatable groups)

**Fields per group:**
1. **Hazard Name** (Text field, 100 chars)
   - Short identifier for the risk
   - Example: "Cross-contamination", "Temperature abuse", "Allergen exposure"

2. **Hazard Description** (Text area, 500 chars)
   - Detailed description of what could go wrong
   - Example: "Raw chicken stored above ready-to-eat foods in refrigerator"

3. **Control Measure** (Text area, 500 chars)
   - How the hazard is prevented or controlled
   - Example: "Store raw meats on bottom shelf, ready-to-eat foods on top shelves"

4. **Monitoring Method** (Text area, 300 chars)
   - How we check the control is working
   - Example: "Daily opening check - verify storage positions"

5. **Corrective Action** (Text area, 300 chars)
   - What to do if control fails
   - Example: "Relocate foods immediately, discard contaminated items"

### Why 5 Groups?

Based on common food business hazards:
1. Temperature control (hot/cold holding)
2. Cross-contamination (raw/cooked separation)
3. Allergen management
4. Cleaning and sanitation
5. Personal hygiene

**Businesses can fill 1-5 groups as needed.**

---

## Page Structure

### Hub Page: `FCP/Setting_Up/Risk_Management`

**Components:**
- Introduction explaining risk management
- Requirements section (what must be provided)
- Auto-generated list of businesses with status indicators
- Uses `Template:RiskManagementListItem`

### Business-Specific Pages: `Business:Name/Risk_Management`

**Pattern:** Subpages under Business namespace
**Examples:**
- `Business:The Jitsu/Risk_Management`
- `Business:Test_Cafe/Risk_Management`
- `Business:Corner_Store/Risk_Management`

**Content:**
- Display template showing all risk entries
- "Add/Edit Information" button
- FCP dark blue styling (#1a3a52)

---

## Form Design: `Form:RiskManagement`

**Structure:**
```wiki
{{{for template|RiskManagement}}}

=== Risk 1 ===
{{{field|hazard_1_name|input type=text|size=50|placeholder=Hazard name}}}
{{{field|hazard_1_description|input type=textarea|rows=3|placeholder=What could go wrong?}}}
{{{field|hazard_1_control|input type=textarea|rows=3|placeholder=How do you prevent/control this?}}}
{{{field|hazard_1_monitoring|input type=textarea|rows=2|placeholder=How do you check it's working?}}}
{{{field|hazard_1_corrective|input type=textarea|rows=2|placeholder=What do you do if it fails?}}}

=== Risk 2 ===
{{{field|hazard_2_name|input type=text|size=50|placeholder=Hazard name}}}
{{{field|hazard_2_description|input type=textarea|rows=3}}}
{{{field|hazard_2_control|input type=textarea|rows=3}}}
{{{field|hazard_2_monitoring|input type=textarea|rows=2}}}
{{{field|hazard_2_corrective|input type=textarea|rows=2}}}

=== Risk 3 ===
{{{field|hazard_3_name|input type=text|size=50|placeholder=Hazard name}}}
{{{field|hazard_3_description|input type=textarea|rows=3}}}
{{{field|hazard_3_control|input type=textarea|rows=3}}}
{{{field|hazard_3_monitoring|input type=textarea|rows=2}}}
{{{field|hazard_3_corrective|input type=textarea|rows=2}}}

=== Risk 4 ===
{{{field|hazard_4_name|input type=text|size=50|placeholder=Hazard name}}}
{{{field|hazard_4_description|input type=textarea|rows=3}}}
{{{field|hazard_4_control|input type=textarea|rows=3}}}
{{{field|hazard_4_monitoring|input type=textarea|rows=2}}}
{{{field|hazard_4_corrective|input type=textarea|rows=2}}}

=== Risk 5 ===
{{{field|hazard_5_name|input type=text|size=50|placeholder=Hazard name}}}
{{{field|hazard_5_description|input type=textarea|rows=3}}}
{{{field|hazard_5_control|input type=textarea|rows=3}}}
{{{field|hazard_5_monitoring|input type=textarea|rows=2}}}
{{{field|hazard_5_corrective|input type=textarea|rows=2}}}

{{{end template}}}
```

---

## Template Design: `Template:RiskManagement`

**Display Pattern:**
- Show each risk group in a card-style layout
- Use FCP dark blue color scheme
- Only display groups that have content (skip empty ones)
- Show "No risks documented yet" if all groups empty
- "Add/Edit Information" button at bottom

**Semantic Properties:**
- `Has_risk_count` (Number) - Count of documented risks
- `Has_risk_management` (Boolean) - Whether risks are documented

---

## List Item Template: `Template:RiskManagementListItem`

**Purpose:** Display each business in the hub page list with status

**Pattern:**
```wiki
* [[Business:{{{business_name}}}/Risk_Management|{{{business_name}}}]]
  {{#if:{{{SMW_trading_name|}}}| - {{{SMW_trading_name}}}}}
  {{#ifexist:Business:{{{business_name}}}/Risk_Management|✅|⚠️}}
```

**Status Indicators:**
- ✅ Green checkmark = Risk Management page exists
- ⚠️ Orange warning = Not yet documented

---

## Semantic Properties

### Property:Has_risk_count
- **Type:** Number
- **Description:** Number of risks documented for this business
- **Range:** 0-5

### Property:Has_risk_management
- **Type:** Boolean
- **Description:** Whether risk management has been documented
- **Values:** true/false

---

## User Workflow

1. Navigate to `FCP/Setting_Up/Risk_Management`
2. See list of businesses with status indicators
3. Click on business name (e.g., "The Jitsu")
4. Redirects to `Business:The Jitsu/Risk_Management`
5. If empty: "No risks documented yet" + "Add/Edit Information" button
6. Click button → opens `Form:RiskManagement`
7. Fill in 1-5 risk groups (as many as needed)
8. Save
9. Template displays risk cards, updates semantic properties
10. Hub page shows ✅ status

---

## Implementation Checklist

- [ ] Create hub page: `FCP/Setting_Up/Risk_Management`
- [ ] Create list item template: `Template:RiskManagementListItem`
- [ ] Create form: `Form:RiskManagement`
- [ ] Create display template: `Template:RiskManagement`
- [ ] Create semantic properties:
  - [ ] `Property:Has_risk_count`
  - [ ] `Property:Has_risk_management`
- [ ] Create test page: `Business:The Jitsu/Risk_Management`
- [ ] Test workflow end-to-end
- [ ] Update `FCP/Setting_Up` parent page to link to Risk_Management

---

## Color Scheme

**FCP Dark Blue:**
- Primary: `#1a3a52`
- Background: `rgba(26, 58, 82, 0.1)`
- Border: `4px solid #1a3a52`

---

## Notes

- Field groups are optional - businesses fill only what's relevant
- Template intelligently hides empty groups
- Follows established Business Layout pattern
- Uses business subpage structure for better organization
- Semantic properties enable querying and reporting
