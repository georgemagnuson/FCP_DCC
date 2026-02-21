# FCP_DCC User Access Guide

**Version:** 1.0
**Last Updated:** 2026-02-21
**Applies To:** MediaWiki Instance at 192.168.2.10
**Security Model:** Namespace-Based Access Control with Role-Based Permissions

---

## Table of Contents

1. [Overview](#overview)
2. [User Roles](#user-roles)
3. [What You Can Access](#what-you-can-access)
4. [How to Access the System](#how-to-access-the-system)
5. [Employee Guide](#employee-guide)
6. [Manager Guide](#manager-guide)
7. [Inspector Guide](#inspector-guide)
8. [Administrator Guide](#administrator-guide)
9. [Common Tasks](#common-tasks)
10. [Troubleshooting](#troubleshooting)

---

## Overview

The FCP_DCC system uses a **namespace-based security architecture** to protect sensitive information while allowing appropriate access based on your role. Different areas of the wiki are separated into namespaces, each with specific permissions.

### Key Concepts

- **Namespaces** - Separate areas of the wiki (like folders)
- **Roles** - Your job function determines what you can access
- **Read Access** - You can view content but not change it
- **Edit Access** - You can view and modify content

---

## User Roles

### 👷 Employee (data_recorder)
**Who:** Kitchen staff, service staff, general employees
**Purpose:** Record daily operational data and complete training
**Access Level:** Limited - operational data and own training only

### 👔 Manager (data_editor)
**Who:** Supervisors, shift managers, operations managers
**Purpose:** Oversee operations, manage staff, verify compliance
**Access Level:** Full - all operational, employee, and confidential data

### 🔍 Inspector (inspector)
**Who:** Food safety auditors, compliance inspectors
**Purpose:** Audit compliance, review records, verify procedures
**Access Level:** Read-only - can view but not modify records

### 🔧 Administrator (sysop)
**Who:** System administrators, IT staff
**Purpose:** Maintain the wiki system, create templates and forms
**Access Level:** Full - complete system access

---

## What You Can Access

### Access Matrix

| Namespace | Employee | Manager | Inspector | Admin |
|-----------|----------|---------|-----------|-------|
| **FCP_MAIN** (Food Control Plan) | 👁️ Read | 👁️ Read | 👁️ Read | ✏️ Full |
| **FCP_FORMS** (Form Templates) | 👁️ Read | ✏️ Edit | 👁️ Read | ✏️ Full |
| **JITSU_DATA** (Daily Operations) | ✏️ Edit | ✏️ Edit | 👁️ Read | ✏️ Full |
| **JITSU_EMPLOYEES** (HR Records) | ❌ Blocked | ✏️ Edit | ❌ Blocked | ✏️ Full |
| **JITSU_EMPLOYEES_TRAINING** (Training) | 👤 Own Only | ✏️ Edit | 👁️ Read | ✏️ Full |
| **JITSU_CONFIDENTIAL** (Business) | ❌ Blocked | ✏️ Edit | ❌ Blocked | ✏️ Full |
| **JITSU_REPORTS** (Summaries) | 👁️ Read | ✏️ Edit | 👁️ Read | ✏️ Full |

**Legend:**
- 👁️ Read = View only
- ✏️ Edit = View and modify
- 👤 Own Only = You can only see your own records
- ❌ Blocked = No access

---

## How to Access the System

### Initial Login

1. **Navigate to the wiki:**
   - Internal: `http://192.168.2.10/mediawiki/`
   - External: `https://192.168.1.18/mediawiki/`

2. **Log in:**
   - Click "Log In" on the landing page
   - Enter your username and password
   - Click "Log in"

3. **First login:**
   - If this is your first time, your manager or admin will have created your account
   - You may be asked to change your password

### Navigation

**Main Page:** After login, you'll see the Main Page with links to:
- Food Control Plan documentation
- Daily operation forms
- Training portals
- Reports (based on your role)

**Sidebar:** Quick links to common pages and your user tools

---

## Employee Guide

### What You Can Do

✅ **Read Food Control Plan documentation** (FCP_MAIN)
- View all FCP procedures and guidelines
- Reference cooking temperatures, cleaning procedures, etc.

✅ **Submit daily operational forms** (JITSU_DATA)
- Temperature logs
- Equipment checks
- Cleaning records
- Daily checklists

✅ **View and complete your training** (JITSU_EMPLOYEES_TRAINING)
- See training assignments
- Mark sections as read
- Request manager verification

✅ **View reports relevant to you** (JITSU_REPORTS)
- Your own training progress
- Your submitted forms

### What You Cannot Do

❌ **View other employees' HR records**
- Salary information, evaluations, disciplinary records are manager-only

❌ **View business confidential data**
- Financial reports, supplier contracts, business plans

❌ **View other employees' training records**
- You can only see your own training, not your colleagues'

❌ **Edit templates or forms**
- Only admins and managers can modify the forms you fill out

### Common Tasks

#### Submit a Temperature Log

1. Navigate to **Daily_Records** page
2. Click **"Temperature Monitoring Form"**
3. Fill in:
   - Equipment name
   - Temperature reading
   - Time
   - Your name (auto-filled)
4. Click **"Save page"**
5. Record appears in **Records_Archive**

#### Complete Training

1. Go to **JITSU_REPORTS:Employee_Training_Status**
2. View your assigned training sections
3. Click on a training assignment
4. Read the FCP section content
5. Click **"Mark as Read"** or use the completion form
6. Wait for manager verification

#### Check Your Training Progress

1. Navigate to **JITSU_REPORTS:Employee_Training_Status**
2. You'll see only your training records
3. Check completion status and verification status

---

## Manager Guide

### What You Can Do

✅ **Everything employees can do, plus:**

✅ **Manage employee HR records** (JITSU_EMPLOYEES)
- View employee profiles
- Add evaluations and performance notes
- Update employee information

✅ **Edit form templates** (FCP_FORMS)
- Modify forms to improve data collection
- Add new fields as needed

✅ **View all employee training records** (JITSU_EMPLOYEES_TRAINING)
- Monitor staff training progress
- Verify training completion
- Identify training gaps

✅ **Access business confidential data** (JITSU_CONFIDENTIAL)
- Financial reports
- Supplier contracts
- Business planning documents

✅ **Create and edit reports** (JITSU_REPORTS)
- Generate custom reports
- Analyze compliance trends
- Track team performance

### Common Tasks

#### Verify Employee Training

1. Go to **JITSU_REPORTS:Supervisor_Training_Verification**
2. View pending verifications
3. Click on an employee's training record
4. Review completion details
5. Click **"Verify Understanding"**
6. Add verification notes
7. Save changes

#### Create a New Employee Record

1. Navigate to **JITSU_EMPLOYEES** namespace
2. Click **"Create new employee page"**
3. Enter employee details using the Employee template:
   - Name
   - Position
   - Start date
   - Contact information
4. Save the page
5. Set up initial training assignments

#### Review Daily Operations

1. Go to **Records_Archive/Daily**
2. Review today's submitted forms
3. Check for:
   - Temperature compliance
   - Equipment issues
   - Incomplete records
4. Follow up on any problems

#### Generate a Report

1. Navigate to **JITSU_REPORTS** namespace
2. Use existing report templates or create custom queries
3. Filter by date range, employee, or form type
4. Export or print as needed

---

## Inspector Guide

### What You Can Do

✅ **Read-only access to operational records**
- View all FCP documentation
- Review submitted forms and records
- Check training completion status
- Audit compliance trends

### What You Cannot Do

❌ **Edit any content**
- You can view but not modify records
- This ensures audit integrity

❌ **View confidential HR or business data**
- Employee evaluations, salaries, business plans are manager-only

### Common Tasks

#### Conduct a Compliance Audit

1. Review **FCP_MAIN** documentation for current procedures
2. Check **JITSU_DATA** for recent operational records
3. Verify **JITSU_EMPLOYEES_TRAINING** completion rates
4. Review **Records_Archive** for compliance trends
5. Generate audit report (external to wiki)

#### Review Temperature Records

1. Go to **Records_Archive/Weekly** or **Monthly**
2. Filter by temperature logs
3. Check for:
   - Out-of-range readings
   - Corrective actions taken
   - Frequency of monitoring
4. Document findings

#### Verify Training Compliance

1. Navigate to **JITSU_REPORTS:Supervisor_Training_Verification**
2. Review training completion rates by section
3. Check verification timestamps
4. Identify gaps or overdue training

---

## Administrator Guide

### What You Can Do

✅ **Full system access**
- Create and edit all namespaces
- Modify templates, forms, and properties
- Manage user accounts and permissions
- Configure extensions and system settings

### System Administration

#### Create a New User Account

1. **Via Web Interface:**
   - Navigate to `Special:CreateAccount`
   - Enter username and password
   - Click "Create account"

2. **Assign to Group:**
   - Go to `Special:UserRights`
   - Enter the username
   - Select appropriate group:
     - `data_recorder` (Employee)
     - `data_editor` (Manager)
     - `inspector` (Inspector)
     - `sysop` (Admin)
   - Click "Update user groups"

#### Create a New Form Template

1. Navigate to **Template:** namespace
2. Create new template page
3. Use Semantic MediaWiki properties for data
4. Add Semantic ACL if needed:
   ```wiki
   [[Visible to::Group:data_editor]]
   [[Editable by::Group:data_editor]]
   ```
5. Create corresponding **Form:** page using PageForms syntax
6. Test with a dummy submission

#### Modify Namespace Permissions

1. SSH to server: `ssh 192.168.2.10`
2. Edit LocalSettings.php:
   ```bash
   sudo vim /usr/local/www/mediawiki/LocalSettings.php
   ```
3. Locate Lockdown configuration (lines 420-455)
4. Modify permissions arrays
5. Save and restart Apache:
   ```bash
   sudo service apache24 restart
   ```
6. Test access with different user roles

#### Backup and Maintenance

**Create Database Backup:**
```bash
pg_dump -h 192.168.2.30 -U postgres -d mediawiki > /tmp/backup_mediawiki_$(date +%Y%m%d_%H%M%S).sql
```

**Clear MediaWiki Cache:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && php maintenance/purgeList.php --db-touch && php maintenance/runJobs.php'
```

**Update Database Schema:**
```bash
ssh 192.168.2.10 'cd /usr/local/www/mediawiki && sudo -u www php maintenance/update.php --quick'
```

---

## Common Tasks

### Change Your Password

1. Click your username in top-right corner
2. Click "Preferences"
3. Go to "Change password" tab
4. Enter current password
5. Enter new password twice
6. Click "Change password"

### Search for a Page

1. Use the search box in the sidebar
2. Enter keywords or page title
3. Press Enter
4. Click on the page you want from results

### View Page History

1. Navigate to any page
2. Click "View history" tab
3. See all previous versions
4. Click on a timestamp to view that version
5. Click "Compare selected revisions" to see changes

### Upload a File (if permitted)

1. Go to `Special:Upload`
2. Click "Choose File"
3. Select file from your computer
4. Add description
5. Click "Upload file"

### Link to Another Page

Use double square brackets:
```wiki
[[Page Name]]
[[Page Name|Display Text]]
[[JITSU_EMPLOYEES:Carlos_Chef|Carlos's Profile]]
```

---

## Troubleshooting

### "Permission denied" Error

**Problem:** You see "You do not have permission to edit this page"

**Solutions:**
1. Check which namespace you're in - you may not have edit access
2. Verify you're logged in (check top-right corner)
3. Contact your manager or admin if you should have access

### Can't See a Page That Should Exist

**Problem:** Page appears blank or shows "Page does not exist"

**Solutions:**
1. Check the exact page name (case-sensitive)
2. You may not have read access to that namespace
3. The page might be in a different namespace
4. Use search to find the page

### Training Records Not Showing

**Problem:** Your training assignments aren't visible

**Solutions:**
1. Verify you're logged in as yourself
2. Check **JITSU_REPORTS:Employee_Training_Status** (not the main Employee_Training_Status)
3. Training may not be assigned yet - contact your manager
4. Clear your browser cache and refresh

### Form Submission Failed

**Problem:** Error when trying to save a form

**Solutions:**
1. Check all required fields are filled
2. Verify you're in the correct namespace
3. Make sure you have edit permissions
4. Try copying your data, refreshing, and resubmitting

### Can't Edit Template (Admins)

**Problem:** Sysop can't edit Template namespace

**Solutions:**
1. Verify you have the 'sysop' group assigned
2. Check LocalSettings.php has `$wgGroupPermissions['sysop']['sysop'] = true`
3. Restart Apache: `sudo service apache24 restart`
4. Clear browser cache

---

## Need Help?

### Contact Information

**System Administrator:** Georgemagnuson
**Location:** JITSU - The Wellington
**Documentation:** See `QUICK_REFERENCE.md` for technical details

### Additional Resources

- **MediaWiki Help:** https://www.mediawiki.org/wiki/Help:Contents
- **Semantic MediaWiki:** https://www.semantic-mediawiki.org/wiki/Help:User_manual
- **PageForms:** https://www.mediawiki.org/wiki/Extension:Page_Forms/Quick_start_guide

---

## Security Best Practices

### For All Users

1. **Never share your password** - Each user should have their own account
2. **Log out when finished** - Especially on shared computers
3. **Report suspicious activity** - Contact admin immediately
4. **Keep information confidential** - Don't share data outside the system

### For Managers

1. **Protect employee data** - HR records are confidential
2. **Review access logs** - Check `Special:RecentChanges` regularly
3. **Verify training properly** - Ensure understanding, not just completion
4. **Secure confidential documents** - Use appropriate Semantic ACL tags

### For Administrators

1. **Regular backups** - Daily database backups recommended
2. **Monitor user activity** - Check for unusual patterns
3. **Keep software updated** - Apply security patches promptly
4. **Secure LocalSettings.php** - Contains sensitive configuration
5. **Test permission changes** - Always verify with test accounts

---

## Appendix: Namespace Reference

### FCP_MAIN (ID: 3000)
**Purpose:** Official Food Control Plan documentation
**Content:** Regulatory procedures, compliance guidelines
**Editing:** Admins only (ensures regulatory accuracy)

### FCP_FORMS (ID: 3002)
**Purpose:** Form templates for data collection
**Content:** PageForms definitions for daily operations
**Editing:** Managers and admins

### JITSU_DATA (ID: 3004)
**Purpose:** Daily operational data (collaborative)
**Content:** Temperature logs, equipment checks, cleaning records
**Editing:** Employees, managers, admins

### JITSU_EMPLOYEES (ID: 3006)
**Purpose:** Employee HR records
**Content:** Profiles, evaluations, employment data
**Editing:** Managers and admins only (confidential)

### JITSU_EMPLOYEES_TRAINING (ID: 3008)
**Purpose:** Individual training records
**Content:** Training assignments, completions, verifications
**Editing:** Employees (own records), managers (all records), admins

### JITSU_CONFIDENTIAL (ID: 3010)
**Purpose:** Business-sensitive information
**Content:** Financial data, supplier contracts, business plans
**Editing:** Managers and admins only

### JITSU_REPORTS (ID: 3012)
**Purpose:** Summary reports and analytics
**Content:** Compliance dashboards, training summaries, trends
**Editing:** Managers and admins (employees can read)

---

**Document Version:** 1.0
**Last Reviewed:** 2026-02-21
**Next Review:** 2026-03-21 (monthly)
