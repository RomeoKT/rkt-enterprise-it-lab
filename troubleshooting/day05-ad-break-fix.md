# Day 05 — Active Directory Break/Fix

## Incident 1 — GPO Not Applied

### Symptom

The expected workstation GPO was not applied to W11-01.

### Root Cause

W11-01 was placed outside the `Laval\Computers` OU where the workstation GPOs were linked.

### Resolution

W11-01 was moved back to the `Laval\Computers` OU.

### Validation

The Group Policy configuration was refreshed and verified:

```cmd
gpupdate /force
gpresult /scope computer /r

The expected computer GPOs were applied again.

Incident 2 — Missing Group Membership
Symptom

Sarah Tremblay could not access the Finance resources as expected.

Root Cause

Sarah was not a member of the GG_FINANCE_USERS security group.

Resolution

Sarah was added back to the correct global security group:

Add-ADGroupMember -Identity "GG_FINANCE_USERS" -Members "sarah.tremblay"
Validation

Group membership was verified with:

Get-ADGroupMember "GG_FINANCE_USERS"

After signing out and signing back in, Sarah successfully accessed:

\\FS01\Finance
Incident 3 — Incorrect NTFS Permission
Symptom

A Finance user could access the Finance share but could not correctly modify files.

Root Cause

The DL_FINANCE_RW group did not have the required NTFS permissions on the Finance folder.

Resolution

Modify permissions were restored:

icacls "C:\Shares\Finance" /grant "CORP\DL_FINANCE_RW:(OI)(CI)(M)" /T
Validation

Permissions were verified with:

icacls "C:\Shares\Finance"

A Finance user successfully created, modified, and deleted a test file in the Finance share.

Incident 4 — Missing Drive Mapping
Symptom

The Finance F: drive did not appear for Sarah Tremblay.

Root Cause

The item-level targeting configuration in GPO-Map-Drives did not correctly target the GG_FINANCE_USERS security group.

Resolution

The Finance drive mapping was configured with:

Location: \\FS01\Finance
Drive Letter: F:
Security Group: CORP\GG_FINANCE_USERS
Validation

Group Policy was refreshed:

gpupdate /force
gpresult /r

The mapped drives were verified with:

net use

The Finance drive was successfully mapped:

F: -> \\FS01\Finance
Conclusion

These troubleshooting scenarios demonstrated how Active Directory OU placement, security group membership, NTFS permissions, and Group Policy Preferences can affect user and workstation access.

Each issue was intentionally reproduced, diagnosed, corrected, and validated.