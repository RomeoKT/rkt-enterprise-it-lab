# Day 07 — Windows, Sysinternals et support TI

Dépannage d'un poste Windows avec Sysinternals et documentation dans Jira Service Management.

## Environnement

| Élément | Valeur |
|---|---|
| Poste | W11-01 |
| Domaine | corp.rktlab.test |
| Contrôleur de domaine | DC01 |
| Serveur de fichiers | FS01 |
| Pare-feu | pfSense |
| Service Desk | Jira Service Management |

## Outils utilisés

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

Scénario principal : un utilisateur pouvait lire C:\RKT-Day07\Restricted mais pas créer de fichier.

Le filtre ACCESS DENIED a permis d'identifier la permission manquante.

Voir [Day 07 — Dépannage avec Process Monitor](../troubleshooting/day07-break-fix.md).

## Jira Service Management

J'ai utilisé Jira pour pratiquer les tickets d'incident et de demande, la priorité, la résolution et la validation.

![File de tickets Jira](../screenshots/day07-jira-ticket-queue.png)

![Détail d'un ticket Jira](../screenshots/day07-jira-ticket-detail.png)

Modèle : [TICKET-TEMPLATE.md](../operations/tickets/TICKET-TEMPLATE.md)

## Base de connaissances

- [KB-001 — Réinitialiser un mot de passe AD](../operations/kb/KB-001-Password-Reset.md)
- [KB-002 — Diagnostiquer un problème d'accès Internet](../operations/kb/KB-002-No-Internet.md)
- [KB-003 — Diagnostiquer une imprimante réseau](../operations/kb/KB-003-Network-Printer.md)

## Méthode

Symptôme → vérification → test → cause → correction → validation.