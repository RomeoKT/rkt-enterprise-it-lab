\# Day 04 — Active Directory Foundation



\## Objective



Deploy Active Directory Domain Services and DNS on DC01, create the domain structure, and join W11-01 to the domain.



\## DC01 Configuration



\- Hostname: DC01

\- IP Address: 10.10.20.10

\- Subnet Mask: 255.255.255.0

\- Default Gateway: 10.10.20.1

\- DNS Server: 10.10.20.10

\- Roles:

&#x20; - Active Directory Domain Services

&#x20; - DNS Server



\## Active Directory Domain



Domain:



corp.rktlab.test



\## Organizational Units



\- Montreal

&#x20; - Users

&#x20; - Computers

\- Laval

&#x20; - Users

&#x20; - Computers

\- Departments

&#x20; - Finance

&#x20; - HR

&#x20; - IT

&#x20; - Sales

&#x20; - Operations

\- Groups

\- Servers

\- Admins

\- Disabled-Accounts



\## Domain Controller Validation



The domain controller was validated using:



```powershell

Get-ADDomain

Get-Service DNS,Netlogon,KDC,ADWS

