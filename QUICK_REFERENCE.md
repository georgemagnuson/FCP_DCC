# FCP_DCC Quick Reference

**Project:** Food Control Plan Compliance Documentation & Diary System
**Purpose:** Operational reference for MediaWiki system access, configuration, and usage

---

## ⚠️ CRITICAL: .env File Access

**The `.env` file cannot be sourced directly** — it contains unquoted special characters that cause shell errors. Always use `grep` to extract credentials:

```bash
# Extract all MediaWiki variables
grep "^MEDIAWIKI" /Users/georgemagnuson/Documents/GitHub/.env

# Extract individual values for use in scripts
MW_USER=$(grep "^MEDIAWIKI_USERNAME" /Users/georgemagnuson/Documents/GitHub/.env | cut -d= -f2)
MW_PASS=$(grep "^MEDIAWIKI_PASSWORD" /Users/georgemagnuson/Documents/GitHub/.env | cut -d= -f2)
```

**Never run `source .env`** — it will fail with parse errors.

---

## ⚠️ CRITICAL: mw-crud API Skill & Access Credentials

### Always Use mw-crud for MediaWiki Page Operations ✅

**This is the PREFERRED and ONLY recommended method for creating, reading, updating, and deleting pages.**

**Memory Bank:** `bfcb00aa-03eb-46b3-8710-8b9417b15c86` — MediaWiki API / mw-crud Fully Working

### mw-crud Credentials & Usage

**Credentials Location:** `/Users/georgemagnuson/Documents/GitHub/.env` (NOT committed to git)
- `MEDIAWIKI_USERNAME` — See .env file
- `MEDIAWIKI_PASSWORD` — See .env file
- `MEDIAWIKI_API_URL` = `http://192.168.2.10/mediawiki/api.php`

**Note:** `.env` cannot be sourced directly (unquoted special chars cause shell errors). Use `grep` to extract:
```bash
grep "^MEDIAWIKI" /Users/georgemagnuson/Documents/GitHub/.env
```

```bash
# Extract credentials via grep (do NOT use source .env)
MW_USER=$(grep "^MEDIAWIKI_USERNAME" /Users/georgemagnuson/Documents/GitHub/.env | cut -d= -f2)
MW_PASS=$(grep "^MEDIAWIKI_PASSWORD" /Users/georgemagnuson/Documents/GitHub/.env | cut -d= -f2)

# Read a page
~/.claude/skills/mediawiki-crud/mw-crud read "Page Title" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MW_USER" --password "$MW_PASS"

# Create a page
~/.claude/skills/mediawiki-crud/mw-crud create "New Page" \
  --content "Page content here" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MW_USER" --password "$MW_PASS"

# Update a page
~/.claude/skills/mediawiki-crud/mw-crud update "Page Title" \
  --content "Updated content" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MW_USER" --password "$MW_PASS"

# Delete a page
~/.claude/skills/mediawiki-crud/mw-crud delete "Page Title" \
  --reason "No longer needed" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MW_USER" --password "$MW_PASS"

# Purge parser cache (force re-render — required after API data changes or permission fixes)
~/.claude/skills/mediawiki-crud/mw-crud purge "Page Title" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MW_USER" --password "$MW_PASS"
```

**Why mw-crud matters:**
- Full edit history and audit trail in MediaWiki
- Automatically updates SMW semantic indexes
- Properly invalidates all caches
- Handles CSRF tokens and conflict detection
- No risk of revision sequence errors
- Maintains MediaWiki integrity across the system

### mw-crud vs Direct SQL: CRITICAL POLICY

**ALWAYS use mw-crud for page and template operations.**

Use psql **ONLY** if mw-crud fails AND:
1. You clearly explain the specific failure to the user
2. You describe why mw-crud won't work
3. The user explicitly approves using psql as a workaround

**Never silently switch to psql** when mw-crud gets complicated or output formatting is messy. Always ask first.

**Why this matters:**
- mw-crud maintains proper MediaWiki integrity (audit trails, caches, sequences, SMW)
- Direct SQL can cause orphaned records, broken sequences, and cache invalidation issues
- It keeps the workflow consistent and auditable
- It prevents hidden bugs from improper database manipulation

---

## ⚠️ CRITICAL: Access Credentials & Connection Methods

### All Credentials in .env

**⚠️ IMPORTANT: ALL passwords and credentials are stored in `.env` file (NOT committed to git)**

```
Location: /Users/georgemagnuson/Documents/GitHub/.env
Includes:
  - MEDIAWIKI_USERNAME = [See .env file]
  - MEDIAWIKI_PASSWORD = [See .env file]
  - MEDIAWIKI_API_URL = http://192.168.2.10/mediawiki/api.php
```

FCP API secrets (DB password, shared secret) are stored on llamajail at `/usr/local/www/fcp_api/.env` (chmod 600, not committed).

**DO NOT add passwords to this repository.** Always reference the .env file.

### SSH Access (Key-Based)

**Configured in `~/.ssh/config` for key-based authentication (no passwords needed)**

```bash
# llamajail — all FCP services
ssh 192.168.2.10
```

**Details:**
- **User:** `georgemagnuson`
- **Port:** 22 (standard)
- **Authentication:** SSH key configured in `~/.ssh/config`

### PostgreSQL Access

All databases (`mediawiki`, `jitsu_fcp`) are on llamajail's local PostgreSQL instance.

```bash
# From llamajail (no host needed)
ssh 192.168.2.10
psql -U postgres -d mediawiki
psql -U postgres -d jitsu_fcp

# From local machine
psql -h 192.168.2.10 -U postgres -d mediawiki
psql -h 192.168.2.10 -U postgres -d jitsu_fcp
```

**Configuration:**
- **File Location:** `~/.pgpass` (or `/var/db/postgres/.pgpass` on server)
- **Format:** `192.168.2.10:5432:*:postgres:[PASSWORD]`
- **Permissions:** 600 (secure, user-only access)

**Database quick queries:**
```bash
# List all databases
psql -U postgres -h 192.168.2.10 -l

# List tables in mediawiki database
psql -U postgres -d mediawiki -h 192.168.2.10 -c "\dt"

# List SMW properties
psql -U postgres -d mediawiki -h 192.168.2.10 -c "SELECT * FROM mediawiki.smw_object_ids WHERE smw_iw = '' LIMIT 20;"
```

---

## Infrastructure Overview

This project is **self-contained on llamajail**. All services (MediaWiki, FCP API, PostgreSQL) run on a single host.

| Server | IP Address | Function | Services |
|--------|-----------|----------|----------|
| **llamajail** | 192.168.2.10 | All FCP services | Apache 2.4, PHP 8.2, MediaWiki 1.43.5, PostgreSQL 17, FastAPI (port 8765) |

**Network:**
- Jails Bridge Network: `192.168.2.x`
- Public Access via: `192.168.1.18` (macmini - Nginx reverse proxy)
- External IPs: JITSU (203.109.151.180), ASTEROID M (203.96.209.134)

---

## Service URLs

### Web Access
- **MediaWiki:** http://192.168.2.10 or https://192.168.1.18/mediawiki/
- **FCP API (internal):** http://127.0.0.1:8765 (llamajail localhost only)

### External Access
- **MediaWiki External:** http://203.109.151.180:1080

---

## Common Commands

### Service Management

All services run on llamajail — SSH in first: `ssh 192.168.2.10`

```bash
# Apache (MediaWiki)
sudo service apache24 status
sudo service apache24 restart

# PostgreSQL
sudo service postgresql status
sudo service postgresql restart

# FCP API
sudo service fcp_api status
sudo service fcp_api restart
```

### MediaWiki Maintenance

```bash
# ⚠️ ALWAYS run maintenance as www user — avoids UUID /tmp permission errors
# Running as georgemagnuson causes: "Could not open '/tmp//mw-GlobalIdGenerator80-UUID-128'"

# Clear cache after template or page changes (CRITICAL after deployments)
ssh 192.168.2.10 'sudo -u www php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch'

# Run job queue (SMW indexing, link updates)
ssh 192.168.2.10 'sudo -u www php /usr/local/www/mediawiki/maintenance/runJobs.php --maxjobs=500'

# Rebuild ALL SMW semantic data (after bulk page creation or SMW issues)
ssh 192.168.2.10 'sudo -u www php /usr/local/www/mediawiki/extensions/SemanticMediaWiki/maintenance/rebuildData.php'

# Update database schema
ssh 192.168.2.10 'sudo -u www php /usr/local/www/mediawiki/maintenance/update.php --quick'

# Purge specific pages via API (faster than full purge, use after targeted edits)
# See mw-crud section for API credentials pattern
```

### SQL Deployment Pattern (for Phase deployments)

**Standard 3-step deployment (with backup & verification):**

```bash
# 1. Create backup before deployment
pg_dump -h 192.168.2.10 -U postgres -d mediawiki > /tmp/backup_mediawiki_$(date +%Y%m%d_%H%M%S).sql

# 2. Deploy SQL script
psql -h 192.168.2.10 -U postgres -d mediawiki -f /path/to/script.sql

# 3. Verify deployment
psql -h 192.168.2.10 -U postgres -d mediawiki -c "SELECT page_id, page_title FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317;"
```

**After SQL deployment, always clear MediaWiki cache:**

```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'
```

**Rollback if needed:**

```bash
psql -h 192.168.2.10 -U postgres -d mediawiki < /tmp/backup_mediawiki_*.sql
```

---

## Direct SQL Database Access ⚠️ USE WITH CAUTION

**Use Case:** Use ONLY for schema/infrastructure queries — NOT for creating or editing pages.

**Why not for pages:** Direct SQL inserts bypass PostgreSQL sequences, causing `duplicate key` revision errors when MediaWiki next tries to write. Always run the sequence fix after any direct SQL page inserts:

```sql
-- Run this after ANY direct SQL inserts into MediaWiki tables
SELECT setval('mediawiki.page_page_id_seq', (SELECT MAX(page_id) + 1 FROM mediawiki.page));
SELECT setval('mediawiki.revision_rev_id_seq', (SELECT MAX(rev_id) + 1 FROM mediawiki.revision));
SELECT setval('mediawiki.text_old_id_seq', (SELECT MAX(old_id) + 1 FROM mediawiki.text));
SELECT setval('mediawiki.content_content_id_seq', (SELECT MAX(content_id) + 1 FROM mediawiki.content));
```

**Safe SQL uses:** Querying data, fixing sequences, checking page IDs, bulk data migrations (with sequence fix).

---

## Troubleshooting

### mw-crud API Authentication Fails — OATHAuth Error

**Symptom:** `relation "oathauth_devices" does not exist`

**Fix:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && sudo -u www php maintenance/update.php --quick'
```

This updates the database schema for MediaWiki 1.43.5.

### Revision Errors After Direct SQL Page Inserts

**Symptom:** `duplicate key value violates unique constraint "revision_pkey"`

**Cause:** Direct SQL inserts bypass PostgreSQL sequences.

**Fix:** Run sequence reset (see **Direct SQL Database Access** section above).

**Prevention:** Use mw-crud API for all page creation/editing. See **CRITICAL: mw-crud API Skill & Access Credentials** section above.

### Form Submissions Not Appearing in Queries

**Symptom:** Data entered via form doesn't show up in #ask queries

**Fix:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/runJobs.php'
```

Also clear page cache:
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch'
```

### #ask Queries Return No Results

**Checklist:**
- Verify property names match exactly (case-sensitive)
- Confirm templates are calling `[[Has_propertyname::value]]`
- Run job processor to rebuild semantic indexes (above)
- Check category links are correct

### Role-Based Access (#ifingroup) Not Working

**Checklist:**
- Verify UserFunctions extension is loaded
- Confirm user is actually in the group (Special:UserRights)
- Verify group name spelling and matches configuration
- Clear page cache after role changes

---

## Security & Access Control

### Anonymous User Access Control

**Current Setup:**
- Anonymous users redirected to `Jitsu_Home` landing page
- All Main_Page content requires login
- Whitelisted pages: Jitsu_Home, Special:UserLogin, CSS/JS files

**Implementation:**
- BeforeInitialize hook: Anonymous → Jitsu_Home redirect
- UserLogoutComplete hook: Logout → Jitsu_Home redirect (302 temporary)

**Backup:** `/usr/local/www/mediawiki/LocalSettings.php.backup-20260219-*`

### Role-Based Content Display

**Using #ifingroup in templates:**
```
Manager role:    {{#ifingroup:training_manager|...}}
Employee role:   {{#ifingroup:training_employee|...}}
Inspector role:  {{#ifingroup:training_inspector|...}}
```

All links visible to all roles, but functionally restricted by user group.

---

## Risk Management

### Database Backup Schedule

**Manual Backups (before deployments):**
```bash
pg_dump -h 192.168.2.10 -U postgres -d mediawiki > /tmp/backup_$(date +%Y%m%d_%H%M%S).sql
pg_dump -h 192.168.2.10 -U postgres -d jitsu_fcp > /tmp/backup_jitsu_fcp_$(date +%Y%m%d_%H%M%S).sql
```

**Automated Backups:** Check `/var/db/postgres/backups/` on llamajail (if configured).

### Sequence Management

**After Direct SQL Operations:**
```bash
ssh 192.168.2.10
psql -U postgres -d mediawiki
# Then run sequence reset SQL (see Direct SQL section above)
```

**Prevention:** Use mw-crud API to avoid sequence issues entirely.

### Cache Invalidation

**Always after page/template updates:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'
```

### MPI FCP Document Version Check

Quarterly cron on llamajail (`/usr/local/www/fcp_api/mpi_version_check/`) compares the 8
MPI documents this project's compliance content is built from against MPI's live site.

```bash
# Manual run
ssh 192.168.2.10 'cd /usr/local/www/fcp_api/mpi_version_check && python3 check_mpi_versions.py'

# Check current status
ssh 192.168.2.10 'cat /usr/local/www/fcp_api/mpi_version_check/reports/latest.json'
```

**On a mismatch:** updates the `FCP_MAIN:MPI_Document_Status` wiki page, emails
`MPI_CHECK_EMAIL_TO` via authenticated Gmail SMTP (same pattern as JITSU/DATACOLLECTOR's
notifier on atlantis), and writes a report. See `mpi_version_check/README.md` for the
full design and the resolution procedure. Memory Bank entries and push notifications for
a flagged change are reactive: ask Claude to check FCP MPI status when the email/banner
shows a pending update.

MPI's site sits behind an Incapsula WAF that occasionally challenge-blocks automated
requests — the script detects this via response Content-Type and reports it as an error
rather than a false version/content change; it clears on its own by the next run.

---

## FCP CRUD API

### Overview

| Item | Value |
|------|-------|
| **Location** | `/usr/local/www/fcp_api/` on llamajail |
| **Listens on** | `127.0.0.1:8765` (localhost only) |
| **Database** | `jitsu_fcp` on llamajail PostgreSQL 17 |
| **Config** | `/usr/local/www/fcp_api/.env` (chmod 600) |
| **Log** | `/var/log/fcp_api.log` |
| **rc.d service** | `fcp_api` (starts after `postgresql` on boot) |

### Service Management

```bash
sudo service fcp_api start
sudo service fcp_api stop
sudo service fcp_api status

# Tail logs
tail -f /var/log/fcp_api.log

# Health check
curl -s http://127.0.0.1:8765/health

# Interactive API docs (development only)
# http://127.0.0.1:8765/docs  (via SSH tunnel or from llamajail)
```

### Authentication — Required Headers on Every Request

Every request from the MW extension must include:

```
X-FCP-Secret:  <shared secret>          # proves request came from MediaWiki
X-MW-User:     <mediawiki username>      # logged-in user
X-MW-Groups:   <comma-separated groups>  # e.g. "training_manager,user"
```

Shared secret is stored in two places — they must match:
- `/usr/local/www/fcp_api/.env` → `FCP_SHARED_SECRET`
- `/usr/local/www/mediawiki/LocalSettings.php` → `$wgFcpApiSecret`

**Permission levels:**

| MW Group | Level | Can Access |
|----------|-------|------------|
| `training_employee` | 1 | Record temps, cooling readings, cleaning, delivery |
| `training_supervisor` | 2 | All above + maintenance, verify cleaning, corrective actions |
| `training_manager` | 3 | All above + alerts, reports, incident management |
| `sysop` | 4 | Full access |

### Endpoints

```bash
# Business
GET  /business/{id}           # full details + locations + staff
GET  /business/{id}/summary   # flat key/value (for wiki display)

# Temperature
POST /temperature/reading     # record a reading
GET  /temperature/today/{equipment_id}
GET  /temperature/alerts      # all out-of-range (manager+)
GET  /temperature/summary/{equipment_id}?days=7

# Food Cooling (NZ FCP S39-00006)
POST /cooling/start           # open new cooling event
POST /cooling/{event_id}/reading
GET  /cooling/active?location_id={uuid}
GET  /cooling/history?location_id={uuid}&days=30
GET  /cooling/{event_id}      # full event + all readings

# Incidents
POST /incidents               # file incident report
POST /incidents/{id}/action   # add corrective action
POST /incidents/{id}/action/{action_id}/close
GET  /incidents/open          # all open (manager+)
GET  /incidents/{id}

# Operations
POST /operations/cleaning
POST /operations/cleaning/{id}/verify
POST /operations/maintenance
POST /operations/delivery

# System
GET  /health
```

### Test a Request Manually

```bash
ssh 192.168.2.10
curl -s http://127.0.0.1:8765/business/a1000000-0000-0000-0000-000000000001/summary \
  -H "X-FCP-Secret: $(grep FCP_SHARED_SECRET /usr/local/www/fcp_api/.env | cut -d= -f2)" \
  -H "X-MW-User: Georgemagnuson" \
  -H "X-MW-Groups: sysop,training_manager"
```

### Key UUIDs — Reference Data

| Entity | Name | UUID |
|--------|------|------|
| Business | The Jitsu Ltd. | `a1000000-0000-0000-0000-000000000001` |
| Location | The Jitsu — Stuart Street | `b1000000-0000-0000-0000-000000000001` |
| Equipment | FRIDGE-01 | `d1000000-0000-0000-0000-000000000001` |
| Equipment | FREEZER-01 | `d1000000-0000-0000-0000-000000000002` |
| Equipment | HOTBOX-01 | `d1000000-0000-0000-0000-000000000003` |
| Equipment | DISPLAY-01 | `d1000000-0000-0000-0000-000000000004` |

---

## FcpBridge MediaWiki Extension

### Overview

Thin PHP bridge between MediaWiki Page Forms and the FCP CRUD API.

**Location:** `/usr/local/www/mediawiki/extensions/FcpBridge/`

**Registered in LocalSettings.php:**
```php
wfLoadExtension( 'FcpBridge' );
$wgFcpApiUrl    = 'http://127.0.0.1:8765';
$wgFcpApiSecret = '<shared secret>';   # must match FCP_SHARED_SECRET in fcp_api/.env
```

### Displaying Data — `{{#fcp_query:}}`

Use in any wiki page to display live data from jitsu_fcp:

```
{{#fcp_query: endpoint=business/a1000000-0000-0000-0000-000000000001/summary | format=summary}}
{{#fcp_query: endpoint=temperature/today/<equipment_uuid> | format=table}}
{{#fcp_query: endpoint=cooling/active | location_id=<uuid> | format=table}}
{{#fcp_query: endpoint=incidents/open | location_id=<uuid> | format=table}}
```

**Formats:**

| Format | Output |
|--------|--------|
| `summary` | Key/value wikitable (single object) |
| `table` | Sortable wikitable (array of objects) |
| `count` | Number of rows only |
| `raw` | JSON (for debugging) |

### Submitting Data — `Special:FcpSubmit`

Page Forms submits to `Special:FcpSubmit`. Required hidden fields:

```
fcp_action   = temperature/reading      ← API endpoint to call
fcp_redirect = FCP:Temperature_Log      ← page to return to on success
```

On success redirects with `?fcp_success=1`.
On failure redirects with `?fcp_error=<message>`.
When API sets `incident_suggested=true`, also adds `?fcp_incident_suggested=1`.

### MW 1.43 API Notes

Two deprecated methods replaced in `FcpApiClient.php`:
- `MWHttpRequest::factory()` → `MediaWikiServices::getInstance()->getHttpRequestFactory()->create()`
- `User::getGroups()` → `MediaWikiServices::getInstance()->getUserGroupManager()->getUserGroups()`

---

## jitsu_fcp Database

**Host:** llamajail (192.168.2.10) — same PostgreSQL instance as `mediawiki`

```bash
# Connect
psql -U postgres -d jitsu_fcp              # from llamajail (no host needed)
psql -h 192.168.2.10 -U postgres -d jitsu_fcp  # from local machine

# Schema file
/Users/georgemagnuson/Documents/GitHub/FCP_DCC/jitsu_fcp_schema.sql

# Seed file
/Users/georgemagnuson/Documents/GitHub/FCP_DCC/jitsu_fcp_seed.sql
```

**Tables:** `business`, `location`, `employee`, `supplier`, `equipment_category`, `equipment`, `temperature_log`, `food_cooling_event`, `food_cooling_reading`, `incident_report`, `corrective_action`, `cleaning_log`, `maintenance_log`, `delivery_check`

**Memory Bank UUID:** `209a2d0e-c112-4de3-9f21-44b336b3ffb4` — full schema documentation

---

## Reference Materials

For detailed documentation, see Memory Bank:

| Topic | UUID | Purpose |
|-------|------|---------|
| **File Locations** | f45c69ba-4796-48ce-b276-9953f39e0468 | Directory paths, configuration file locations |
| **User Management** | 5dc56410-cc80-407f-89df-ca15010e8f2c | Creating/managing MediaWiki users and groups |
| **Extensions & Parser Functions** | 25477ac3-1b7c-4e00-bd9d-28c84f8e2f0a | SMW, PageForms, UserFunctions, #ifingroup, #ask syntax |
| **Database Schema** | 7cf253ba-bc01-4264-812f-bf705d40b234 | Tables, namespaces, sequences, schema queries |
| **FCP Section Implementation** | df34c70f-abde-477f-a506-6253a25ac903 | Pattern for creating new FCP sections |
| **FCP Architecture Migration** | a1270905-598a-461a-ba9d-0404797e3ce3 | llamajail migration plan, architecture decisions |
| **jitsu_fcp Schema** | 209a2d0e-c112-4de3-9f21-44b336b3ffb4 | All 14 tables, indexes, design principles |
| **FCP API & FcpBridge Build** | a16c0aba-48ec-4c29-8836-3abe760b3f6d | API endpoints, extension components, seed data |
| **MediaWiki Upgrade Assessment** | 7feb8469-b0fa-459a-a572-59e514da0444 | 1.43.5 → 1.45/1.46 upgrade path, SMW/PageForms compatibility blockers |
| **MPI FCP Version Check (finding)** | 107e174f-6680-4cc4-99bd-09252007ed48 | Repo on S39-00005, MPI live template now S39-00006 — remediation steps |
| **MPI FCP Version Check (system built)** | ac0ca8da-ddcd-4ad6-a66f-1db034b4b093 | Quarterly llamajail cron, architecture, bugs fixed, email limitation |
| **MPI FCP Version Check (email fix)** | 55200a4a-6a99-4753-85f9-b59aed96dcc4 | Email delivery fixed via authenticated Gmail SMTP |
| **MPI S39-00006 Remediation** | 22f6a209-ae3b-4402-9614-523d9ccf01db | First applied fix — doc 16684 confirmed/updated; 6 docs still pending WAF-blocked verification |
| **MPI S39-00006 Content Diff** | 364a84b9-2898-4ca4-9939-6c2da4c67d89 | Real card content changes (freezing, recontamination) — Cooling_Records fixed; Cooking_Verification/Closing_Check gaps open |
| **MPI Check — Banner Status + Aug 29 Follow-up** | 5185ae0b-996f-429e-9591-a7d66328de6a | Banner partially cleared; cloud routines can't reach llamajail (LAN-only rule); one-time cron scheduled |

**To access these:**
```bash
# Search Memory Bank for a topic
mcp__memory-bank-v05__extract_full_document --identifier "[UUID]" --search_by uuid

# Or use the database-query skill to look up by UUID
```

---

**Configuration Status:** Operational ✅
