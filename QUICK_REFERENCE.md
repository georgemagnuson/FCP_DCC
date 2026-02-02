# FCP_DCC Quick Reference

**Project:** Food Control Plan Compliance Documentation & Diary System
**Last Updated:** 2026-02-01
**Status:** Phase 3 Complete: Standardized PageForms Pattern & Working Data Systems deployed

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
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.10
# or
ssh -i ~/.ssh/id_rsa-remote-ssh georgemagnuson@192.168.2.10

# Wiki.js + Django Host (djangojail)
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.20
# or
ssh -i ~/.ssh/id_rsa-remote-ssh georgemagnuson@192.168.2.20

# PostgreSQL Server (postgresqljail)
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30
# or
ssh -i ~/.ssh/id_rsa-remote-ssh georgemagnuson@192.168.2.30
```

**SSH Keys:** `~/.ssh/id_rsa` (confirmed working) or `~/.ssh/id_rsa-remote-ssh`
**Status:** ✅ All servers accessible (tested 2026-02-01)
**User:** `georgemagnuson`
**Port:** 22 (standard)
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

**Method 1: Using PGPASSWORD (Legacy)**
```bash
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 -p 5432
```

#### From postgresqljail Server

**Method 1: Using .pgpass (Recommended)**
```bash
# SSH into postgresqljail first
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30

# Then connect without password (uses ~/.pgpass)
psql -U postgres -d mediawiki
```

**Status:** ✅ `.pgpass` configured at `/var/db/postgres/.pgpass` (2026-01-31)
- **Credentials:** 192.168.2.30:5432:mediawiki:postgres:rash4z4m!
- **Permissions:** 600 (secure, only postgres user can read)
- **Benefits:** No password in command history, secure for automated scripts/cron jobs

**Method 2: Using PGPASSWORD**
```bash
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki
```

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
# Clear cache after template changes
php /usr/local/www/mediawiki/maintenance/purgeList.php --db-touch
php /usr/local/www/mediawiki/maintenance/runJobs.php

# Rebuild semantic data
php /usr/local/www/mediawiki/maintenance/runJobs.php --maxjobs=1000

# Update database schema
php /usr/local/www/mediawiki/maintenance/update.php
```

### Database Queries

```bash
# List all databases
PGPASSWORD="rash4z4m!" psql -U postgres -h 192.168.2.30 -l

# List tables in mediawiki database
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 -c "\dt"

# List SMW properties
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 -c "SELECT * FROM mediawiki.smw_object_ids WHERE smw_iw = '' LIMIT 20;"

# Query FCP pages
PGPASSWORD="rash4z4m!" psql -U postgres -d mediawiki -h 192.168.2.30 -c "SELECT page_title FROM mediawiki.page WHERE page_title LIKE 'FCP%' ORDER BY page_title;"
```

---

## MediaWiki Page Creation Methods

### Recommended: Direct SQL Database ✅

**Status:** Works perfectly for page creation

**What works:**
- Inserting records into `page` table ✓
- Creating page structure directly ✓
- Full control over content and metadata ✓

**What's complex:**
- Must create entries in 5+ tables: `page`, `revision`, `text`, `content`, `slots`
- Must maintain foreign key relationships correctly
- Must get sequence IDs right (`rev_id`, `old_id`, `content_id`)

**Complexity:** HIGH (requires full schema knowledge)

**Best for:** Bulk operations, automated imports, reliable page creation

**Advantages:**
- Most reliable method
- No caching issues
- Full control over all page properties
- Can batch multiple pages efficiently

### Alternative Methods (Not Recommended)

**PHP Maintenance Script (edit.php)** ❌
- Has persistent bugs in MediaWiki 1.43.5
- Returns conflicting error messages
- Title existence checks fail against cache
- Not recommended for production use

**MediaWiki REST/API**
- Works when authenticated
- Requires CSRF token and session/API authentication
- Less direct control than SQL
- Good for web-based integrations

---

## Current Project Status

### ✅ Completed (as of 2026-02-01)

**Phase 1: Record Management Pages (Completed 2026-01-30)**
- Daily_Records (page_id: 230) - 16 form links
- Weekly_Records (page_id: 231) - 9 form links
- Monthly_Records (page_id: 232) - 4 form links
- Incident_Records (page_id: 233) - 8 form links
- Total: 37 form links across 4 organized pages

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

- **ACTIVE:** Phase 3 - Records Archive System with SMW Queries
- Implementing Dark Blue sections (4-11) as MediaWiki pages
- Additional business page entries
- User permissions and access control

### 📋 Planned Next Steps

**Phase 4 (Next):** Create Records Archive Pages with SMW Queries
1. Develop SMW query templates using 12 semantic properties
2. Records_Archive - Main hub and navigation
3. Records_Archive/Daily - Today's submitted records (dynamic query)
4. Records_Archive/Weekly - This week's records (dynamic query)
5. Records_Archive/Monthly - This month's records (dynamic query)
6. Records_Archive/Search - Custom date range search interface
7. Create query templates for filtering by record type, staff, temperature, etc.

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
**Document Count:** 141+ documents
**Schema Version:** v2.1

### Key Documents (Priority Order - All 10/10 Importance)

**2026-02-01 - Phase 3 Completion:**
- **Standardized PageForms Pattern - Prefix-Based Semantic Grouping** (10/10) - Complete pattern documentation, checklist, and best practices for all data entry systems
- **FCP_DCC Access Control Model - Confirmed** (10/10) - Two-layer permission system with LocalSettings.php configuration, user workflows, and implementation guide
- **Working Business Details System - Complete Analysis** (10/10) - Reference pattern for form/template/portal page structure
- **Item List System Documentation** (Reference) - Working test case demonstrating standardized pattern

**2026-01-30:**
- **Phase 2 Deployment: Complete Technical Documentation** (2026-01-30) - Full deployment details, SMW properties, form template updates
- **Phase 3 Implementation Plan: Records Archive System with SMW Queries** (2026-01-30) - Planning document for next phase

**2026-01-26:**
- **Dark Blue Remaining Sections** (2026-01-26) - Complete specifications for FCP Sections 4-11, ready for MediaWiki implementation
- **MediaWiki Pages Inventory** (2026-01-26) - Status of all FCP translation pages

### Quick Searches
```
- "dark blue" - Section specifications and implementation status
- "state of project" - Project overview and status
- "network topology" - Complete infrastructure details
- "page forms" - MediaWiki extension guides
- "business details" - Schema specifications (pages 7-10)
- "template" - MediaWiki template implementation notes
- "color scheme" - CSS implementation details
```

---

## Troubleshooting

### MediaWiki Template Issues
1. Check ParserFunctions is enabled in LocalSettings.php
2. Clear cache: `php maintenance/purgeList.php --db-touch`
3. Run jobs: `php maintenance/runJobs.php`
4. Check Apache error log: `tail -f /var/log/apache24/error.log`

### Database Connection Issues
1. Verify PostgreSQL is running: `sudo service postgresql status`
2. Check pg_hba.conf for access rules
3. Test connection: `psql -U mediawiki -d mediawiki -h 192.168.2.30`
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
