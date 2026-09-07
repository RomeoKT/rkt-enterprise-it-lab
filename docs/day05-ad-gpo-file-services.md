# Day 05 — Active Directory, GPO and File Services

## Objective
Extend the RKT Enterprise IT Lab with a dedicated file server, structured Active Directory groups, AGDLP permissions, Group Policy and Windows LAPS.

## FS01
- Hostname: FS01
- IP Address: 10.10.20.20
- Default Gateway: 10.10.20.1
- DNS Server: 10.10.20.10
- Domain: corp.rktlab.test

## Employees
15 employees were created across five departments:
- Finance
- HR
- IT
- Sales
- Operations

## AGDLP Permission Model
The permission structure follows:
Account → Global Group → Domain Local Group → Permission

Example:
Sarah Tremblay → GG_FINANCE_USERS → DL_FINANCE_RW → \\FS01\Finance

![AGDLP Permission Model](../diagrams/ad-permission-model.png)

## File Server
FS01 provides the following SMB shares:
- \\FS01\Finance
- \\FS01\HR
- \\FS01\IT
- \\FS01\Public

## Share vs NTFS Permissions
Share permissions control access to resources over SMB.
NTFS permissions control access to files and folders on the Windows file system.
AGDLP groups were used instead of assigning folder permissions directly to individual users.

## Group Policy
The following GPOs were created:
- GPO-Workstations-Security
- GPO-Map-Drives
- GPO-Screen-Lock
- GPO-Account-Lockout
- GPO-Windows-Firewall

Group Policy was validated using:
gpupdate /force
gpresult /r
gpresult /h C:\gpresult.html


## Drive Mapping
Finance users receive:
F: → \\FS01\Finance

Public resources are available through:
\\FS01\Public

Drive mapping was managed using Group Policy Preferences and security-group targeting.

## Windows LAPS
Windows LAPS was configured for W11-01.
The purpose of LAPS is to avoid using the same local administrator password across multiple workstations.
Each managed workstation can use a unique rotating local administrator password that is securely stored in Active Directory and retrieved only by authorized administrators.
No LAPS password is stored in this repository.

## Break/Fix
Four troubleshooting scenarios were performed:
1. Workstation placed in the wrong OU.
2. User removed from the correct security group.
3. Incorrect NTFS permissions.
4. Missing mapped drive caused by incorrect GPO targeting.

See: troubleshooting/day05-ad-break-fix.md

## Validation
- FS01 successfully joined corp.rktlab.test
- SMB shares validated
- AGDLP permissions validated
- Department access isolation validated
- Group Policy processing validated
- Drive mapping validated
- Windows LAPS validated
- Four troubleshooting scenarios completed

## What I Learned
I learned how Active Directory organizational units and security groups serve different purposes, how AGDLP simplifies access management, how Share and NTFS permissions interact, how Group Policy centrally manages users and workstations, and how Windows LAPS improves local administrator credential security.

