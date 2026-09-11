# Day 05 — GPO, services de fichiers et permissions

Configuration de FS01, des partages SMB, des groupes AGDLP, des GPO et de Windows LAPS.

## FS01

| Paramètre | Valeur |
|---|---|
| Nom | FS01 |
| IPv4 | 10.10.20.20 |
| Passerelle | 10.10.20.1 |
| DNS | 10.10.20.10 |
| Domaine | corp.rktlab.test |

Partages principaux :

- \\FS01\Finance
- \\FS01\HR
- \\FS01\IT
- \\FS01\Public

## AGDLP

Modèle utilisé : Account → Global Group → Domain Local Group → Permission.

Exemple Finance : Sarah Tremblay → GG_FINANCE_USERS → DL_FINANCE_RW → \\FS01\Finance.

![Modèle de permissions AGDLP](../diagrams/ad-permission-model.png)

## GPO

- GPO-Workstations-Security
- GPO-Map-Drives
- GPO-Screen-Lock
- GPO-Account-Lockout
- GPO-Windows-Firewall

Commandes de validation :

- gpupdate /force
- gpresult /r
- gpresult /h C:\gpresult.html

Le lecteur F: des utilisateurs Finance pointe vers \\FS01\Finance.

## Permissions

Les permissions de partage contrôlent l'accès SMB. Les permissions NTFS contrôlent les dossiers et fichiers.

## Windows LAPS

Windows LAPS a été configuré sur W11-01. Aucun mot de passe LAPS n'est stocké dans le dépôt.

## Break/fix

J'ai testé quatre problèmes : mauvaise OU, groupe manquant, permissions NTFS incorrectes et lecteur réseau absent.

Voir [Day 05 — Dépannage Active Directory](../troubleshooting/day05-ad-break-fix.md).