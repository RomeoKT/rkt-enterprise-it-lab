# RKT Enterprise IT Lab

Je suis étudiant en Techniques de l'informatique, profil Réseaux et sécurité. J'ai monté ce lab pour pratiquer sur une infrastructure complète plutôt que de faire seulement des exercices séparés.

L'idée est simple : construire, tester, casser volontairement certains éléments, dépanner, puis documenter ce qui s'est réellement passé.

## Ce que le lab contient

- VMware Workstation Pro pour la virtualisation
- pfSense pour le routage, le NAT et la segmentation
- Windows Server 2025 avec Active Directory, DNS, GPO et partages SMB
- PowerShell pour automatiser des tâches d'administration et de diagnostic
- Jira Service Management et Sysinternals pour le support et le dépannage Windows
- Ubuntu, Fortinet/VPN en étude, puis Wazuh pour une première approche de la supervision de sécurité

## Architecture

![Architecture segmentée du laboratoire](diagrams/architecture-v2-segmented.png)

### Réseaux

| Zone | Réseau | Passerelle | Usage |
|---|---|---|---|
| USERS | `10.10.10.0/24` | `10.10.10.1` | postes utilisateurs |
| SERVERS | `10.10.20.0/24` | `10.10.20.1` | serveurs |
| MGMT | `10.10.30.0/24` | `10.10.30.1` | administration |
| SECURITY | `10.10.40.0/24` | `10.10.40.1` | outils et tests de sécurité |

Ces zones sont des réseaux VMware host-only. Je les utilise pour reproduire une segmentation logique; ce ne sont pas des VLAN physiques.

### Machines principales

| Machine | Rôle |
|---|---|
| `PFSENSE01` | pare-feu, routage inter-réseaux et NAT |
| `DC01` | Active Directory Domain Services et DNS |
| `FS01` | services de fichiers SMB |
| `W11-01` | poste utilisateur Windows 11 |
| `ADMIN01` | poste d'administration |
| `UBUNTU01` | pratique Linux |
| `WAZUH01` | Ubuntu 24.04 LTS, serveur/indexer/dashboard Wazuh |

## Parcours du lab

| Étape | Travail principal | État |
|---|---|---|
| [Day 01](docs/day01-virtualization-foundations.md) | VMware et réseaux virtuels | fait |
| [Day 02](docs/day02-tcpip-foundations.md) | TCP/IP, Wireshark et break/fix réseau | fait |
| [Day 03](docs/day03-pfsense-segmentation.md) | pfSense, filtrage, NAT et segmentation | fait |
| [Day 04](docs/day04-active-directory-foundation.md) | Active Directory et DNS | fait |
| [Day 05](docs/day05-ad-gpo-file-services.md) | GPO, SMB, AGDLP et LAPS | fait |
| [Day 06](docs/day06-powershell-automation.md) | automatisation PowerShell | fait |
| [Day 07](docs/day07-windows-endpoint-sysinternals.md) | support Windows, Sysinternals et Jira | fait |
| [Day 08](docs/day08-entra-intune-autopilot.md) | Entra ID, Intune et Autopilot | étude |
| [Day 09](docs/day09-fortinet-linux-vpn.md) | Fortinet, Linux et VPN | étude + pratique Linux |
| [Day 10](docs/day10-wazuh-sysmon-incident-response.md) | Wazuh, Sysmon et réponse aux incidents | partiel, documenté |

## Ce que j'ai réellement pratiqué

### Réseau

J'ai travaillé l'adressage IPv4, ARP, ICMP, DNS, TCP, le routage, le NAT, les règles de pare-feu et le dépannage entre plusieurs réseaux. Les Days 2 et 3 contiennent les captures Wireshark et pfSense utilisées pendant les tests.

### Windows Server et Active Directory

Le domaine du lab est `corp.rktlab.test`. J'y ai configuré les OU, utilisateurs, groupes, DNS, GPO, partages SMB, AGDLP et Windows LAPS. J'ai aussi reproduit plusieurs erreurs pour vérifier ma méthode de dépannage.

### PowerShell

Les scripts du dossier [`scripts/`](scripts/) couvrent quatre besoins concrets : création d'utilisateurs AD depuis un CSV, désactivation d'un compte, inventaire d'un poste et tests réseau automatisés.

### Support TI

Le Day 7 regroupe du dépannage Windows avec Sysinternals, des tickets Jira et trois articles de base de connaissances. Le but était de documenter les actions comme je le ferais dans un contexte de support, pas seulement de trouver la solution.

### Sécurité

`WAZUH01` a été installé et le dashboard est accessible. La connexion de `W11-01` comme agent Wazuh n'a pas été finalisée pendant le Day 10. Je l'ai laissée clairement indiquée comme limite du lab au lieu de présenter une collecte que je n'ai pas validée.

## Si vous regardez seulement quelques fichiers

- [Architecture réseau](diagrams/architecture-v2-segmented.png)
- [Day 05 — AD, GPO et services de fichiers](docs/day05-ad-gpo-file-services.md)
- [`Test-RKTNetwork.ps1`](scripts/Test-RKTNetwork.ps1)
- [Day 07 — Windows, Sysinternals et ITSM](docs/day07-windows-endpoint-sysinternals.md)
- [Day 10 — Dépannage de la connexion Wazuh](troubleshooting/day10-wazuh-connectivity.md)

## Limites du projet

Ce dépôt représente un lab étudiant, pas un environnement de production. Entra ID, Intune, Autopilot et FortiGate ont été étudiés et documentés sans être présentés comme des déploiements d'entreprise réels. Pour Wazuh, l'installation du serveur a fonctionné, mais l'intégration de l'agent Windows reste à reprendre.

Je préfère garder ces limites visibles : elles montrent ce qui a réellement été fait, ce qui a été testé et ce qui reste à améliorer.

## Sécurité du dépôt

Aucun mot de passe réel, secret d'API, certificat privé ou fichier de machine virtuelle n'est stocké ici. Les comptes présents dans les exemples sont fictifs et les fichiers temporaires sont exclus avec `.gitignore`.
