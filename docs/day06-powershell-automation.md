\# Day 06 — PowerShell Automation



\## Objective



The objective of Day 06 was to automate repetitive Active Directory and infrastructure administration tasks using PowerShell.



The lab focused on PowerShell objects, properties, pipelines, variables, arrays, conditional logic, functions, CSV processing, error handling, and logging.



\---



\## Build 1 — Automated User Onboarding



The `New-RKTUsers.ps1` script automates Active Directory user provisioning from a CSV file.



The source file is:



```text

configs/users.csv

```



The CSV contains the following fields:



```text

FirstName

LastName

Department

Location

Title

```



For each valid user, the script:



1\. Reads the CSV record.

2\. Generates a username using `firstname.lastname`.

3\. Verifies the department.

4\. Determines the appropriate Active Directory OU.

5\. Creates the Active Directory user.

6\. Assigns the departmental Global Security Group.

7\. Configures a temporary password.

8\. Forces a password change at the next logon.

9\. Logs the result.



Example permission relationship:



```text

Nora Bensaid

→ GG\_FINANCE\_USERS

→ DL\_FINANCE\_RW

→ \\\\FS01\\Finance

```



Existing users are detected and skipped instead of causing the entire script to fail.



\---



\## Build 2 — Automated User Offboarding



The `Disable-RKTUser.ps1` script automates basic user offboarding.



The script:



\- Disables the Active Directory account.

\- Removes departmental Global Group access.

\- Moves the account to the `Disabled-Accounts` OU.

\- Logs each action.



The workflow was validated using a test account.



\---



\## Build 3 — Workstation Inventory



The `Get-RKTInventory.ps1` script collects basic system information from a Windows computer.



The collected information includes:



```text

Hostname

Operating System

OS Version

RAM

IPv4 Address

C: Drive Size

C: Drive Free Space

Logged-on User

```



The result is displayed in PowerShell and exported to CSV.



This provides a simple example of automated endpoint inventory collection.



\---



\## Build 4 — Network Validation



The `Test-RKTNetwork.ps1` script performs basic network validation.



The script tests:



```text

Default Gateway

DNS Resolution

Domain Controller

FS01

Internet Connectivity

TCP Port 53

TCP Port 445

```



The results are returned as `PASS` or `FAIL` and exported to CSV.



This provides a repeatable method for checking the basic connectivity required by the enterprise lab.



\---



\## Error Handling



The scripts use PowerShell error handling to avoid uncontrolled failures.



The implementation uses:



```powershell

try {

&#x20;   # Operation

}

catch {

&#x20;   # Log error and continue safely

}

```



This allows the automation to handle problems such as:



\- Existing Active Directory users

\- Invalid departments

\- Missing Organizational Units

\- Invalid CSV paths

\- Missing Active Directory groups

\- Unreachable network services



\---



\## Break/Fix — Invalid Department



A deliberate invalid department was temporarily added to the CSV:



```text

Department = Accounting

```



There is no `Accounting` OU in the lab.



The onboarding script detected the invalid department, logged the error, and continued processing the following CSV entries instead of terminating.



This validated that one bad record does not stop the entire onboarding process.



The invalid test record was removed from the final CSV after validation.



\---



\## Logging



The scripts create local operational logs under:



```text

C:\\RKTLogs

```



Examples include:



```text

C:\\RKTLogs\\onboarding.log

C:\\RKTLogs\\offboarding.log

C:\\RKTLogs\\inventory.csv

C:\\RKTLogs\\network-test.csv

```



Passwords and credentials are not stored in the repository.



\---



\## Files



The Day 06 portfolio contains:



```text

configs/users.csv



scripts/New-RKTUsers.ps1

scripts/Disable-RKTUser.ps1

scripts/Get-RKTInventory.ps1

scripts/Test-RKTNetwork.ps1



docs/day06-powershell-automation.md

```



\---



\## Validation



The following tasks were validated:



\- CSV-based Active Directory provisioning

\- Username generation

\- Department OU selection

\- Department security group assignment

\- Temporary password configuration

\- Password change at next logon

\- Existing user detection

\- Invalid department error handling

\- User account disabling

\- Department access removal

\- Moving disabled accounts

\- Windows system inventory

\- Gateway testing

\- DNS resolution testing

\- Domain Controller connectivity

\- File Server connectivity

\- TCP port 53 testing

\- TCP port 445 testing

\- Logging



\---



\## What I Learned



Day 06 demonstrated how PowerShell can replace repetitive administrative tasks with repeatable and documented automation.



I learned how to process CSV data, manipulate Active Directory objects, use objects and properties through the PowerShell pipeline, handle failures with `try/catch`, create logs, automate user lifecycle operations, collect endpoint information, and perform repeatable network validation.

