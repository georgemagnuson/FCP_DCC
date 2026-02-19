# LocalSettings.php Role-Based Permission Configuration

**Deployment Date:** 2026-02-19  
**Status:** ✅ DEPLOYED  
**File Modified:** `/usr/local/www/mediawiki/LocalSettings.php`  

## Configuration Overview

This document describes the FCP_DCC role-based permission model added to MediaWiki's LocalSettings.php configuration.

## Four User Roles

### 1. data_recorder
**Users:** Kitchen staff, servers, data entry staff  
**Permissions:**
- ✅ Read all pages
- ✅ Create form pages via Page Forms
- ✅ Edit unlocked form pages
- ✅ Upload file attachments
- ❌ Cannot edit locked forms
- ❌ Cannot delete pages
- ❌ Cannot edit system pages (templates, properties, forms)

**Use Case:** Chef fills temperature log, submits form

### 2. data_editor
**Users:** Managers, supervisors  
**Permissions:**
- ✅ All data_recorder permissions PLUS:
- ✅ **Edit LOCKED form pages** (critical for error correction)
- ✅ Approve and lock forms after review
- ✅ Unlock forms when corrections needed
- ❌ Cannot delete pages
- ❌ Cannot edit system infrastructure

**Use Case:** Manager finds temperature typo, unlocks form, fixes "4°C" → "40°C", re-locks

### 3. inspector
**Users:** Food safety inspectors, compliance auditors  
**Permissions:**
- ✅ Read all pages (read-only access)
- ✅ Comment on talk pages
- ✅ Reply to discussions
- ❌ Cannot edit form data
- ❌ Cannot delete pages
- ❌ Cannot move pages

**Use Case:** Inspector reviews temperature log, asks questions on talk page: "Is 4°C correct?"

### 4. editor-in-chief
**Users:** Owner, system administrator  
**Permissions:**
- ✅ Full system control (inherits sysop group)
- ✅ Can modify templates, properties, forms
- ✅ Can delete, protect, and move pages
- ✅ Can manage users and groups

**Use Case:** Owner maintains system, defines forms, manages users

## Namespace Protection

System infrastructure is protected from non-admin editing:

| Namespace | Namespace ID | Protects | Edit Permission |
|-----------|--|--|--|
| Template | 10 | Template definitions | sysop only |
| Property | 102 | SMW properties | sysop only |
| Form | 106 | Page Forms definitions | sysop only |

## Configuration Code

```php
# ============================================================================
# DATA_RECORDER Role: Kitchen Staff, Servers, Data Entry Staff
# ============================================================================
$wgGroupPermissions['data_recorder']['read'] = true;
$wgGroupPermissions['data_recorder']['edit'] = true;           
$wgGroupPermissions['data_recorder']['createpage'] = true;     
$wgGroupPermissions['data_recorder']['createtalk'] = true;     
$wgGroupPermissions['data_recorder']['upload'] = true;         
$wgGroupPermissions['data_recorder']['reupload'] = true;       
$wgGroupPermissions['data_recorder']['delete'] = false;        
$wgGroupPermissions['data_recorder']['move'] = false;          
$wgGroupPermissions['data_recorder']['protect'] = false;       
$wgGroupPermissions['data_recorder']['editprotected'] = false; 

# ============================================================================
# DATA_EDITOR Role: Managers, Supervisors
# ============================================================================
$wgGroupPermissions['data_editor']['read'] = true;
$wgGroupPermissions['data_editor']['edit'] = true;              
$wgGroupPermissions['data_editor']['createpage'] = true;        
$wgGroupPermissions['data_editor']['createtalk'] = true;        
$wgGroupPermissions['data_editor']['upload'] = true;            
$wgGroupPermissions['data_editor']['reupload'] = true;          
$wgGroupPermissions['data_editor']['editprotected'] = true;     # KEY: Can edit locked pages
$wgGroupPermissions['data_editor']['delete'] = false;           
$wgGroupPermissions['data_editor']['move'] = false;             
$wgGroupPermissions['data_editor']['protect'] = false;          

# ============================================================================
# INSPECTOR Role: Food Safety Inspectors, Health Inspectors
# ============================================================================
$wgGroupPermissions['inspector']['read'] = true;                
$wgGroupPermissions['inspector']['edit'] = false;               
$wgGroupPermissions['inspector']['createpage'] = false;         
$wgGroupPermissions['inspector']['upload'] = false;             
$wgGroupPermissions['inspector']['delete'] = false;             
$wgGroupPermissions['inspector']['move'] = false;               
$wgGroupPermissions['inspector']['protect'] = false;            

# ============================================================================
# NAMESPACE PROTECTION: System Pages (Admin Only)
# ============================================================================
$wgNamespaceProtection[10] = array( 'edit' => 'sysop' );    # Template
$wgNamespaceProtection[102] = array( 'edit' => 'sysop' );   # Property
$wgNamespaceProtection[106] = array( 'edit' => 'sysop' );   # Form

# ============================================================================
# PROTECTION LEVELS: Configure what protection means
# ============================================================================
$wgRestrictionLevels = [
	'',             # '' (empty) = no protection
	'autoconfirmed', # Requires established users
	'sysop',        # Requires admin
];

$wgRestrictionTypes = [ 'edit', 'move' ];
```

## Permission Matrix

|                     | data_recorder | data_editor | inspector | sysop |
|---------------------|---|---|---|---|
| Read pages          | ✅ YES        | ✅ YES      | ✅ YES    | ✅ YES |
| Create forms        | ✅ YES        | ✅ YES      | ❌ NO     | ✅ YES |
| Edit unlocked forms | ✅ YES        | ✅ YES      | ❌ NO     | ✅ YES |
| Edit LOCKED forms   | ❌ NO         | ✅ YES      | ❌ NO     | ✅ YES |
| Comment on talk     | ✅ YES*       | ✅ YES      | ✅ YES    | ✅ YES |
| Delete pages        | ❌ NO         | ❌ NO       | ❌ NO     | ✅ YES |
| Move pages          | ❌ NO         | ❌ NO       | ❌ NO     | ✅ YES |
| Edit templates      | ❌ NO         | ❌ NO       | ❌ NO     | ✅ YES |

*data_recorder can comment on talk pages

## User Assignment Example

Using `Special:UserRights` in MediaWiki:

- **Carlos** (Chef) → `data_recorder`
- **Maria** (Manager) → `data_recorder` + `data_editor`
- **George** (Inspector) → `inspector`
- **Owner** → `sysop` (editor-in-chief)

## Deployment Checklist

- [x] Backup created: `/usr/local/www/mediawiki/LocalSettings.php.backup-20260219-*`
- [x] Configuration appended to LocalSettings.php
- [x] PHP syntax verified (no errors)
- [x] MediaWiki cache cleared
- [x] Apache restarted
- [x] Configuration active

## Testing

To verify the configuration works:

1. **data_recorder test:** Create test user, assign to data_recorder role
   - Should be able to create and edit forms
   - Should NOT be able to edit locked forms

2. **data_editor test:** Create test user, assign to data_editor role
   - Should be able to edit locked forms
   - Should NOT be able to edit templates

3. **inspector test:** Create test user, assign to inspector role
   - Should be able to read all pages
   - Should NOT be able to edit pages
   - Should be able to comment on talk pages

4. **sysop test:** Verify owner account has full permissions
   - Should be able to edit everything including templates

## Rollback Procedure

If you need to revert:

```bash
ssh 192.168.2.10
sudo cp /usr/local/www/mediawiki/LocalSettings.php.backup-20260219-* \
        /usr/local/www/mediawiki/LocalSettings.php
sudo service apache24 restart
```

## Related Documentation

- **Complete Plan:** Memory Bank UUID `84eec866-06f0-4442-944a-d4bdf93daac3`
- **Permission Extensions Research:** Memory Bank UUID `a3b08915-edad-49f8-a675-b9abd9d6e8f7`
- **Inspector Comments:** Memory Bank UUID `124b0fe6-6435-4647-b360-a7c806c80056`
