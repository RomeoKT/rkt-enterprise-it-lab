# Day 04 — Active Directory et DNS

Déploiement du domaine Windows sur DC01.

## DC01

| Paramètre | Valeur |
|---|---|
| Nom | DC01 |
| IPv4 | 10.10.20.10 |
| Masque | 255.255.255.0 |
| Passerelle | 10.10.20.1 |
| DNS | 10.10.20.10 |

Rôles installés : Active Directory Domain Services et DNS Server.

Domaine : corp.rktlab.test

## Organisation des OU

- Montreal > Users, Computers
- Laval > Users, Computers
- Departments > Finance, HR, IT, Sales, Operations
- Groups
- Servers
- Admins
- Disabled-Accounts

Les OU de départements sont utilisées par les scripts PowerShell. Les OU de sites servent aussi au ciblage de certaines GPO.

## Vérifications

- Get-ADDomain
- Get-Service DNS,Netlogon,KDC,ADWS

## Preuves

![Active Directory Users and Computers](../screenshots/day04-aduc.png)

![DNS Manager](../screenshots/day04-dns-manager.png)

![W11-01 joint au domaine](../screenshots/day04-w11-domain-membership.png)

## Résultat

W11-01 est joint à corp.rktlab.test et utilise DC01 pour le DNS interne.