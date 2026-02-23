# FCP_DCC Quick Reference

**Project:** Food Control Plan Compliance Documentation & Diary System
**Purpose:** Operational reference for MediaWiki system access, configuration, and usage

---

## Infrastructure Overview

| Server | IP Address | Function | Services |
|--------|-----------|----------|----------|
| **llamajail** | 192.168.2.10 | MediaWiki Application | Apache 2.4, PHP 8.2, MediaWiki 1.43.5 |
| **djangojail** | 192.168.2.20 | Wiki.js + Django BI | Nginx, Node.js v20.19.5, Django |
| **postgresqljail** | 192.168.2.30 | PostgreSQL Database | PostgreSQL (Primary DB) |

**Network:**
- Jails Bridge Network: `192.168.2.x`
- Public Access via: `192.168.1.18` (macmini - Nginx reverse proxy)
- External IPs: JITSU (203.109.151.180), ASTEROID M (203.96.209.134)

---

## SSH Access

### Connection Commands

```bash
# MediaWiki Host (llamajail)
ssh 192.168.2.10

# Wiki.js + Django Host (djangojail)
ssh 192.168.2.20

# PostgreSQL Server (postgresqljail)
ssh 192.168.2.30
```

**Status:** ✅ All servers accessible (tested 2026-02-07)
**User:** `georgemagnuson`
**Port:** 22 (standard)
**SSH Key:** Configured in `~/.ssh/config` for key-based authentication
**PostgreSQL Access:** Verified using .pgpass (no passwords in commands)

### Quick SSH Commands (Password-Excluded - Updated 2026-02-02)

**Simplified SSH Access (No flags needed):**

```bash
# MediaWiki Server (llamajail)
ssh 192.168.2.10

# Wiki.js + Django Server (djangojail)
ssh 192.168.2.20

# PostgreSQL Server (postgresqljail)
ssh 192.168.2.30

# Then from any server, use password-less psql:
psql -U postgres -d mediawiki
```

**SSH Configuration:** `~/.ssh/config` has been updated with key-based authentication for all three jails. No SSH flags needed.

---

## Service URLs

### Web Access
- **MediaWiki:** http://192.168.2.10 or https://192.168.1.18/mediawiki/
- **Wiki.js:** https://192.168.2.20/wiki/
- **Django BI:** https://192.168.1.18/ (via reverse proxy)

### External Access
- **MediaWiki External:** http://203.109.151.180:1080

---

## Database Access

### PostgreSQL (postgresqljail - 192.168.2.30)

#### From Local Machine

**Using .pgpass (Recommended)**
```bash
# Direct connection (uses ~/.pgpass for credentials)
psql -h 192.168.2.30 -U postgres -d mediawiki
```

**Status:** ✅ `.pgpass` configured at `~/.pgpass`
- **Credentials:** 192.168.2.30:5432:mediawiki:postgres:[PASSWORD]
- **Permissions:** 600 (secure)
- **Benefits:** No password in command history, secure for automated scripts/cron jobs

#### From postgresqljail Server

**Using .pgpass (Recommended)**
```bash
# SSH into postgresqljail first
ssh 192.168.2.30

# Then connect without password (uses ~/.pgpass)
psql -U postgres -d mediawiki
```

**Status:** ✅ `.pgpass` configured at `/var/db/postgres/.pgpass` (2026-01-31)
- **Credentials:** 192.168.2.30:5432:mediawiki:postgres:[PASSWORD]
- **Permissions:** 600 (secure, only postgres user can read)

### Databases & Credentials

**⚠️ IMPORTANT: All database and website passwords are stored in `/Users/georgemagnuson/Documents/GitHub/.env` (NOT committed to git)**

**DO NOT add passwords to this repository.** Check the `.env` file for:
- MediaWiki database credentials (postgres user)
- MediaWiki web interface login (Georgemagnuson user)
- All other database passwords

**Databases:**
| Database | User | Purpose |
|----------|------|---------|
| `mediawiki` | postgres | MediaWiki data & SMW properties (postgresqljail) |
| `wiki_compliance` | wiki_compliance | Wiki.js documentation |
| `fcp_data` | mediawiki | Business details, operators, managers |

See `.env` file for all connection passwords and credentials.

---

## Key File Locations

### MediaWiki (llamajail - 192.168.2.10)
```
Installation:    /usr/local/www/mediawiki/
Config:          /usr/local/www/mediawiki/LocalSettings.php
Extensions:      /usr/local/www/mediawiki/extensions/
                 - PageForms (6.0.4)
                 - SemanticMediaWiki (6.0.1)
                 - ParserFunctions (enabled)
Maintenance:     /usr/local/www/mediawiki/maintenance/
```

### Wiki.js (djangojail - 192.168.2.20)
```
Installation:    /var/www/wiki/
Config:          /var/www/wiki/config.yml
Nginx Config:    /usr/local/etc/nginx/nginx.conf
SSL Certs:       /usr/local/etc/nginx/ssl/
```

### PostgreSQL (postgresqljail - 192.168.2.30)
```
Data Directory:  /var/db/postgres/
Config:          /var/db/postgres/data/postgresql.conf
```

---

## Common Commands

### Service Management

```bash
# Apache (llamajail)
sudo service apache24 status
sudo service apache24 restart

# Nginx (djangojail)
sudo service nginx status
sudo service nginx restart

# PostgreSQL (postgresjail)
sudo service postgresql status
sudo service postgresql restart
```

### MediaWiki Maintenance

```bash
# Clear cache after template or page changes (CRITICAL after deployments)
php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
php /usr/local/www/mediawiki/maintenance/runJobs.php

# Rebuild semantic data (required after form submissions to archive pages)
php /usr/local/www/mediawiki/maintenance/runJobs.php --maxjobs=1000

# Update database schema
php /usr/local/www/mediawiki/maintenance/update.php

# Quick SSH + maintenance (from local machine, no password needed)
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'
```

### Database Queries

```bash
# List all databases (uses ~/.pgpass)
psql -U postgres -h 192.168.2.30 -l

# List tables in mediawiki database (uses ~/.pgpass)
psql -U postgres -d mediawiki -h 192.168.2.30 -c "\dt"

# List SMW properties (uses ~/.pgpass)
psql -U postgres -d mediawiki -h 192.168.2.30 -c "SELECT * FROM mediawiki.smw_object_ids WHERE smw_iw = '' LIMIT 20;"

# Query FCP pages (uses ~/.pgpass)
psql -U postgres -d mediawiki -h 192.168.2.30 -c "SELECT page_title FROM mediawiki.page WHERE page_title LIKE 'FCP%' ORDER BY page_title;"
```

### SQL Deployment Pattern (for Phase deployments)

**Standard 3-step deployment (with backup & verification):**

```bash
# 1. Create backup before deployment (uses ~/.pgpass)
pg_dump -h 192.168.2.30 -U postgres -d mediawiki > /tmp/backup_mediawiki_$(date +%Y%m%d_%H%M%S).sql

# 2. Deploy SQL script (uses ~/.pgpass)
psql -h 192.168.2.30 -U postgres -d mediawiki -f /path/to/script.sql

# 3. Verify deployment (uses ~/.pgpass)
# Check that pages were created with correct IDs
psql -h 192.168.2.30 -U postgres -d mediawiki -c "SELECT page_id, page_title FROM mediawiki.page WHERE page_id BETWEEN 313 AND 317;"
```

**After SQL deployment, always clear MediaWiki cache:**

```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'
```

**Rollback if needed:**

```bash
# Restore from backup (uses ~/.pgpass)
psql -h 192.168.2.30 -U postgres -d mediawiki < /tmp/backup_mediawiki_*.sql
```

---

## MediaWiki Page Creation Methods

### Recommended: mw-crud API Skill ✅

**Status:** Fully working (2026-02-19)
**Memory Bank:** `bfcb00aa-03eb-46b3-8710-8b9417b15c86` — SOLVED: MediaWiki API / mw-crud Fully Working
**Credentials:** See `.env` file (`MEDIAWIKI_USERNAME` and `MEDIAWIKI_PASSWORD`)

```bash
# Get credentials from .env
source .env

# Read a page
~/.claude/skills/mediawiki-crud/mw-crud read "Page Title" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"

# Create a page
~/.claude/skills/mediawiki-crud/mw-crud create "New Page" \
  --content "Page content here" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"

# Update a page
~/.claude/skills/mediawiki-crud/mw-crud update "Page Title" \
  --content "Updated content" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"

# Delete a page
~/.claude/skills/mediawiki-crud/mw-crud delete "Page Title" \
  --reason "No longer needed" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"
```

**Or use placeholder (replace with actual values from .env):**
```bash
~/.claude/skills/mediawiki-crud/mw-crud read "Page Title" \
  --url "$MEDIAWIKI_API_URL" \
  --username "Georgemagnuson" --password "[See .env: MEDIAWIKI_PASSWORD]"
```

**Advantages:**
- Full edit history and audit trail in MediaWiki
- Automatically updates SMW semantic indexes
- Properly invalidates all caches
- Handles CSRF tokens and conflict detection
- No risk of revision sequence errors

### Direct SQL Database ⚠️ AVOID FOR PAGE CONTENT

**Status:** Use ONLY for schema/infrastructure queries — NOT for creating or editing pages.

**Why not:** Direct SQL inserts bypass PostgreSQL sequences, causing `duplicate key` revision errors when MediaWiki next tries to write. Always run the sequence fix after any direct SQL page inserts:

```sql
-- Run this after ANY direct SQL inserts into MediaWiki tables
SELECT setval('mediawiki.page_page_id_seq', (SELECT MAX(page_id) + 1 FROM mediawiki.page));
SELECT setval('mediawiki.revision_rev_id_seq', (SELECT MAX(rev_id) + 1 FROM mediawiki.revision));
SELECT setval('mediawiki.text_old_id_seq', (SELECT MAX(old_id) + 1 FROM mediawiki.text));
SELECT setval('mediawiki.content_content_id_seq', (SELECT MAX(content_id) + 1 FROM mediawiki.content));
```

**Safe SQL uses:** Querying data, fixing sequences, checking page IDs, bulk data migrations with sequence fix.

### Other Methods (Not Recommended)

**PHP Maintenance Script (edit.php)** ❌
- Has persistent bugs in MediaWiki 1.43.5
- Not recommended for production use

---

## MediaWiki User Creation & Management

⚠️ **IMPORTANT:** All credentials are stored in `.env` file (not committed to git). See `.env` for:
- `MEDIAWIKI_USERNAME` - Admin user for API operations
- `MEDIAWIKI_PASSWORD` - Admin password for API operations
- `MEDIAWIKI_API_URL` - API endpoint URL
- `MEDIAWIKI_URL` - Web interface URL

### Important: MediaWiki vs PostgreSQL Users

**MediaWiki Users** (separate from database users):
- Stored in `mediawiki.user` table (application level)
- Used for: Web interface login, permissions, activity tracking
- Examples: `Georgemagnuson`, `Manager`, `Inspector`, etc.
- Create as many as needed without creating PostgreSQL users

**PostgreSQL Users** (database system level):
- Only ONE needed for entire application: `postgres` (in LocalSettings.php)
- Not related to web login users

### Create Users via Web Interface (Recommended for Admins)

**1. Direct Creation (Simplest):**
```
1. Navigate to: http://192.168.2.10/mediawiki/Special:CreateAccount
2. Or: http://192.168.1.18/mediawiki/Special:CreateAccount (via reverse proxy)
3. Enter username and password
4. Click "Create account"
```

**2. Add to Groups (Optional - requires sysop):**
```
1. Navigate to: Special:UserRights
2. Enter username
3. Select group(s):
   - sysop (system administrator)
   - bureaucrat (manage user groups)
   - interface-admin (edit site interface)
   - data-entry-staff (staff who submit forms)
   - manager (oversee operations)
   - inspector (read-only access)
4. Click "Update user groups"
```

### Create Users via MediaWiki API

**Create a basic user account (using .env credentials):**
```bash
# Load credentials from .env
source .env

# Using mw-crud (simpler method)
~/.claude/skills/mediawiki-crud/mw-crud create "User:NewUsername" \
  --content "New user account" \
  --url "$MEDIAWIKI_API_URL" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"
```

**Create user with API token (advanced):**
```bash
# Credentials in .env file
curl -X POST "http://192.168.2.10/mediawiki/api.php" \
  -d "action=createaccount" \
  -d "lgname=NewUsername" \
  -d "lgpassword=TempPassword123!" \
  -d "lgconfirmpassword=TempPassword123!" \
  -d "format=json" \
  -d "realname=First Last" \
  -d "mailaddress=email@example.com"
```

### Add User to Groups via API

```bash
curl -X POST "http://192.168.2.10/mediawiki/api.php" \
  -d "action=userrights" \
  -d "user=NewUsername" \
  -d "add=sysop|bureaucrat" \
  -d "token=TOKEN_FROM_QUERY_TOKENS" \
  -d "format=json"
```

### Query Existing Users

```bash
# From database (uses .pgpass)
psql -h 192.168.2.30 -U postgres -d mediawiki << 'EOF'
SELECT user_id, user_name, user_email, user_registration
FROM mediawiki.user
ORDER BY user_id;
EOF

# From MediaWiki API (use .env credentials)
source .env
~/.claude/skills/mediawiki-crud/mw-crud read "Special:ListUsers" \
  --url "$MEDIAWIKI_API_URL" \
  --username "$MEDIAWIKI_USERNAME" --password "$MEDIAWIKI_PASSWORD"
```

### Reset User Password

**Via Web Interface (if admin):**
```
1. Special:ChangePassword
2. Or: Special:UserRights → "Email new password" button (for other users)
```

**Via Database:**
```bash
psql -h 192.168.2.30 -U postgres -d mediawiki << 'EOF'
-- Update user password (requires bcrypt hash)
-- Use Special:ResetPassword in web interface instead (safer)
UPDATE mediawiki.user
SET user_password = ':pbkdf2:1000:HASH_HERE'
WHERE user_name = 'Username';
EOF
```

### User Permissions Quick Reference

| Group | Permissions |
|-------|-----------|
| **user** (default) | Read pages, edit non-protected pages, upload files |
| **sysop** | All permissions (edit protected pages, delete, block users) |
| **bureaucrat** | Manage user groups and permissions |
| **interface-admin** | Edit MediaWiki interface (CSS, JS, templates) |
| **data-entry-staff** | Submit forms, create records |
| **manager** | Review submissions, manage staff |
| **inspector** | Read-only access to all records |

### Testing New User Account

```bash
# Test login with new credentials (from .env or direct entry)
source .env
~/.claude/skills/mediawiki-crud/mw-crud read "Main_Page" \
  --url "$MEDIAWIKI_API_URL" \
  --username "NewUsername" --password "NewUserPassword"
# Note: Replace NewUserPassword with the actual password set when creating the user
```

---
---

## Breadcrumb Navigation

**Extension:** Semantic Breadcrumb Links 2.1.0-alpha  
**Method:** Subpage notation (slash-based hierarchy)  
**Rendering:** Breadcrumb trail appears in `mw-indicators` area above page title

**How to Use:**
- Create pages using slash notation: `Parent/Child/Grandchild`
- Parent pages must exist as actual wiki pages for clickable links
- Format automatically shows: `Parent / Child / Grandchild`
- Current page displays as plain text, parents are clickable links

**Examples:**
```
FCP/Closing/Cleaning_up → Shows: FCP / Closing / Cleaning_up
Form/Daily_Pest_Inspection → Shows: Form / Daily Pest Inspection
Training/Safety_Basics → Shows: Training / Safety Basics
```

**Configuration:**  
Located in `/usr/local/www/mediawiki/LocalSettings.php`:
```php
wfLoadExtension( 'SemanticBreadcrumbLinks' );
$GLOBALS['egSBLPropertySearchPatternByNamespace'] = [
    NS_MAIN => ['Has parent page', 'Has parent page', 'Has parent page']
];
```

**For Migration Details:** See Memory Bank UUID `75e5e63d-6e92-44ca-82cc-832c72a288b1`

---

## SMW Query Patterns

**Purpose:** Query submitted form data using Semantic MediaWiki

**Common Patterns:**
```wiki
# Today's records
{{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]] }}

# Last 7 days
{{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]] }}

# Pass/Fail filtering
{{#ask: [[Has_pass_fail_status::Pass]] [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]] }}

# Severity filtering
{{#ask: [[Has_incident_severity::Critical]] OR [[Has_incident_severity::High]] }}
```

**Available SMW Properties:**
- `Has_submission_date`, `Has_record_type`, `Has_staff_name`, `Has_form_name`
- `Has_temperature`, `Has_temperature_unit`, `Has_equipment_unit`
- `Has_food_item`, `Has_pass_fail_status`, `Has_corrective_action`
- `Has_incident_severity`, `Has_investigation_status`

---

## PageForms Pattern

**Standardized Pattern for Data Entry Systems:**

1. **Form:** `Form:DataType` (defines input fields)
2. **Template:** `Template:DataType` (displays submitted data)
3. **Category:** `Category:DataType` (organizes entries)
4. **Portal Page:** Hub page with form input and category tree

**Form Input Tag:**
```wiki
{{#forminput:form=DataType|placeholder=Enter name|button text=Create DataType}}
```

**Parameter:** Use `default form=Prefix:` for semantic grouping (e.g., `default form=Equipment:`)

**For Details:** See Memory Bank for "Standardized PageForms Pattern" documentation


## MediaWiki Extensions

### Page Forms 6.0.4
- **Purpose:** Form-based data entry interface
- **Usage:** Business details forms, structured data input
- **Documentation:** https://www.mediawiki.org/wiki/Extension:Page_Forms

### Semantic MediaWiki (SMW) 6.0.1
- **Purpose:** Semantic structure and queryable properties
- **Usage:** Store form data with semantic annotations
- **Query Syntax:** `{{#ask: [[Category:Business Details]] |?SMW_legal_name |?SMW_activity }}`
- **Documentation:** https://www.semantic-mediawiki.org/

### ParserFunctions
- **Purpose:** Conditional logic in templates
- **Usage:** `{{#if:}}`, `{{#ifeq:}}`, `{{#switch:}}`
- **Configuration:** Enabled in LocalSettings.php
- **Documentation:** https://www.mediawiki.org/wiki/Extension:ParserFunctions

### SubpageNavigation
- **Purpose:** Automatic page navigation for subpages
- **Usage:** Hierarchical page organization with breadcrumb navigation
- **Status:** Enabled and active

### Echo
- **Purpose:** User notifications system
- **Usage:** Alerts for page changes, user interactions
- **Status:** Enabled and active

### CategoryTree
- **Purpose:** Display category contents as expandable tree
- **Usage:** Interactive category browsing and navigation
- **Status:** Enabled and active

---

## FCP Color Scheme

| Category | Color | Hex Code | Usage |
|----------|-------|----------|-------|
| **FCP 01: Setting up** | Dark Blue | `#1a3a52` | Opening procedures |
| **FCP 02: Preparing** | Green | `#10b981` | Food preparation |
| **FCP 03: Making + Cooking** | Magenta | `#ec4899` | Cooking & temperature |
| **FCP 04: Serving + Selling** | Orange | `#f97316` | Service procedures |
| **FCP 05: Closing** | Purple | `#8b5cf6` | Closing & cleanup |
| **Troubleshooting** | Red | `#ef4444` | Problem resolution |
| **Specialist Tasks** | Teal | `#14b8a6` | Specialized procedures |
| **General** | Gray | `#6b7280` | Standard procedures |

---

## Memory Bank

**Purpose:** Persistent knowledge base for project history, implementation details, and troubleshooting guides
**Database Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/memory-bank/context.db`
**Schema Version:** v3.0 (with relationship tracking)

### How to Use Memory Bank

**Initialize for current project:**
```bash
# From project root
work on pwd
```

**Search for documents:**
```bash
# General search
search_documents('query')

# By timestamp
search_by_timestamp(start_date='2026-02-01', limit=10)

# By importance
search_by_importance(min_importance=8, limit=10)
```

**Common Search Topics:**
- `"mw-crud"` - API skill usage and troubleshooting
- `"OATHAuth"` - Authentication fix procedures
- `"sequence"` - PostgreSQL sequence sync fix
- `"breadcrumb"` - Navigation implementation details
- `"migration"` - Page migration procedures
- `"access control"` - Namespace security configuration
- `"page forms"` - Form/template pattern documentation

**Save new information:**
```bash
save_document(title="...", content="...", importance=8, tags="...")
save_plan(title="...", content="...", priority="high")
save_decision(title="...", content="...", impact="high")
```

**Retrieve specific documents by UUID:**
See troubleshooting sections below for relevant UUIDs

---

## Troubleshooting

### mw-crud API Authentication Fails — OATHAuth Error
**Symptom:** `internal_api_error_DBQueryError: relation "oathauth_devices" does not exist`
**Memory Bank:** `bfcb00aa-03eb-46b3-8710-8b9417b15c86`

**Cause:** OATHAuth extension loaded but database tables not yet created.

**Fix:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && sudo -u www php maintenance/update.php --quick'
```

**Diagnose any API error with debug logging:**
```php
# Add temporarily to LocalSettings.php, remove when done
$wgDebugLogFile = "/tmp/mediawiki-debug.log";
$wgDebugLogGroups = ["DBQuery" => "/tmp/mediawiki-dbquery.log"];
```
```bash
ssh 192.168.2.10 'grep -i "error\|exception" /tmp/mediawiki-debug.log | tail -30'
```

### MediaWiki Revision Errors After Direct SQL Inserts
**Symptom:** `duplicate key value violates unique constraint "revision_pkey"`
**Cause:** Direct SQL inserts bypass PostgreSQL sequences, leaving them out of sync.

**Fix — always run after direct SQL inserts:**
```bash
psql -h 192.168.2.30 -U postgres -d mediawiki << 'EOF'
SELECT setval('mediawiki.page_page_id_seq', (SELECT MAX(page_id) + 1 FROM mediawiki.page));
SELECT setval('mediawiki.revision_rev_id_seq', (SELECT MAX(rev_id) + 1 FROM mediawiki.revision));
SELECT setval('mediawiki.text_old_id_seq', (SELECT MAX(old_id) + 1 FROM mediawiki.text));
SELECT setval('mediawiki.content_content_id_seq', (SELECT MAX(content_id) + 1 FROM mediawiki.content));
EOF
```

**Prevention:** Use mw-crud API for all page creation/editing. See **MediaWiki Page Creation Methods** above.

### MediaWiki Template Issues
1. Check ParserFunctions is enabled in LocalSettings.php
2. Clear cache: `php maintenance/purgeList.php --db-touch`
3. Run jobs: `php maintenance/runJobs.php`

### Database Connection Issues
1. Verify PostgreSQL is running: `sudo service postgresql status`
2. Check pg_hba.conf for access rules
3. Test connection: `psql -U postgres -d mediawiki -h 192.168.2.30` (uses ~/.pgpass)
4. Check LocalSettings.php database configuration

### SSH Access Issues
1. Try alternate SSH key: `id_rsa` vs `id_rsa-remote-ssh`
2. Verify key permissions: `chmod 600 ~/.ssh/id_rsa`
3. Check network connectivity: `ping 192.168.2.10`
4. Verify jail is running on host system

### Unexpected Reboot Recovery (Added 2026-02-23)

**Symptom:** MediaWiki returns HTTP 503 with "Semantic MediaWiki - Maintenance" message after unexpected reboot.

**Cause:** SMW maintenance scripts (setupStore.php, rebuildData.php) interrupted by reboot, leaving SMW in maintenance mode.

**Recovery Steps:**

1. Verify services are running:
```bash
ssh 192.168.2.10 'uptime && sudo service apache24 status'
ssh 192.168.2.30 'sudo service postgresql status'
```

2. Check for maintenance mode:
```bash
curl -s "http://192.168.2.10/mediawiki/index.php/Main_Page" | grep -i "maintenance"
```

3. Complete SMW setup to clear maintenance lock:
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki/extensions/SemanticMediaWiki && \
  sudo -u www php maintenance/setupStore.php --skip-optimize'
```

4. Verify MediaWiki is accessible:
```bash
curl -s -o /dev/null -w "%{http_code}" "http://192.168.2.10/mediawiki/index.php/Main_Page"
```
Expected: `200` or `302` (redirect to login)

5. If still having issues, restart Apache:
```bash
ssh 192.168.2.10 'sudo service apache24 restart'
```

**Memory Bank:** UUID `4d7f0430-715f-4d9e-a53a-59736f5f7e0d` (Recovery Procedure, 9/10 importance)

---

## MediaWiki Access Control Configuration

### Overview (Implemented 2026-02-19)

**Purpose:** Protect sensitive FCP compliance documentation (employee records, temperature logs, incident reports) while providing a professional branded entry point for authorized users.

**Status:** ✅ ACTIVE

**Configuration:**
- Anonymous users redirected to `Jitsu_Home` landing page
- All content except landing page requires authentication
- Existing `Main_Page` preserved as comprehensive portal for authenticated users

### Jitsu_Home Landing Page (Page ID: 10013)

**Features:**
- Minimal design with centered Jitsu logo (192×192px)
- Conditional content using ParserFunctions:
  - **Anonymous users:** See "Log In" button (redirects to Special:UserLogin)
  - **Authenticated users:** See "Enter System" button (links to Main_Page)
- Dark blue theme (#1a3a52) matching FCP color scheme
- No table of contents or edit sections

**Location:** `http://192.168.2.10/mediawiki/index.php/Jitsu_Home`

### Access Control Rules (LocalSettings.php)

**Disabled Anonymous Reading:**
```php
$wgGroupPermissions['*']['read'] = false;
```

**Whitelisted Public Pages:**
1. Landing page: `Jitsu_Home`
2. Authentication pages: `Special:UserLogin`, `Special:UserLogout`, `Special:PasswordReset`, `Special:ChangePassword`
3. System CSS/JS: `MediaWiki:Common.css`, `MediaWiki:Common.js`, `MediaWiki:Vector.css`, `MediaWiki:Vector.js`
4. Logo images: `File:Jitsu_logo_192x192.png`, `File:Jitsu_logo_135x135.png`

**Main Page Redirect Hook:**
- Anonymous users accessing `/index.php/Main_Page` are redirected to `Jitsu_Home`
- Authenticated users can access Main_Page normally

**Logout Redirect Hook:**
- Authenticated users are redirected to `Jitsu_Home` landing page after logging out
- Uses `UserLogoutComplete` hook with 302 (temporary) redirect
- Clears session and returns user to public landing page

### Configuration File Location

**File:** `/usr/local/www/mediawiki/LocalSettings.php` (on 192.168.2.10)

**Backup:** `/usr/local/www/mediawiki/LocalSettings.php.backup-YYYYMMDD-HHMMSS` (created before modification)

**To modify access control:**
1. SSH to 192.168.2.10
2. Edit `/usr/local/www/mediawiki/LocalSettings.php`
3. Update `$wgGroupPermissions` or `$wgWhitelistRead` array as needed
4. Clear cache: `php maintenance/purgeList.php --db-touch`
5. Restart Apache: `sudo service apache24 restart`

### Testing Access Control

**Test anonymous access to landing page:**
```bash
curl -s http://192.168.2.10/mediawiki/index.php/Jitsu_Home | grep -o "Jitsu_logo\|Welcome"
# Expected: Jitsu_logo and Welcome text present
```

**Test anonymous access to protected content:**
```bash
curl -s -o /dev/null -w "%{http_code}\n" \
  http://192.168.2.10/mediawiki/index.php/Special:SpecialPages
# Expected: 403 (Forbidden) or 401 (Unauthorized)
```

**Test authenticated access (requires login):**
1. Login at: http://192.168.2.10/mediawiki/Special:UserLogin
2. Use credentials: Username = `Georgemagnuson`, Password = (see `.env` file: `MEDIAWIKI_PASSWORD`)
3. Navigate to Main_Page — should be fully accessible

**Test logout redirect:**
1. After login, navigate to: http://192.168.2.10/mediawiki/Special:UserLogout
2. Should redirect to Jitsu_Home landing page
3. Should see "Log In" button (anonymous view)
4. Verify session is cleared (cannot access Main_Page without re-login)

### Rollback Procedure

**If access control causes issues:**

```bash
# 1. SSH to server
ssh 192.168.2.10

# 2. Restore backup
sudo cp /usr/local/www/mediawiki/LocalSettings.php.backup-YYYYMMDD-HHMMSS \
        /usr/local/www/mediawiki/LocalSettings.php

# 3. Restart Apache
sudo service apache24 restart

# 4. (Optional) Delete landing page if not needed
export MEDIAWIKI_API_URL="http://192.168.2.10/mediawiki/api.php"
export MEDIAWIKI_USERNAME="Georgemagnuson"
export MEDIAWIKI_PASSWORD="[from .env: MEDIAWIKI_PASSWORD]"

~/.claude/skills/mediawiki-crud/mw-crud delete "Jitsu_Home" \
  --reason "Rollback" \
  --url "$MEDIAWIKI_API_URL" \
  --username "$MEDIAWIKI_USERNAME" \
  --password "$MEDIAWIKI_PASSWORD"
```

---

## Namespace-Based Security Architecture

### Overview (Implemented 2026-02-20)

**Purpose:** Segregate data by confidentiality level using custom MediaWiki namespaces with role-based access controls.

**Status:** ✅ FULLY OPERATIONAL (Phases 1-6 Complete, Tested)

**Implementation Date:** 2026-02-20
**Memory Bank:** `e06440d3-f035-4d91-bb27-7e3b0b3a1f6c` (Importance: 10/10)

### Custom Namespaces

| Namespace | ID | Purpose | Employee Access | Manager Access | Inspector Access |
|-----------|-----|---------|----------------|----------------|------------------|
| **FCP_MAIN** | 3000 | Food Control Plan docs | Read only | Read only | Read only |
| **FCP_FORMS** | 3002 | Form templates | Read only | Read/Edit | Read only |
| **JITSU_DATA** | 3004 | Operational data (collaborative) | Read/Edit | Read/Edit | Read only |
| **JITSU_EMPLOYEES** | 3006 | Employee HR records | ❌ Blocked | Read/Edit | ❌ Blocked |
| **JITSU_EMPLOYEES_TRAINING** | 3008 | Training records (per-user) | Own only* | Read/Edit | Read only |
| **JITSU_CONFIDENTIAL** | 3010 | Business-sensitive data | ❌ Blocked | Read/Edit | ❌ Blocked |
| **JITSU_REPORTS** | 3012 | Reports and summaries | Read only | Read/Edit | Read only |

*Employees can only access their own training records via Semantic ACL (e.g., JITSU_EMPLOYEES_TRAINING:Carlos_Chef/*)

### User Groups

| Group | Database Name | Purpose | Key Permissions |
|-------|--------------|---------|----------------|
| **Employee** | `data_recorder` | Staff who submit forms | Read FCP, edit JITSU_DATA, own training only |
| **Manager** | `data_editor` | Supervisors | Full access to employees, confidential data, forms |
| **Inspector** | `inspector` | Food safety auditors | Read-only access (no employee HR or confidential) |
| **Admin** | `sysop` | System administrators | Full access to everything including templates |

### Security Extensions

**Lockdown Extension** (Namespace-wide restrictions)
- Controls read/write access by namespace
- Enforces group-based permissions
- Configuration: LocalSettings.php lines 420-455

**Semantic ACL Extension** (Per-page restrictions)
- Fine-grained access control using semantic properties
- Example: `[[Visible to::User:Carlos_Chef]]`
- Used for training records (employees see only their own)

### Page Naming Conventions

**FCP Content:**
```
FCP_MAIN:Section/Topic
Example: FCP_MAIN:Closing/Cleaning_up
```

**Employee Records:**
```
JITSU_EMPLOYEES:FirstName_LastName
Example: JITSU_EMPLOYEES:Carlos_Chef
```

**Training Records:**
```
JITSU_EMPLOYEES_TRAINING:EmployeeName/Section
Example: JITSU_EMPLOYEES_TRAINING:Carlos_Chef/Personal_Hygiene
```

**Operational Data:**
```
JITSU_DATA:DataType/Identifier/Date
Example: JITSU_DATA:Temperature/Walk-in_Cooler/2026-02-20
```

**Reports:**
```
JITSU_REPORTS:ReportName
Example: JITSU_REPORTS:Employee_Training_Status
```

### Access Control Testing

**Test Accounts (Password: TestPassword123):**
- Carlos Chef (data_recorder) - Employee access
- Sarah Manager (data_editor) - Manager access
- Tom Waiter (data_recorder) - Employee access
- Test Inspector (inspector) - Read-only inspector access
- Georgemagnuson (sysop) - Full admin access

**Test Results (2026-02-20):**
- ✅ Employees blocked from HR records (JITSU_EMPLOYEES)
- ✅ Employees blocked from confidential data (JITSU_CONFIDENTIAL)
- ✅ Employees can read/edit collaborative data (JITSU_DATA)
- ✅ Managers can access all employee and confidential data
- ✅ Inspectors have read-only access (cannot edit anything)
- ✅ Semantic ACL restricts training records to employee + managers
- ✅ Sysops have full access including template editing

### Configuration Files

**LocalSettings.php Sections:**
- Lines 107-164: Custom namespace definitions
- Line ~407: Sysop group permissions (CRITICAL)
- Lines 420-455: Lockdown namespace permissions
- Following: Semantic ACL configuration
- End of file: Namespace protection settings

**Backup Files:**
- `/usr/local/www/mediawiki/LocalSettings.php.backup-20260220-202505` (pre-implementation)
- `/usr/local/www/mediawiki/LocalSettings.php.backup-before-namespaces`
- Multiple timestamped backups available

### Common Operations

**Create a training record:**
```bash
~/.claude/skills/mediawiki-crud/mw-crud create \
  "JITSU_EMPLOYEES_TRAINING:Carlos_Chef/Food_Safety" \
  --content "Training completion record" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "Georgemagnuson" --password "TestPassword123"
```

**Create an employee record:**
```bash
~/.claude/skills/mediawiki-crud/mw-crud create \
  "JITSU_EMPLOYEES:New_Employee" \
  --content "{{Employee|employee_name=New Employee|position=Cook}}" \
  --url "http://192.168.2.10/mediawiki/api.php" \
  --username "Georgemagnuson" --password "TestPassword123"
```

**Query user groups:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && sudo -u www php maintenance/run.php sql \
  --query="SELECT u.user_name, ug.ug_group FROM mediawiki.user u JOIN mediawiki.user_groups ug ON u.user_id = ug.ug_user ORDER BY u.user_name;"'
```

### Semantic ACL Examples

**Training record template with per-user access:**
```wiki
<includeonly>
<!-- Training completion data -->
{{#cargo_store:_table=training_completions
|employee_name={{{employee_name|}}}
|training_section={{{training_section|}}}
}}

<!-- Access Control -->
[[Visible to::User:{{{employee_name|}}}]]
[[Visible to::Group:data_editor]]
[[Editable by::Group:data_editor]]

[[Category:Training_Completion]]
</includeonly>
```

**Confidential report with manager-only access:**
```wiki
Confidential business information here.

[[Visible to::Group:data_editor]]
[[Visible to::Group:sysop]]

[[Category:Confidential]]
```

---

## Technical Notes

- All systems use FreeBSD with jail infrastructure
- Key-based SSH authentication only (no password login)
- PostgreSQL database at 192.168.2.30 is primary data store
- MediaWiki uses both file storage and database in `mediawiki` schema (not `public`)
- MediaWiki database user is `postgres` (superuser)
- Semantic properties stored in `mediawiki.smw_*` tables
- Template cache requires manual purging after changes: `php maintenance/purgeList.php --db-touch`
- Database schema auto-maintained by MediaWiki update script
- Color scheme supports accessibility standards
- OpenVPN tunnel connects JITSU to ASTEROID M for DB access
- All jails configured with persistent storage and auto-start on reboot
- **PostgreSQL `.pgpass` configured** (2026-01-31): `/var/db/postgres/.pgpass` on postgresqljail enables password-less psql connections and secure automated scripts/cron jobs

---

## Contact & Resources

**Project Owner:** George Magnuson
**Local Dev Path:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/`
**Documentation:** CLAUDE.md in project root
**Memory Bank:** 102 documents covering architecture, guides, specifications, and implementation status
