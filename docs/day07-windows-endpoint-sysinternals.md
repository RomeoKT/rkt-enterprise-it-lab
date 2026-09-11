# Day 07 — Windows, Sysinternals et support TI

Cette journée est plus proche d'un contexte de support : diagnostiquer un poste Windows, trouver une preuve avec les bons outils, puis documenter le ticket proprement.

## Poste utilisé

| Élément | Valeur |
|---|---|
| Poste | `W11-01` |
| Domaine | `corp.rktlab.test` |
| Contrôleur de domaine | `DC01` |
| Serveur de fichiers | `FS01` |
| Pare-feu | pfSense |
| Service Desk | Jira Service Management |

## Outils Windows revus

Task Manager, Services, Device Manager, Event Viewer, Disk Management, Resource Monitor, Windows Update, Defender, Firewall, RDP, lecteurs réseau, imprimantes et profils utilisateurs.

L'idée n'était pas d'ouvrir tous les outils pour faire une capture, mais de savoir lequel utiliser selon le symptôme.

## Sysinternals

### Process Explorer

Je l'ai utilisé pour regarder les processus, PID, processus parents, compte utilisateur et consommation CPU/mémoire.

### Process Monitor

Le scénario le plus utile du Day 07 : un utilisateur pouvait lire `C:\RKT-Day07\Restricted` mais pas créer de fichier. Avec un filtre `ACCESS DENIED`, Procmon a permis de voir l'opération bloquée et de remonter à la permission manquante.

Le détail est dans [Day 07 — Dépannage avec Process Monitor](../troubleshooting/day07-break-fix.md).

### Autoruns et TCPView

Autoruns a servi à vérifier les éléments de démarrage. TCPView m'a permis de relier un processus à ses connexions et ports actifs.

## Jira Service Management

J'ai créé un petit Service Desk pour pratiquer la logique incident/demande, impact, urgence, priorité, cause, résolution et validation.

![File de tickets Jira](../screenshots/day07-jira-ticket-queue.png)

![Détail d'un ticket Jira](../screenshots/day07-jira-ticket-detail.png)

Le modèle utilisé est ici : [TICKET-TEMPLATE.md](../operations/tickets/TICKET-TEMPLATE.md).

## Base de connaissances

- [KB-001 — Réinitialiser un mot de passe AD](../operations/kb/KB-001-Password-Reset.md)
- [KB-002 — Diagnostiquer un problème d'accès Internet](../operations/kb/KB-002-No-Internet.md)
- [KB-003 — Diagnostiquer une imprimante réseau](../operations/kb/KB-003-Network-Printer.md)

## Ma méthode de dépannage

Je pars du symptôme, je récupère les faits, je reproduis si possible, puis je teste une hypothèse à la fois. Je ne considère pas le ticket terminé avant d'avoir validé la correction et laissé une trace compréhensible de ce qui a été fait.

## Ce que cette étape apporte au projet

Les Days précédents montrent surtout de la configuration. Celui-ci montre davantage comment je travaille quand quelque chose ne fonctionne pas : outils, preuve, correction et documentation.
