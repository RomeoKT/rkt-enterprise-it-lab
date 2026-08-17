# rkt-enterprise-it-lab
Mon projet de lab IT pour apprendre le métier. J'ai monté un mini réseau d'entreprise avec plusieurs réseaux séparés, des VMs Windows, AD, DNS, DHCP, pis tout le tralala.

## Scénario

J'ai simuler une petite compagnie avec des utilisateurs, des serveurs, des admins et un réseau de sécurité. L'idée c'est de pratiquer ce qui se fait en vrai.

## Ce que je voulais faire

- Apprendre à configurer un réseau avec pfSense et des VLANs (ouais c'est pas des vrais VLANs mais des VMnet mais c'est pareil)
- Installer Windows Server et Windows 11
- Mettre en place Active Directory, DNS, DHCP et des GPO
- Automatiser des tâches avec PowerShell (onboarding, offboarding, checks)
- Pratiquer le troubleshooting et documenter les incidents
- Ajouter du monitoring avec Wazuh et Sysmon pour la sécurité

## Topologie

Voir le diagramme dans le dossier diagrams (architecture-v1.png).

## Plan d'adressage

- USERS (VMnet10) : 10.10.10.0/24 – pour les postes des employés
- SERVERS (VMnet20) : 10.10.20.0/24 – pour les serveurs (DC, FS)
- MGMT (VMnet30) : 10.10.30.0/24 – pour les postes d'admin
- SECURITY (VMnet40) : 10.10.40.0/24 – pour les outils de sécurité (Wazuh, etc.)

## Liste des VMs

- PFSENSE01 : pfSense, fait office de firewall et routeur, connecté à tous les réseaux
- DC01 : Windows Server 2025, contrôleur de domaine, DNS, DHCP
- FS01 : Windows Server 2025, serveur de fichiers avec des partages
- W11-01 : Windows 11, poste utilisateur normal
- ADMIN01 : Windows 11, poste admin avec outils
- UBUNTU01 : Ubuntu, pour Wazuh et autres trucs

## Objectifs de sécurité

- Séparer les réseaux pour limiter les accès
- Appliquer le principe du moindre privilège
- Gérer les identités avec AD
- Contrôler l'accès admin (juste depuis le réseau MGMT)
- Logger les événements et surveiller avec Wazuh
- Documenter les procédures de dépannage pour pas oublier

Voilà, c'est mon lab, j'ai appris beaucoup en le construisant et en le cassant/réparant. Je continue à l'améliorer.
