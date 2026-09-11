# RKT Enterprise IT Lab

Projet personnel de laboratoire visant à reproduire une petite infrastructure d'entreprise et à pratiquer des tâches concrètes en réseau, Windows Server, Active Directory, PowerShell, dépannage poste client, support TI et supervision de sécurité.

> **Statut :** projet en développement. Il s'agit d'un environnement de laboratoire, pas d'un environnement de production. Les comptes et données utilisés dans le dépôt sont fictifs.

## Objectifs du projet

- Construire une infrastructure virtualisée avec VMware Workstation Pro
- Segmenter plusieurs réseaux avec pfSense
- Déployer Windows Server, Active Directory, DNS, GPO et services de fichiers
- Automatiser des tâches d'administration avec PowerShell
- Diagnostiquer des problèmes réseau, Windows et Active Directory
- Documenter les incidents avec une approche de support TI
- Étudier Microsoft Entra ID, Intune, Autopilot, Fortinet et les VPN
- Installer Wazuh et pratiquer une méthode simple de réponse aux incidents

## État des technologies

| Technologie | Statut |
|---|---|
| VMware Workstation Pro | Réalisé |
| pfSense | Réalisé |
| TCP/IP et Wireshark | Réalisé |
| Windows Server 2025 | Réalisé |
| Active Directory Domain Services | Réalisé |
| DNS | Réalisé |
| GPO | Réalisé |
| Services de fichiers SMB | Réalisé |
| AGDLP | Réalisé |
| Windows LAPS | Réalisé |
| PowerShell | Réalisé |
| Sysinternals | Réalisé |
| Jira Service Management | Pratiqué |
| Microsoft Entra ID | Étudié et documenté |
| Microsoft Intune | Étudié et documenté |
| Windows Autopilot | Étudié et documenté |
| FortiGate | Étudié et documenté |
| VPN IPsec | Étudié et documenté |
| Wazuh | Installé, dashboard accessible |
| Sysmon | Étudié, intégration Wazuh non terminée |
| Réponse aux incidents | Scénario documenté |

## Architecture

![Architecture segmentée du laboratoire](diagrams/architecture-v2-segmented.png)

### Plan d'adressage

| Zone | Réseau | Passerelle | Utilisation |
|---|---|---|---|
| USERS | `10.10.10.0/24` | `10.10.10.1` | Postes utilisateurs |
| SERVERS | `10.10.20.0/24` | `10.10.20.1` | Serveurs |
| MGMT | `10.10.30.0/24` | `10.10.30.1` | Administration |
| SECURITY | `10.10.40.0/24` | `10.10.40.1` | Outils et tests de sécurité |

Les quatre zones sont des réseaux virtuels **host-only** VMware. Ce ne sont pas des VLAN physiques.

### Machines virtuelles

| Machine | Rôle |
|---|---|
| `PFSENSE01` | Pare-feu, routage inter-réseaux et NAT |
| `DC01` | Windows Server 2025, AD DS et DNS |
| `FS01` | Windows Server 2025, services de fichiers SMB |
| `W11-01` | Poste utilisateur Windows 11 |
| `ADMIN01` | Poste d'administration Windows 11 |
| `UBUNTU01` | Pratique Linux |
| `WAZUH01` | Ubuntu 24.04 LTS, serveur et dashboard Wazuh |

## Segmentation réseau

pfSense assure le routage et le filtrage entre les zones.

Principes appliqués :

- `USERS → Internet` : autorisé selon les règles du laboratoire
- `USERS → SERVERS` : limité aux services nécessaires à Active Directory, DNS et SMB
- `USERS → MGMT` : bloqué
- `MGMT → réseaux internes` : accès d'administration autorisé selon le besoin
- trafic non explicitement autorisé : bloqué
- accès Internet : NAT sortant via pfSense

Voir :

- [Day 03 — Segmentation réseau avec pfSense](docs/day03-pfsense-segmentation.md)
- [Day 03 — Dépannage pfSense](troubleshooting/day03-pfsense-break-fix.md)

## Active Directory et services Windows

Le domaine du laboratoire est `corp.rktlab.test`.

Les travaux réalisés comprennent :

- déploiement d'AD DS et DNS sur `DC01`
- organisation des OU
- création d'utilisateurs et de groupes
- modèle de permissions AGDLP
- partages SMB sur `FS01`
- GPO
- mappage de lecteurs réseau
- Windows LAPS
- dépannage de permissions et de stratégies

Voir :

- [Day 04 — Active Directory et DNS](docs/day04-active-directory-foundation.md)
- [Day 05 — AD, GPO et services de fichiers](docs/day05-ad-gpo-file-services.md)
- [Day 05 — Dépannage AD](troubleshooting/day05-ad-break-fix.md)

## Automatisation PowerShell

Le dépôt contient quatre scripts principaux :

- [`New-RKTUsers.ps1`](scripts/New-RKTUsers.ps1) — création d'utilisateurs AD à partir d'un CSV
- [`Disable-RKTUser.ps1`](scripts/Disable-RKTUser.ps1) — désactivation et déplacement d'un compte
- [`Get-RKTInventory.ps1`](scripts/Get-RKTInventory.ps1) — inventaire d'un poste Windows
- [`Test-RKTNetwork.ps1`](scripts/Test-RKTNetwork.ps1) — tests réseau automatisés

Les mots de passe ne sont pas stockés dans le dépôt.

Voir [Day 06 — Automatisation PowerShell](docs/day06-powershell-automation.md).

## Dépannage et support TI

Le laboratoire contient des scénarios de dépannage portant notamment sur :

- passerelle incorrecte
- masque de sous-réseau incorrect
- DNS
- conflit d'adresse IP
- interface réseau désactivée
- règles pfSense
- NAT
- GPO
- groupes Active Directory
- permissions NTFS
- lecteurs réseau
- erreurs `ACCESS DENIED` avec Process Monitor
- méthodologie de dépannage VPN

La partie support TI comprend aussi Jira Service Management, un modèle de ticket et des articles de base de connaissances.

Voir :

- [Day 07 — Poste Windows, Sysinternals et ITSM](docs/day07-windows-endpoint-sysinternals.md)
- [Modèle de ticket](operations/tickets/TICKET-TEMPLATE.md)
- [KB-001 — Réinitialisation de mot de passe](operations/kb/KB-001-Password-Reset.md)
- [KB-002 — Pas d'accès Internet](operations/kb/KB-002-No-Internet.md)
- [KB-003 — Imprimante réseau](operations/kb/KB-003-Network-Printer.md)

## Sécurité et supervision

`WAZUH01` a été installé sur le réseau SECURITY avec Ubuntu 24.04 LTS. Le dashboard Wazuh est accessible depuis le poste hôte.

La connexion de `W11-01` comme agent Wazuh n'a pas été finalisée : la communication entre `10.10.10.50` et `10.10.40.10` sur les ports Wazuh n'a pas été validée. Le dépôt ne prétend donc pas que les événements Windows ou Sysmon de `W11-01` ont été centralisés dans Wazuh.

Cette limite est documentée au lieu d'être masquée. Le Day 10 couvre aussi les bases de Sysmon, les principaux événements Windows de connexion et une méthode simple de réponse aux incidents.

Voir :

- [Day 10 — Wazuh, Sysmon et réponse aux incidents](docs/day10-wazuh-sysmon-incident-response.md)
- [Day 10 — Dépannage de la connexion Wazuh](troubleshooting/day10-wazuh-connectivity.md)
- [IR-001 — Scénario d'authentification suspecte](operations/incidents/IR-001-Suspicious-Authentication.md)

## Documentation

| Étape | Sujet | Statut |
|---|---|---|
| [Day 01](docs/day01-virtualization-foundations.md) | Virtualisation | Réalisé |
| [Day 02](docs/day02-tcpip-foundations.md) | TCP/IP et Wireshark | Réalisé |
| [Day 03](docs/day03-pfsense-segmentation.md) | pfSense et segmentation | Réalisé |
| [Day 04](docs/day04-active-directory-foundation.md) | Active Directory et DNS | Réalisé |
| [Day 05](docs/day05-ad-gpo-file-services.md) | GPO, SMB, AGDLP et LAPS | Réalisé |
| [Day 06](docs/day06-powershell-automation.md) | PowerShell | Réalisé |
| [Day 07](docs/day07-windows-endpoint-sysinternals.md) | Windows, Sysinternals et ITSM | Réalisé |
| [Day 08](docs/day08-entra-intune-autopilot.md) | Entra ID, Intune et Autopilot | Étude |
| [Day 09](docs/day09-fortinet-linux-vpn.md) | Fortinet, Linux et VPN | Étude / pratique |
| [Day 10](docs/day10-wazuh-sysmon-incident-response.md) | Wazuh, Sysmon et réponse aux incidents | Lab partiel documenté |

## Sécurité du dépôt

- aucun mot de passe réel
- aucune clé privée
- aucun secret d'API
- aucune capture réseau contenant des données réelles
- données utilisateurs fictives dans `configs/users.csv`
- fichiers de machines virtuelles et fichiers temporaires exclus par `.gitignore`
- aucune preuve inventée pour les parties du laboratoire qui n'ont pas été validées
