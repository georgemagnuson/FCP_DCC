# FCP_DCC Quick Reference

**Project:** Food Control Plan Compliance Documentation & Diary System
**Last Updated:** 2026-01-15
**Status:** Core infrastructure operational, MediaWiki templates production ready

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
**Status:** ✅ All servers accessible (tested 2026-01-15)
**Uptime:** 33+ days on all jails
**User:** `georgemagnuson`
**Port:** 22 (standard)

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

```bash
# Connect from local machine (if on network)
psql -U mediawiki -d mediawiki -h 192.168.2.30 -p 5432

# Connect from within postgresqljail
ssh -i ~/.ssh/id_rsa georgemagnuson@192.168.2.30
psql -U mediawiki -d mediawiki
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
psql -U postgres -h 192.168.2.30 -l

# List tables in mediawiki database
psql -U mediawiki -d mediawiki -h 192.168.2.30 -c "\dt"

# List SMW properties
psql -U mediawiki -d mediawiki -h 192.168.2.30 -c "SELECT * FROM smw_object_ids WHERE smw_iw = '' LIMIT 20;"
```

---

## Current Project Status

### ✅ Completed (as of 2026-01-15)

**MediaWiki Implementation:**
- Template:BusinessDetails - Production ready with conditional display
- ParserFunctions extension enabled and working
- Business entry form: FCP:Setting_Up:Business_details
- 2 business pages created (The Jitsu Ltd)
- Category cleanup completed

**Infrastructure:**
- PostgreSQL on postgresjail fully operational
- MediaWiki + Semantic MediaWiki + PageForms configured
- Wiki.js deployed and connected to PostgreSQL
- Django BI application stable and operational

### 🔄 In Progress

- Business details schema implementation (pages 7-10)
- Additional business page entries
- Daily report templates
- User permissions and access control

### 📋 Planned Next Steps

1. Add more FCP business pages
2. Create SMW query dashboards for business search/filtering
3. Implement form validation for business activities
4. Add business logo/image upload capability
5. Build compliance reporting dashboards
6. Configure daily report submission workflow
7. Set up inspector access and review features

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
**Document Count:** 79 documents
**Schema Version:** v2.1

### Quick Searches
```
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
- MediaWiki uses both file storage and database
- Semantic properties stored in `smw_*` tables
- Template cache requires manual purging after changes
- Color scheme supports accessibility standards
- OpenVPN tunnel connects JITSU to ASTEROID M for DB access

---

## Contact & Resources

**Project Owner:** George Magnuson
**Local Dev Path:** `/Users/georgemagnuson/Documents/GitHub/FCP_DCC/`
**Documentation:** CLAUDE.md in project root
**Memory Bank:** 79+ documents covering architecture, guides, and decisions
