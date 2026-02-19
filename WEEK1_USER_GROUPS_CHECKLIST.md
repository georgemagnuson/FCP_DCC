# Week 1: Create User Groups - Implementation Checklist

**Week:** 1 of 5  
**Task:** Create and assign user groups  
**Status:** ✅ LocalSettings.php configured, Ready for group assignment  
**Timeline:** 5-10 minutes to assign users (can do incrementally)

---

## Quick Start (60 seconds)

1. Go to: `http://192.168.2.10/mediawiki/Special:UserRights`
2. Search for a username
3. Check group box (data_recorder, data_editor, inspector, or sysop)
4. Click "Update user rights"
5. Done! Groups created automatically

---

## Checklist: Assign Each User

### Staff: Kitchen & Service

- [ ] **Chef/Kitchen Manager**
  - Group: `data_recorder`
  - Reason: Submits temperature logs and checklists
  - Can: Read all pages, create forms, edit own submissions

- [ ] **Server/Waitstaff**
  - Group: `data_recorder`
  - Reason: May report incidents or fill checklists
  - Can: Read pages, submit forms

### Management

- [ ] **Shift Manager**
  - Groups: ✓ `data_recorder` AND ✓ `data_editor`
  - Reason: Submits forms + approves and fixes data
  - Can: Submit forms + edit locked forms for corrections

- [ ] **General Manager/Owner**
  - Group: `sysop` (editor-in-chief)
  - Reason: System administration
  - Can: Do everything (manage templates, properties, forms)

### Compliance & Verification

- [ ] **Health Inspector**
  - Group: `inspector`
  - Reason: Reviews compliance documentation
  - Can: Read all pages, comment on talk pages (no editing)

- [ ] **Food Safety Auditor**
  - Group: `inspector`
  - Reason: Same as health inspector
  - Can: Read and comment only

---

## Step-by-Step for Each User

**Steps 1-4 (Repeat for each user):**

**Step 1:** Navigate to Special:UserRights
```
URL: http://192.168.2.10/mediawiki/Special:UserRights
Or: Special:SpecialPages → User rights
```

**Step 2:** Search for username
```
[Username search box]
Type: carlos_chef
Click: [Search]
```

**Step 3:** Check appropriate group(s)
```
For data_recorder:
  ☑ data_recorder
  
For manager (data_editor):
  ☑ data_recorder
  ☑ data_editor
  
For inspector:
  ☑ inspector
  
For owner:
  ☑ sysop
```

**Step 4:** Update rights
```
Click: [Update user rights]
Verify: "User rights have been updated"
```

---

## Verification Checklist

After assigning each user, verify:

- [ ] User appears in search results
- [ ] Group boxes show as checked (☑)
- [ ] "User rights have been updated" message appears
- [ ] Can logout/login as user to test permissions

---

## Testing Each Role (5 minutes per role)

After assigning users to groups, test permissions:

### Test data_recorder
```
1. Login as: data_recorder user
2. Navigate to: Any form page
3. Try to EDIT form
   Expected: ✅ Can edit
4. Try to DELETE page
   Expected: ❌ Cannot delete
```

### Test data_editor
```
1. Login as: data_editor user
2. Create and submit a form
3. Have someone "lock" the form (protection)
4. Try to EDIT locked form
   Expected: ✅ Can edit
5. Try to EDIT template
   Expected: ❌ Cannot edit
```

### Test inspector
```
1. Login as: inspector user
2. Try to EDIT form
   Expected: ❌ Cannot edit
3. Click Discussion tab
4. Try to add COMMENT
   Expected: ✅ Can comment
```

### Test sysop
```
1. Login as: sysop user
2. Navigate to: Template page
3. Try to EDIT template
   Expected: ✅ Can edit
4. Try to DELETE page
   Expected: ✅ Can delete
```

---

## Troubleshooting

**Problem: Groups not showing in checkboxes?**
- Solution: Reload page (Ctrl+F5)
- Or: Clear browser cache
- Or: Wait 1-2 minutes (cache sync)

**Problem: User still can't access after assignment?**
- Solution: Logout user and login again
- Solution: Clear MediaWiki cache:
  ```bash
  ssh 192.168.2.10
  cd /usr/local/www/mediawiki
  php maintenance/purgeList.php --db-touch
  ```

**Problem: data_recorder can edit locked forms (shouldn't)?**
- Check: User has `data_editor` group assigned
- Or: Edit user again and verify `data_editor` is checked
- Or: Verify LocalSettings.php has editprotected=true for data_editor

**Problem: Inspector can edit pages (shouldn't)?**
- Check: Inspector group only has `inspector` checked
- Not: data_recorder or data_editor
- Remove: Any other group assignments

---

## How to Create a Test User

**If you don't have test users yet:**

1. Go to: `http://192.168.2.10/mediawiki/Special:CreateAccount`
2. Fill in:
   - Username: `test_recorder` (or any name)
   - Password: (secure password)
   - Confirm password: (same)
3. Click: "Create account"
4. Then assign group via Special:UserRights (steps above)

**Suggested test users:**
- `carlos_chef` → data_recorder
- `maria_manager` → data_recorder + data_editor
- `george_inspector` → inspector
- `owner_admin` → sysop

---

## After Group Assignment

**Next steps:**

1. **Test Permissions** (Day 1)
   - Follow testing checklists above
   - Verify each role works correctly
   - Fix any permission issues

2. **Train Users** (Days 2-3)
   - Show each user their role
   - Explain what they can do
   - Practice with test forms

3. **Go Live** (Week 2)
   - Assign all staff to groups
   - Monitor for issues
   - Support users with questions

---

## Reference Documents

- **LOCALSETTINGS_ROLE_CONFIGURATION.md**
  - Permission definitions (why each role has its permissions)
  - Namespace protection rules
  - Complete configuration details

- **USER_GROUPS_SETUP_GUIDE.md**
  - Detailed setup instructions
  - Three methods (web, SQL, API)
  - Troubleshooting guide

- **Memory Bank: 84eec866-06f0-4442-944a-d4bdf93daac3**
  - Complete implementation plan
  - Workflow diagrams
  - All related information

---

## Timeline

**Week 1 (Now):** Create user groups
- Assign test users
- Verify permissions work
- Document any issues

**Week 2:** Test workflow
- Have data_recorder submit form
- Have data_editor approve/lock
- Have inspector review/comment

**Week 3:** Create semantic properties
- Create Has_approval_status property
- Create Has_locked_status property
- And 3 others

**Week 4:** Configure templates
- Add status fields to forms
- Add lock/unlock buttons
- Test workflow end-to-end

**Week 5:** Production
- Assign all staff to groups
- Full testing with real data
- Go live!

---

## Important Notes

✓ Groups are created AUTOMATICALLY when you assign first user
✓ No groups need to be pre-created
✓ Just assign users and groups appear
✓ Multiple roles per user work fine (manager = recorder + editor)
✓ Changes take effect immediately (no restart needed)
✓ Easy to test and fix if needed

---

## Questions?

See: USER_GROUPS_SETUP_GUIDE.md → "Troubleshooting" section

Quick questions answered:
- Groups not showing: Clear cache
- Permissions not working: Verify user assigned + clear cache
- Need bulk assignment: Use SQL method in guide
- Need automation: Use mw-crud API method in guide

---

**Ready to assign users?**

→ Start here: http://192.168.2.10/mediawiki/Special:UserRights
→ That's it! Groups will be created as you assign users.

