# Day 07 — Windows, Sysinternals et support TI

Dépannage de W11-01 avec les outils Windows, Sysinternals et Jira Service Management.

## Environnement

| Élément | Valeur |
|---|---|
| Poste | W11-01 |
| Domaine | corp.rktlab.test |
| Contrôleur de domaine | DC01 |
| Serveur de fichiers | FS01 |
| Pare-feu | pfSense |
| Service Desk | Jira Service Management |

## Outils

- Task Manager
- Services
- Device Manager
- Event Viewer
- Disk Management
- Resource Monitor
- Windows Defender
- Windows Firewall
- RDP
- Process Explorer
- Process Monitor
- Autoruns
- TCPView

## Process Monitor

Scénario : un utilisateur pouvait lire C:\RKT-Day07\Restricted mais pas créer de fichier.

Le filtre ACCESS DENIED a montré la permission manquante.

Voir [le dépannage Process Monitor](../troubleshooting/day07-break-fix.md).

## Jira

Tickets d'incident et de demande, priorité, résolution et validation.

![File de tickets Jira](../screenshots/day07-jira-ticket-queue.png)

![Détail d'un ticket Jira](../screenshots/day07-jira-ticket-detail.png)

[Modèle de ticket](../operations/tickets/TICKET-TEMPLATE.md)

## Base de connaissances

- [Réinitialiser un mot de passe AD](../operations/kb/KB-001-Password-Reset.md)
- [Problème d'accès Internet](../operations/kb/KB-002-No-Internet.md)
- [Imprimante réseau](../operations/kb/KB-003-Network-Printer.md)

Ordre de dépannage : symptôme, vérification, test, cause, correction, validation.
