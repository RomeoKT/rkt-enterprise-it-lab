\# INC-AD01 — Domain Join Failure



\## Symptom



W11-01 could not join the domain corp.rktlab.test.



The workstation returned an error indicating that an Active Directory domain controller could not be contacted.



\## Affected System



W11-01



\## Domain Controller



DC01



IP:



10.10.20.10



\## Initial Troubleshooting



The following tests failed:



```powershell

Test-NetConnection 10.10.20.10 -Port 53

Resolve-DnsName DC01.corp.rktlab.test -Server 10.10.20.10

nltest /dsgetdc:corp.rktlab.test

