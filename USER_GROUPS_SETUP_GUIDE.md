# FCP_DCC User Groups Setup Guide

## Method 1: Via Web Interface (Recommended - Easiest)

### Step 1: Navigate to User Rights Management
1. Go to: `http://192.168.2.10/mediawiki/Special:UserRights`
2. Or click: Special:SpecialPages → User rights → UserRights

### Step 2: Create Test User (Optional, for testing groups)
If you don't have test users yet:
1. Go to: `http://192.168.2.10/mediawiki/Special:CreateAccount`
2. Create a test account: `TestRecorder` with password
3. Repeat for `TestEditor` and `TestInspector`

### Step 3: Assign Users to Groups

**For data_recorder group:**
1. In Special:UserRights search box, type: `TestRecorder` (or actual user)
2. In the "User groups" section, CHECK the box for: `data_recorder`
3. Click the "Update user rights" button
4. Verify: "User rights have been updated"

**For data_editor group:**
1. Type: `TestEditor` (or actual manager name)
2. CHECK BOTH boxes: `data_recorder` AND `data_editor`
   (Managers need both roles - they can submit AND edit locked forms)
3. Click "Update user rights"

**For inspector group:**
1. Type: `TestInspector` (or actual inspector name)
2. CHECK the box for: `inspector`
3. Click "Update user rights"

**For editor-in-chief (Owner):**
1. Type: Owner username
2. CHECK the box for: `sysop`
3. Click "Update user rights"

---

## Method 2: Via SQL (Direct Database - Advanced)

If you prefer direct database insertion:

```sql
-- Connect to MediaWiki database
psql -h 192.168.2.30 -U postgres -d mediawiki

-- Assign user to data_recorder group
INSERT INTO mediawiki.user_groups (ug_user, ug_group)
SELECT user_id, 'data_recorder'
FROM mediawiki.mwuser
WHERE user_name = 'Carlos'  -- Replace with actual username
AND NOT EXISTS (
  SELECT 1 FROM mediawiki.user_groups 
  WHERE ug_user = user_id AND ug_group = 'data_recorder'
);

-- Assign user to data_editor group
INSERT INTO mediawiki.user_groups (ug_user, ug_group)
SELECT user_id, 'data_editor'
FROM mediawiki.mwuser
WHERE user_name = 'Maria'  -- Replace with actual username
AND NOT EXISTS (
  SELECT 1 FROM mediawiki.user_groups 
  WHERE ug_user = user_id AND ug_group = 'data_editor'
);

-- Assign user to inspector group
INSERT INTO mediawiki.user_groups (ug_user, ug_group)
SELECT user_id, 'inspector'
FROM mediawiki.mwuser
WHERE user_name = 'George'  -- Replace with actual username
AND NOT EXISTS (
  SELECT 1 FROM mediawiki.user_groups 
  WHERE ug_user = user_id AND ug_group = 'inspector'
);

-- Verify assignments
SELECT 
    mu.user_name,
    GROUP_CONCAT(ug_group) as groups
FROM mediawiki.mwuser mu
LEFT JOIN mediawiki.user_groups ug ON mu.user_id = ug.ug_user
WHERE mu.user_id > 0
GROUP BY mu.user_name
ORDER BY mu.user_name;
```

---

## Method 3: Via mw-crud API

Using the mw-crud API (if implemented for user management):

```bash
# Not typically used for user groups, but possible with extensions
~/.claude/skills/mediawiki-crud/mw-crud assign-group \
  --user "CarlosChef" \
  --group "data_recorder" \
  --url "$MEDIAWIKI_API_URL" \
  --username "$MEDIAWIKI_USERNAME" \
  --password "$MEDIAWIKI_PASSWORD"
```

---

## Step-by-Step Example: Create All User Groups

### Scenario: Set up test users with their roles

**1. Create Test Users** (Special:CreateAccount)
```
Username: carlos_chef       Password: TestPass123
Username: maria_manager     Password: TestPass123
Username: george_inspector  Password: TestPass123
Username: owner_admin       Password: TestPass123
```

**2. Assign Groups** (Special:UserRights)

Carlos (Chef) → data_recorder
```
Search: carlos_chef
✓ data_recorder
[Update user rights]
```

Maria (Manager) → data_recorder + data_editor
```
Search: maria_manager
✓ data_recorder
✓ data_editor
[Update user rights]
```

George (Inspector) → inspector
```
Search: george_inspector
✓ inspector
[Update user rights]
```

Owner → sysop (editor-in-chief)
```
Search: [owner username]
✓ sysop
[Update user rights]
```

**3. Verify** (Special:UserRights)
```
Search: carlos_chef
Result: Groups: data_recorder ✓

Search: maria_manager
Result: Groups: data_recorder, data_editor ✓

Search: george_inspector
Result: Groups: inspector ✓

Search: [owner]
Result: Groups: sysop ✓
```

---

## Testing Groups After Creation

### Test 1: data_recorder (Carlos)
1. Login as: carlos_chef
2. Navigate to any form page (e.g., Training form)
3. Try to edit → Should work ✅
4. Create a form → Should work ✅
5. Try to delete a page → Should FAIL ❌

### Test 2: data_editor (Maria)
1. Login as: maria_manager
2. Create and submit a form
3. Have another user lock it
4. Try to edit locked form → Should work ✅ (KEY TEST)
5. Try to edit template → Should FAIL ❌

### Test 3: inspector (George)
1. Login as: george_inspector
2. View a form page → Should work ✅
3. Try to edit form → Should FAIL ❌
4. Click "Discussion" tab → Should work ✅
5. Add comment → Should work ✅

### Test 4: sysop (Owner)
1. Login as: owner account
2. Edit template → Should work ✅
3. Edit form → Should work ✅
4. Do everything → Should work ✅

---

## Troubleshooting

**Groups not appearing in Special:UserRights dropdown?**
- Log out and log back in
- Clear browser cache
- Clear MediaWiki cache: `php maintenance/purgeList.php --db-touch`

**User still can't see/use group?**
- Verify group was saved: Special:UserRights → search user → check groups listed
- Clear MediaWiki cache again
- Restart Apache: `sudo service apache24 restart`

**Can edit locked forms but shouldn't be able to?**
- User doesn't have data_editor group assigned
- Or data_editor group doesn't have editprotected permission
- Check LocalSettings.php has: `$wgGroupPermissions['data_editor']['editprotected'] = true;`

---

## What Gets Created

After assigning users to groups:

**In Database (mediawiki.user_groups table):**
```
ug_user  | ug_group
─────────┼────────────────
1        | sysop
2        | data_recorder
3        | data_recorder
3        | data_editor       (user 3 in both groups)
4        | inspector
```

**In MediaWiki Interface (Special:UserRights):**
- Each user shows their group assignments
- Users can be in multiple groups
- Groups inherit permissions from LocalSettings.php

---

## Important Notes

✓ User groups are created IMPLICITLY when first user is assigned
✓ Multiple roles per user is supported (e.g., manager = recorder + editor)
✓ Permissions come from LocalSettings.php, not the groups themselves
✓ Changes take effect immediately (no restart needed after group assignment)
✓ Use Special:UserRights for manual assignment (easiest)
✓ Use SQL for bulk assignments

---

## Next Steps After Groups Created

1. **Assign actual staff** to groups in Special:UserRights
2. **Test each role** with sample forms
3. **Train users** on their permissions and workflows
4. **Create semantic properties** (Week 3 of implementation plan)
5. **Configure form templates** with status fields (Week 4)

