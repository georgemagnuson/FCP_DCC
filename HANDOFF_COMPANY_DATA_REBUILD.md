# Handoff: Rebuild Diary → Company Data (2a) on Postgres

**Context:** On 2026-08-22 we audited all 391 wiki pages against the project's 3-part
content model (Program / Company Data / Operations Data — see Memory Bank
`f55dbeb4-543d-4568-810a-136adee717f0` for the full audit + cleanup record) and
deleted 240 legacy/duplicate/bug/test pages, including the old SMW-based Company
Data system (Business Details, Layout, Risk Management, the old Equipment
Registry Form/Template pair, Employee templates). Wiki is now at 152 pages.

**This document is the plan for what replaces what was deleted.** Nothing below
has been built yet — this is the spec to implement next.

## The pattern to replicate

Equipment already went through this exact migration (2026-03-27) and is the
reference implementation for everything below:

- **API**: `fcp_api/routers/business.py` — `equipment_router`, full CRUD
  (`GET /categories`, `GET`, `GET /{id}`, `POST`, `PUT /{id}`, `DELETE /{id}`
  soft-delete via `is_active = FALSE`), gated `MANAGER_LEVEL` for writes.
- **Wiki write UI**: `mediawiki_extension/FcpBridge/includes/SpecialFcpEquipment.php`
  — one Special page handling `?action=add|edit|delete` via GET (render form) /
  POST (submit), calling `FcpApiClient::post()/put()/delete()`.
- **Wiki read/display**: `Equipment_Registry_Documentation` page uses
  `{{#fcp_equipment_table:}}` parser function (in `FcpParserFunctions.php`),
  with manager-only Add/Edit/Delete links pointing at `Special:FcpEquipment`.
- **Registration**: `extension.json` → `SpecialPages` + `FcpBridge.magic.php`.

`FcpApiClient.php` already has generic `get()/post()/put()/delete()` methods —
nothing new needed there.

## Current state per entity (checked against the actual code, not assumed)

| Entity | API | Wiki write UI | Wiki read UI | Gap |
|---|---|---|---|---|
| **Equipment** | Full CRUD ✅ | `Special:FcpEquipment` ✅ | `{{#fcp_equipment_table:}}` ✅ | None — reference implementation |
| **Employee — create** | `POST /employees` ✅ (`fcp_api/routers/employees.py`) | `Special:FcpNewEmployee` ✅ | `Employee_Directory` via `{{#fcp_employee_list:}}` ✅ | None |
| **Employee — update** | ❌ no `PUT /employees/{id}` | ❌ no edit form | `Special:FcpEmployee` (read-only) | **Need PUT endpoint + edit form** — no way to change role, renew a cert, or deactivate an employee right now |
| **Business** | ❌ only `GET /{id}`, `GET /{id}/summary` | ❌ none (old SMW pages deleted) | none currently | **Need full write path from scratch** |
| **Location** | ❌ no endpoints at all | ❌ none | none | **Need full write path from scratch** — low priority, single-location system today (`LOCATION_ID` is a hardcoded constant in `employees.py`/`equipment` calls) |

Corrects an earlier assumption in Memory Bank: `POST /employees` was believed
pending as of 2026-03-27 but is actually already built and wired end-to-end.
Only the **update** path is missing for employees.

## jitsu_fcp schema — what's already there

```sql
-- business (jitsu_fcp_schema.sql)
id, name, trading_name, address, city, country, phone, email,
food_registration_number, fcp_version, fcp_effective_date,
is_active, created_at, updated_at

-- location
id, business_id, name, address, city, phone, is_active, created_at, updated_at

-- employee
id, business_id, location_id, mediawiki_username, full_name, role,
food_handler_cert_number, cert_expiry, is_active, created_at, updated_at
```

No schema changes needed for a first pass — `business` already has everything
the old `Business:The Jitsu/Details` page held. **Risk Management** doesn't map
to a column on `business` or anywhere else in the schema — the old
`Business:The Jitsu/Risk Management` page's content needs a home. Options:
add a `risk_notes TEXT` column to `business`, or a separate `business_risk_item`
table if it's meant to be a structured list rather than free text. Decide this
before writing the endpoint — see Open Questions below.

**Layout** (`Business:The Jitsu/Layout`, old `FCP/Setting Up/Business Layout`)
similarly has no schema home. Likely the same treatment as Risk Management, or
it may turn out to be Program content (a diagram/description of required layout
per the MPI plan) rather than Company Data at all — worth rereading the deleted
page's content (recoverable via MediaWiki's page history / Special:Undelete,
since these were soft-deleted through the API, not purged) before deciding.

## Build plan

### 1. `POST/PUT /business/{id}` (fcp_api/routers/business.py)

Single-business system (`BUSINESS_ID` constant, same pattern as `employees.py`).
A `PUT` is more useful than `POST` here since the business record is created
once during initial setup (likely already exists in the DB from seed data) —
confirm with `SELECT * FROM business;` before deciding whether `POST` is even
needed, or if this is edit-only.

```python
class BusinessUpdateIn(BaseModel):
    name: str
    trading_name: Optional[str] = None
    address: Optional[str] = None
    city: Optional[str] = None
    country: str = "New Zealand"
    phone: Optional[str] = None
    email: Optional[str] = None
    food_registration_number: Optional[str] = None
    fcp_version: Optional[str] = None
    fcp_effective_date: Optional[date] = None

@router.put("/{business_id}")
def update_business(business_id: str, body: BusinessUpdateIn, caller: dict = Depends(auth.verify_request)):
    auth.require_level(MANAGER_LEVEL)(caller)
    # UPDATE business SET ... WHERE id = %s AND is_active = TRUE
```

### 2. `POST/PUT /employees/{id}` (fcp_api/routers/employees.py)

```python
@router.put("/{employee_id}")
def update_employee(employee_id: str, body: EmployeeIn, caller: dict = Depends(auth.verify_request)):
    auth.require_level(MANAGER_LEVEL)(caller)
    # UPDATE employee SET full_name, role, food_handler_cert_number, cert_expiry ...
    # WHERE id = %s AND is_active = TRUE

@router.delete("/{employee_id}")
def deactivate_employee(employee_id: str, caller: dict = Depends(auth.verify_request)):
    auth.require_level(MANAGER_LEVEL)(caller)
    # UPDATE employee SET is_active = FALSE WHERE id = %s
```

`GET /employees/{id}` (by id, not just by-username) is also missing and needed
to pre-fill an edit form — add alongside.

### 3. `Special:FcpBusiness` (new PHP file, modeled directly on `SpecialFcpEquipment.php`)

One business record, so no `?action=add` — just `?action=edit` (GET renders
pre-filled form via `FcpApiClient::get('/business/{id}')`, POST submits via
`put()`). No delete action (a business shouldn't be deletable from the wiki).
Manager-gated, same pattern as Equipment.

### 4. Extend `Special:FcpEmployee` — or add `Special:FcpEditEmployee`

Two options: add `?action=edit` handling directly into the existing
`SpecialFcpEmployee.php` (currently read-only display), or create a sibling
`SpecialFcpEditEmployee.php` the way `SpecialFcpNewEmployee.php` sits alongside
it for creation. Prefer extending the existing file — keeps "view vs. edit an
employee" in one place, avoids a fourth employee-related Special page.

### 5. Registration

Add `FcpBusiness` (and `FcpEditEmployee` if built as a separate file) to
`extension.json` → `SpecialPages`, same block as the existing 8 entries.

### 6. Wiki pages to recreate

The deleted pages need replacements, minimal this time (no SMW, no Page Forms
Template/Form pair — the Special page *is* the form):

- A `Business_Details` (or similar) page showing the business summary — could
  reuse `{{#fcp_query: endpoint=business/{id}/summary | format=summary}}`
  (already exists, was built for a different purpose but fits directly) with a
  manager-only "Edit" link to `Special:FcpBusiness?action=edit`, same visual
  pattern as `Equipment_Registry_Documentation`.
- Decide whether Risk Management / Layout get folded into that same page or
  stay separate, once their schema home (see above) is settled.

### 7. Testing checklist (mirror what Equipment already proved out)

- [ ] Manager can view current business details
- [ ] Manager can edit and save business details; non-manager cannot
- [ ] Manager can create a new employee (already works — regression check only)
- [ ] Manager can edit an existing employee's role/cert/expiry
- [ ] Manager can deactivate an employee; deactivated employee drops off `Employee_Directory`
- [ ] `X-FCP-Secret`/`X-MW-User`/`X-MW-Groups` headers enforced correctly on all new endpoints (copy the pattern already proven on equipment/employees)

## Open questions (need a decision before or during implementation)

1. **Risk Management & Layout content** — what schema/endpoint should hold
   these? Free-text column on `business`, a structured table, or is Layout
   actually Program content (MPI-plan reference) rather than Company Data?
   Check the deleted pages' content before deciding — recoverable via
   MediaWiki page history / `Special:Undelete` since they were removed through
   the normal delete API (soft-deleted, not purged), *not* the two pages fixed
   via direct SQL (`DirectTest001`, `Item List`, and the 4 double-prefix
   pages) — those are genuinely gone.
2. **Location** — still single-location (`LOCATION_ID` hardcoded in
   `employees.py`). Worth building `POST/PUT /location` now, or defer until
   there's an actual second location to justify it?
3. **`Special:FcpEmployee` edit** — extend in place vs. new sibling file (see
   Build Plan §4) — pick one before starting so the PHP structure matches
   whichever "add employee" already established.

## Reference

- Equipment CRUD (the pattern): `fcp_api/routers/business.py` (equipment
  section), `SpecialFcpEquipment.php`, `{{#fcp_equipment_table:}}` in
  `FcpParserFunctions.php`
- Employee create (already working, same auth/model conventions to follow):
  `fcp_api/routers/employees.py`, `SpecialFcpNewEmployee.php`
- Auth levels: `fcp_api/auth.py` — `GROUPS` dict, `require_level()`
- PHP↔API bridge: `FcpApiClient.php` — `get()/post()/put()/delete()` all exist,
  nothing new needed there
- Schema: `jitsu_fcp_schema.sql` — `business`, `location`, `employee` tables
- Full audit + cleanup history: Memory Bank UUID `f55dbeb4-543d-4568-810a-136adee717f0`
