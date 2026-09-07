# Day 07 — Windows Endpoint Break/Fix

## Scenario

A Windows user was unable to create a file inside a restricted folder.

The purpose of this test was to troubleshoot a Windows permission issue using Sysinternals Process Monitor.

## Affected System

- Workstation: W11-01
- Domain: corp.rktlab.test
- User: CORP\sarah.tremblay
- Folder: C:\RKT-Day07\Restricted
- Test file: C:\RKT-Day07\Restricted\sarah-test.txt

## Symptoms

Sarah attempted to create a file inside:

```text
C:\RKT-Day07\Restricted

Windows returned an access denied error.

The user could read the folder but could not create or modify files inside it.

## Initial Permissions

Sarah only had Read and Execute permissions:

```
CORP\sarah.tremblay = RX
```

The permissions were verified with:

```
icacls "C:\RKT-Day07\Restricted"
```

## Troubleshooting

Process Monitor was started and filtered with:

```
Result
is
ACCESS DENIED
Include
```

A second filter was added:

```
Path
begins with
C:\RKT-Day07\Restricted
Include
```

The problem was reproduced with:

```
New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt"
```

Process Monitor showed:

```
Result: ACCESS DENIED
Path: C:\RKT-Day07\Restricted\sarah-test.txt
```

## Root Cause

Sarah only had Read and Execute NTFS permissions.

She did not have Modify permission, so Windows blocked the file creation operation.

## Resolution

Modify permission was granted to Sarah:

```
icacls "C:\RKT-Day07\Restricted" /grant:r "CORP\sarah.tremblay:(OI)(CI)(M)"
```

The permissions were verified again:

```
icacls "C:\RKT-Day07\Restricted"
```

Sarah now had:

```
M
```

`M` means Modify.

## Validation

The file creation test was repeated:

```
New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt" -Force
```

The file was successfully created.

Verification:

```
Get-Item "C:\RKT-Day07\Restricted\sarah-test.txt"
```

The issue was resolved.

## What I Learned

The troubleshooting process was:

```
Symptom
↓
Reproduce the problem
↓
Capture evidence with Process Monitor
↓
Identify ACCESS DENIED
↓
Check NTFS permissions
↓
Identify root cause
↓
Correct permissions
↓
Validate the fix
```

