# FCP_DCC Quick Reference

**Project:** Food Control Plan Compliance Documentation & Diary System
**Last Updated:** 2026-02-19
**Status:** Phase 5: mw-crud API operational, Breadcrumb navigation installed, MediaWiki fully restored

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

## Current Project Status

### ✅ Completed (as of 2026-02-19)

**Phase 5: MediaWiki Restoration & API Tooling (Completed 2026-02-19)**

- **MediaWiki Fully Restored:**
  - Fixed LocalSettings.php — skins and all extensions now load correctly
  - Ran `maintenance/update.php` — created missing OATHAuth tables (`oathauth_devices`, `oathauth_types`)
  - MediaWiki accessible at https://192.168.1.18/mediawiki/

- **mw-crud API Skill — Fully Operational:**
  - All CRUD operations working: Read, Create, Update, Delete
  - Root cause of previous failures: missing OATHAuth database tables
  - Memory Bank: `bfcb00aa-03eb-46b3-8710-8b9417b15c86`
  - Skill location: `~/.claude/skills/mediawiki-crud/mw-crud`

- **Semantic Breadcrumb Links Extension Installed:**
  - Version 2.1.0-alpha, cloned from GitHub
  - Breadcrumb trail renders in `mw-indicators` area above page title
  - Format: `Parent / Level1 / CurrentPage` (all clickable links)
  - Uses `[[Has parent page::ParentName]]` semantic property
  - Also falls back to subpage notation (e.g. `Page/Subpage/SubSubpage`) automatically
  - Configuration added to LocalSettings.php:
    ```php
    $GLOBALS['egSBLPropertySearchPatternByNamespace'] = [
        NS_MAIN => ['Has parent page', 'Has parent page', 'Has parent page']
    ];
    ```

- **Staff Training System Phase 1 (Completed 2026-02-16)**
  - 21 pages deployed (IDs 370-390)
  - See `STAFF_TRAINING_QUICK_REFERENCE.md` for details

### ✅ Completed (as of 2026-02-01)

**Phase 1: Record Management Pages (Completed 2026-01-30)**
- Daily_Records (page_id: 230) - 16 form links
- Weekly_Records (page_id: 231) - 9 form links
- Monthly_Records (page_id: 232) - 4 form links
- Incident_Records (page_id: 233) - 8 form links
- Total: 37 form links across 4 organized pages

**Phase 3: Records Archive System with SMW Queries (Completed 2026-01-31)**

- **5 Archive Pages Created** (page_id 313-317):
  - Records_Archive (313) - Main hub with navigation and summary statistics
  - Records_Archive/Daily (314) - Today's submitted records with pass/fail counts
  - Records_Archive/Weekly (315) - Last 7 days with failure tracking and trends
  - Records_Archive/Monthly (316) - Last 30 days with incident severity tracking
  - Records_Archive/Search (317) - Advanced search with multiple filter options

- **40+ SMW Queries Deployed:**
  - Date-based filtering (today, 7 days, 30 days, 60 days, 90 days)
  - Status filtering (Pass/Fail)
  - Severity filtering (Critical, High, Medium)
  - Form type filtering (temperature, maintenance, incidents)
  - Staff tracking and performance views
  - Temperature monitoring queries

- **SMW Query Patterns Used:**
  ```wiki
  {{#ask: [[Has_submission_date::{{CURRENTYEAR}}-{{CURRENTMONTH}}-{{CURRENTDAY}}]] }}
  {{#ask: [[Has_submission_date::>{{#time:Y-m-d|now -7 days}}]] }}
  {{#ask: [[Has_pass_fail_status::Pass]] [[Has_submission_date::>{{#time:Y-m-d|now -30 days}}]] }}
  {{#ask: [[Has_incident_severity::Critical]] OR [[Has_incident_severity::High]] }}
  ```

- **Deployment Details:**
  - Database: mediawiki on 192.168.2.30
  - Backup created: `/tmp/backup_mediawiki_before_phase3_20260131_*.sql`
  - Atomic transaction: All 25 INSERT operations successful
  - Cache cleared: `php maintenance/purgeList.php --db-touch`
  - Job queue processed: `php maintenance/runJobs.php`

- **Testing Status:**
  - All pages accessible and verified
  - All SMW queries syntactically correct
  - Ready for form submission testing
  - Pages display "No records" until data is submitted (expected behavior)

**Phase 2: SMW Properties & Form Templates (Completed 2026-01-30, Deployed to Production)**
- **12 SMW Properties Created & Deployed:**
  1. Has_submission_date
  2. Has_record_type
  3. Has_staff_name
  4. Has_form_name
  5. Has_temperature
  6. Has_temperature_unit
  7. Has_equipment_unit
  8. Has_food_item
  9. Has_pass_fail_status
  10. Has_corrective_action
  11. Has_incident_severity
  12. Has_investigation_status

- **30 Form Templates Updated with SMW Annotations:**
  - Orange Section (7 templates): Temperature Monitoring, Equipment Log, Daily Checklist, Facility Inspection, Staff Training, Maintenance Request, Cleaning Schedule
  - Purple Section (9 templates): Vendor Documentation, Supplier Audit, Product Receipt, Quality Verification, Lot Tracking, Certificate of Analysis, Supplier Contact, Product Specification, Safety Data Sheet
  - Red Section (8 templates): Incident Report, Non-Conformance, Corrective Action, Root Cause Analysis, Investigation, Follow-up, Escalation, Closure
  - Teal Section (6 templates): SOP Implementation, Process Documentation, Staff Competency, Training Assessment, Procedure Review, Knowledge Transfer

- **Production Deployment:**
  - Deployment Date: 2026-01-30
  - Database Pages: 301-312 (12 dedicated infrastructure pages)
  - Git Commits: cd8af49, 5ef768b, 0862f36
  - Backup Location: /tmp/backup_mediawiki_before_phase2_20260130_181128.sql
  - All properties indexed and queryable in production

**MediaWiki Implementation:**
- Template:BusinessDetails - Production ready with conditional display
- ParserFunctions extension enabled and working
- Business entry form: FCP:Setting_Up:Business_details
- 2 business pages created (The Jitsu Ltd)
- Category cleanup completed
- SMW cache and semantic index rebuilt

**Dark Blue Sections Documentation:**
- Sections 4-11 fully documented and ready for MediaWiki implementation (created 2026-01-26)
- Complete specifications for: Business Layout, Risk Management, Taking Responsibility, Plan Monitoring, Training & Competency, Equipment & Facilities, Water Supply (Registered), Water Supply (Self-Supply)
- SMW properties identified for each section
- Forms and templates designed

**Infrastructure:**
- PostgreSQL 17.0 on postgresqljail fully operational
- MediaWiki 1.43.5 + SMW + PageForms + ParserFunctions fully configured
- Database schema up-to-date and verified
- Wiki.js deployed and connected to PostgreSQL
- Django BI application stable and operational
- Apache 2.4 running on llamajail with all services operational

**Phase 3: Standardized PageForms Pattern & Working Data Systems (Completed 2026-02-01)**

- **Standardized PageForms Pattern Established:**
  - ✅ `default form=[Prefix]:` parameter for semantic grouping (forminput-level naming)
  - ✅ Removed `{{{info}}}` tag approach (form-level naming) - less flexible
  - ✅ Pattern supports future scalability with multiple data types
  - ✅ Complete documentation saved to Memory Bank (10/10 importance)

- **Item List System - Working Test Case:**
  - ✅ Item_List portal page with categorytree and form input (page_id: 352)
  - ✅ Form:Item - Standardized form definition (page_id: 346)
  - ✅ Template:Item - Display template (page_id: 347)
  - ✅ Category:Item - Category organization (page_id: 348)
  - ✅ Successfully tested: Create Item:Laptop entry via form
  - ✅ Verified categorytree listing works with cache refresh

- **Equipment Registry System - Production Ready:**
  - ✅ Equipment_Registry_Documentation portal page (page_id: 329)
  - ✅ Form:Equipment_Registry - Full equipment form with 8 fields (page_id: 319)
  - ✅ Template:Equipment - Equipment display template with SMW properties (page_id: 335)
  - ✅ Category:Equipment - Equipment category organization
  - ✅ Tested: Create Equipment:FRIDGE-01 entry via form
  - ✅ Uses standardized `default form=Equipment:` parameter

- **Access Control Model - Confirmed:**
  - ✅ Two-layer permission system documented
  - ✅ System Structure (Admin only): Templates, Forms, Portal Pages
  - ✅ Data Entry (Role-based): Staff create/edit own data, Manager oversee all, Inspector read-only
  - ✅ MediaWiki LocalSettings.php configuration documented
  - ✅ User group structure: data-entry-staff, manager, inspector, sysop
  - ✅ Complete implementation guide saved to Memory Bank (10/10 importance)

- **SSH & Database Access Improvements:**
  - ✅ Simplified SSH commands tested: `ssh 192.168.2.30`, `ssh 192.168.2.10`
  - ✅ Password-less psql access verified: `psql -U postgres -d mediawiki`
  - ✅ Both commands excluded from git/history (no credentials exposed)

### 🔄 In Progress

- **ACTIVE:** Testing Records Archive System with form submissions
- Implementing Dark Blue sections (4-11) as MediaWiki pages
- Additional business page entries
- User permissions and access control

### 📋 Planned Next Steps

**Phase 4 (Next):** Test & Deploy Dark Blue Sections
1. Create 8 Dark Blue section pages (Business Layout, Risk Management, Responsibility, Plan Monitoring, Training & Competency, Equipment & Facilities, Water Supply - Registered, Water Supply - Self-Supply)
2. Test Records Archive pages with real form submission data
3. Configure staff and manager access to archive pages
4. Monitor query performance with live data

**Phase 5:** Integration & Compliance (Final)
1. Update Food_Control_Records main page with Records_Archive link
2. Test end-to-end workflow (form entry → archive view)
3. Configure inspector access and review features
4. Build compliance reporting dashboards
5. Implement staff notification system

**Phase 5:** Integration & Compliance (Final)
1. Update Food_Control_Records main page with Record Management & Archive navigation
2. Test end-to-end workflow (form entry → archive view)
3. Configure inspector access and review features
4. Build compliance reporting dashboards
5. Implement staff notification system

**High Priority (Parallel Track):** Dark Blue Sections Implementation
1. Create 8 Dark Blue section pages (FCP:Setting_Up:Business_layout, Risk_management, Responsibility, Plan_monitoring, Training_competency, Equipment_facilities, Water_supply_registered, Water_supply_self_supply)
2. Create business logo/image upload capability
3. Build compliance reporting dashboards

**Standardized Pattern Ready For:**
- Temperature Registry (uses same form/template/portal pattern)
- Supplier Registry
- Staff Directory
- Training Records
- Any future data management system (reusable template)

---

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

**Database Location:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/memory-bank/context.db`
**Document Count:** 162+ documents
**Schema Version:** v2.1

### Key Documents by UUID

| UUID | Title | Importance |
|------|-------|-----------|
| `bfcb00aa-03eb-46b3-8710-8b9417b15c86` | **SOLVED: MediaWiki API / mw-crud Fully Working** — OATHAuth fix, sequence fix, all CRUD working | 10/10 |
| `bfcb00aa` (same) | Covers: mw-crud authentication, OATHAuth missing tables fix, revision sequence fix | 10/10 |
| `a71916ab-f6bd-4436-91d8-fbb5fd0bb686` | **MediaWiki Template Display Issue - RESOLVED** | 9/10 |
| `b92649ba-adb5-41bc-8f92-bd0cbcc0f9e6` | **MediaWiki CRUD Skill - Updated with Conflict Detection** | 8/10 |

### Key Documents (Priority Order)

**2026-02-19 - API & Breadcrumbs:**
- **SOLVED: MediaWiki API / mw-crud Fully Working** (`bfcb00aa`) — Root causes: missing OATHAuth tables + sequence sync. All CRUD operations confirmed working.

**2026-02-16 - Staff Training System:**
- **Staff Training System Phase 1** (9/10) - Full deployment, 21 pages (IDs 370-390)

**2026-02-01 - Phase 3 Completion:**
- **Standardized PageForms Pattern** (10/10) - Pattern for all data entry systems
- **FCP_DCC Access Control Model** (10/10) - Two-layer permission system
- **Working Business Details System** (10/10) - Reference pattern for form/template/portal

### Quick Searches
```
- "mw-crud" or "CRUD" - API skill usage and troubleshooting
- "OATHAuth" - Authentication fix procedures
- "sequence" - PostgreSQL sequence sync fix
- "breadcrumb" - Semantic Breadcrumb Links setup
- "dark blue" - FCP Section specifications
- "page forms" - MediaWiki extension guides
- "business details" - Schema specifications
- "staff training" - Training system docs
```

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

---

## Important Notes

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
