## `docs/day07-windows-endpoint-sysinternals.md`

```markdown

# Day 07 — Windows Endpoint, Sysinternals and ITSM

## Objective

The objective of Day 07 was to practice Windows endpoint troubleshooting, use Microsoft Sysinternals tools, and document support incidents using an ITSM workflow.

## Environment

- Workstation: W11-01

- Domain: corp.rktlab.test

- Domain Controller: DC01

- File Server: FS01

- Firewall: pfSense

- Service Desk: Jira Service Management

- Sysinternals location: C:\Tools\Sysinternals

# Windows Endpoint Tools

The following Windows tools were reviewed:

- Task Manager

- Services

- Device Manager

- Event Viewer

- Disk Management

- Resource Monitor

- Windows Update

- Windows Defender

- Windows Firewall

- User profiles

- RDP

- Printers

- Network drives

- Wi-Fi

- Teams

- OneDrive

- Audio

- Webcam

- Dock

- Monitor

## Task Manager

Used to inspect:

- running processes

- CPU usage

- memory usage

- disk activity

- network activity

Command:

```powershell

taskmgr

Services

Windows services were reviewed using:

services.msc

PowerShell example:

Get-Service Spooler

Important service states:

Running

Stopped

Important startup types:

Automatic

Manual

Disabled

Device Manager

Used to inspect:

network adapters

audio devices

webcams

display adapters

printers

drivers

hardware errors

Command:

devmgmt.msc

Event Viewer

Used to inspect Windows logs.

Command:

eventvwr.msc

Important logs:

Application

Security

System

PowerShell example:

Get-WinEvent -LogName System -MaxEvents 20 |

Select-Object TimeCreated,Id,LevelDisplayName,ProviderName

Disk Management

Used to review:

disks

partitions

volumes

drive letters

filesystems

unallocated space

Command:

diskmgmt.msc

Resource Monitor

Used for detailed monitoring of:

CPU

Memory

Disk

Network

Command:

resmon

Windows Update

Reviewed for:

missing updates

failed updates

update history

pending restarts

Windows version

Windows Defender

Reviewed for:

real-time protection

protection history

security intelligence updates

detected threats

Windows Firewall

Opened with:

wf.msc

Important concepts:

Inbound traffic

Outbound traffic

Domain profile

Private profile

Public profile

User Profiles

The difference between an Active Directory account and a local Windows profile was reviewed.

Example account:

CORP\sarah.tremblay

Example local profile:

C:\Users\sarah.tremblay

Commands:

whoami

Get-CimInstance Win32_UserProfile |

Select-Object LocalPath,Loaded,Special

RDP

Remote Desktop Protocol uses TCP port 3389.

Example test:

Test-NetConnection <TARGET> -Port 3389

Printers

Printer troubleshooting included:

correct printer

print queue

Print Spooler

driver

network connectivity

Example:

Get-Service Spooler

Network Drives

Mapped drives were reviewed using:

net use

Example:

\\FS01\Finance

Test:

Test-Path "\\FS01\Finance"

Sysinternals

The following Sysinternals tools were used:

Process Explorer

Process Monitor

Autoruns

TCPView

Process Explorer

Process Explorer was used to inspect:

process name

PID

parent process

CPU

memory

user

DLLs

handles

A test was performed by opening Notepad and locating:

notepad.exe

Process Monitor

Process Monitor was used to monitor real-time Windows activity.

It was used to troubleshoot a permission problem on:

C:\RKT-Day07\Restricted

The filter:

ACCESS DENIED

identified the affected resource:

C:\RKT-Day07\Restricted\sarah-test.txt

The root cause was incorrect NTFS permissions.

The permissions were corrected and the file creation test succeeded.

Detailed troubleshooting is documented in:

troubleshooting/[day07-break-fix.md](http://day07-break-fix.md)

Autoruns

Autoruns was used to review programs and components configured to start automatically.

Important sections:

Logon

Services

Scheduled Tasks

Drivers

TCPView

TCPView was used to inspect active TCP and UDP connections.

Important information:

Process

Local Address

Local Port

Remote Address

Remote Port

State

Example state:

ESTABLISHED

ITSM Concepts

Incident

An unexpected interruption or degradation of a service.

Example:

User cannot access the Internet.

Service Request

A normal request from a user.

Example:

Password reset request.

Problem

The underlying cause of one or more incidents.

Example:

Repeated DNS failures affecting multiple users.

Change

A planned modification to the IT environment.

Example:

Changing a firewall rule.

Impact

Impact represents how many users, devices, or services are affected.

Urgency

Urgency represents how quickly the issue must be resolved.

Priority

The lab used:

P1 = Critical

P2 = High

P3 = Medium

P4 = Low

SLA

A Service Level Agreement defines expected response or resolution targets.

Escalation

Escalation means transferring a ticket to another technician or specialized team when required.

Root Cause

The root cause is the technical reason the incident occurred.

Validation

Validation confirms that the solution actually fixed the problem.

Closure Notes

Closure notes document:

root cause

resolution

validation

final ticket status

Jira Service Management

A Jira Service Management space was created:

RKT Service Desk Lab

The following ticket format was used:

Ticket ID

Category

Impact

Urgency

Priority

User

Symptoms

Evidence

Troubleshooting

Root Cause

Resolution

Validation

Escalation

Ticket Distribution

Endpoint

TKT-001 — Slow workstation

TKT-002 — Audio not working

TKT-003 — OneDrive synchronization issue

TKT-004 — Windows Update issue

Total:

4 Endpoint tickets

Network

TKT-005 — No Internet access

TKT-006 — FS01 hostname resolution problem

TKT-007 — SMB file share unavailable

Total:

3 Network tickets

Active Directory / Access

TKT-008 — Finance drive mapping missing

TKT-009 — Finance share access denied

TKT-010 — Domain password reset

Total:

3 AD/Access tickets

Security

TKT-011 — Windows Firewall blocking required traffic

TKT-012 — Windows Defender protection issue

Total:

2 Security tickets

Knowledge Base

Three Knowledge Base articles were created:

operations/kb/[KB-001-Password-Reset.md](http://KB-001-Password-Reset.md)

operations/kb/[KB-002-No-Internet.md](http://KB-002-No-Internet.md)

operations/kb/[KB-003-Network-Printer.md](http://KB-003-Network-Printer.md)

Troubleshooting Workflow

User reports problem

↓

Identify symptoms

↓

Collect evidence

↓

Reproduce issue

↓

Use the appropriate tool

↓

Identify root cause

↓

Apply resolution

↓

Validate

↓

Document

↓

Close or escalate

What I Learned

Day 07 demonstrated how to:

troubleshoot Windows endpoints

inspect processes and services

review Windows logs

troubleshoot network drives and printers

use Process Explorer

use Process Monitor

use Autoruns

use TCPView

identify ACCESS DENIED

troubleshoot NTFS permissions

distinguish Incident, Service Request, Problem and Change

understand Impact, Urgency, Priority and SLA

document Root Cause and Validation

use Jira Service Management

create reusable Knowledge Base documentation