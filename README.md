# RKT Enterprise IT Lab

Projet personnel réalisé pendant mon DEC en Techniques de l'informatique, profil Réseaux et sécurité.

Le but est de pratiquer sur une infrastructure complète : réseau, Windows Server, Active Directory, PowerShell, support TI et sécurité.

## Architecture

![Architecture segmentée du laboratoire](diagrams/architecture-v2-segmented.png)

### Réseaux

| Zone | Réseau | Passerelle | Usage |
|---|---|---|---|
| USERS | 10.10.10.0/24 | 10.10.10.1 | postes utilisateurs |
| SERVERS | 10.10.20.0/24 | 10.10.20.1 | serveurs |
| MGMT | 10.10.30.0/24 | 10.10.30.1 | administration |
| SECURITY | 10.10.40.0/24 | 10.10.40.1 | outils et tests de sécurité |

Les réseaux internes sont des réseaux VMware host-only. pfSense fait le routage, le filtrage et le NAT.

### Machines principales

| Machine | Rôle |
|---|---|
| PFSENSE01 | pare-feu, routage et NAT |
| DC01 | Active Directory et DNS |
| FS01 | partages SMB |
| W11-01 | poste utilisateur Windows 11 |
| ADMIN01 | poste d'administration |
| UBUNTU01 | pratique Linux |
| WAZUH01 | serveur Wazuh sur Ubuntu 24.04 LTS |

## Parcours du lab

| Étape | Sujet | État |
|---|---|---|
| [Day 01](docs/day01-virtualization-foundations.md) | VMware et réseaux virtuels | fait |
| [Day 02](docs/day02-tcpip-foundations.md) | TCP/IP et Wireshark | fait |
| [Day 03](docs/day03-pfsense-segmentation.md) | pfSense, NAT et segmentation | fait |
| [Day 04](docs/day04-active-directory-foundation.md) | Active Directory et DNS | fait |
| [Day 05](docs/day05-ad-gpo-file-services.md) | GPO, SMB, AGDLP et LAPS | fait |
| [Day 06](docs/day06-powershell-automation.md) | PowerShell | fait |
| [Day 07](docs/day07-windows-endpoint-sysinternals.md) | Windows, Sysinternals et Jira | fait |
| [Day 08](docs/day08-entra-intune-autopilot.md) | Entra ID, Intune et Autopilot | étude |
| [Day 09](docs/day09-fortinet-linux-vpn.md) | Fortinet, Linux et VPN | étude + pratique Linux |
| [Day 10](docs/day10-wazuh-sysmon-incident-response.md) | Wazuh, Sysmon et réponse aux incidents | partiel |
| [Day 11](docs/day11-enterprise-operations.md) | tickets, escalade, change management et ITGC | fait |

## Travail réalisé

### Réseau

Adressage IPv4, ARP, ICMP, DNS, TCP, routage, NAT, règles pfSense et dépannage entre plusieurs réseaux.

### Windows Server et Active Directory

Domaine corp.rktlab.test, OU, utilisateurs, groupes, DNS, GPO, partages SMB, AGDLP et Windows LAPS.

### PowerShell

Les scripts du dossier [scripts](scripts/) couvrent la création d'utilisateurs AD, la désactivation d'un compte, l'inventaire d'un poste et des tests réseau.

### Support TI

Le Day 07 contient du dépannage Windows avec Sysinternals, des tickets Jira et trois articles de base de connaissances.

Le Day 11 ajoute une queue de 12 incidents, cinq traitements documentés, deux escalades, un change request et une mini revue ITGC.

### Sécurité

WAZUH01 est installé et le dashboard fonctionne. La connexion de W11-01 comme agent Wazuh n'a pas été finalisée pendant le Day 10.

Le problème reste documenté dans le Day 11 comme incident escaladé au lieu d'être présenté comme résolu.

## Travaux académiques

J'ai aussi regroupé mes rapports de cours par domaine : Windows Server, réseaux Cisco, Linux, cybersécurité, supervision réseau, PowerShell, Python et MariaDB.

Les travaux faits en équipe sont identifiés dans l'index.

[Voir les travaux académiques et les compétences couvertes](academic-work/README.md)

## À voir en priorité

- [Architecture réseau](diagrams/architecture-v2-segmented.png)
- [Day 05 — GPO, services de fichiers et permissions](docs/day05-ad-gpo-file-services.md)
- [Test-RKTNetwork.ps1](scripts/Test-RKTNetwork.ps1)
- [Day 07 — Windows, Sysinternals et support TI](docs/day07-windows-endpoint-sysinternals.md)
- [Day 10 — Dépannage Wazuh](troubleshooting/day10-wazuh-connectivity.md)
- [Day 11 — Opérations TI](docs/day11-enterprise-operations.md)
- [Travaux académiques](academic-work/README.md)
- [Journal d'incidents Day 11](operations/tickets/day11-incident-log.md)

## Limites

Entra ID, Intune, Autopilot et FortiGate ont été étudiés sans être présentés comme des déploiements réels en entreprise.

Pour Wazuh, le serveur fonctionne mais l'intégration de l'agent Windows reste à reprendre.

## Sécurité du dépôt

Aucun mot de passe réel, secret d'API, certificat privé ou fichier de machine virtuelle n'est stocké dans le dépôt. Les comptes utilisés sont fictifs.
