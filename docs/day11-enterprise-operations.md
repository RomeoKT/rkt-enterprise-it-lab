# Day 11 — Opérations TI

Le Day 11 sert à traiter une file de tickets comme dans un contexte de support TI.

## Queue Jira

| ID | Incident | Catégorie | Action |
|---|---|---|---|
| INC-101 | Internet unavailable | Réseau | à résoudre |
| INC-102 | DNS failure | Réseau | à résoudre |
| INC-103 | Firewall block | Réseau | à résoudre |
| INC-104 | Account locked | Active Directory | à résoudre |
| INC-105 | Domain join failure | Active Directory | queue |
| INC-106 | GPO not applied | Active Directory | queue |
| INC-107 | Slow workstation | Endpoint | queue |
| INC-108 | Printer unavailable | Endpoint | queue |
| INC-109 | Windows service stopped | Endpoint | queue |
| INC-110 | Finance share denied | Permissions | à résoudre |
| INC-111 | Multiple failed logins | Sécurité | à escalader |
| INC-112 | Wazuh agent disconnected | Sécurité | à escalader |

La priorité se fait selon l'impact, l'urgence et le service touché.

## Méthode utilisée

Pour chaque ticket traité :

- scope
- preuve
- hypothèse
- test
- cause
- correction
- validation
- documentation

## Tickets à résoudre

INC-101 : vérifier la carte réseau et la passerelle de W11-01.

INC-102 : vérifier la connectivité IP puis le DNS interne sur DC01.

INC-103 : reproduire un blocage SMB vers FS01, identifier la règle et valider le retour du port 445 après correction.

INC-104 : utiliser un compte AD de test, vérifier le verrouillage puis le déverrouiller.

INC-110 : utiliser un compte Finance de test et vérifier son appartenance à GG_FINANCE_USERS.

## Escalades

INC-111 est prévu pour une escalade vers la sécurité si plusieurs échecs de connexion demandent une analyse plus poussée.

INC-112 reprend le problème du Day 10. W11-01 ne valide pas encore la connexion TCP vers WAZUH01 sur le port 1514. Le ticket doit être escaladé après les vérifications de base.

## Change Management

Le changement lié aux règles Wazuh est documenté ici : [CHG-001 — Règle Wazuh](../operations/changes/CHG-001-New-Firewall-Rule.md).

## Mini revue ITGC

La revue couvre la gestion des accès, les changements, les logs et la sauvegarde : [ITGC Mini Review](../operations/audit/ITGC-mini-review.md).

## Preuves à ajouter après les tests

- screenshots/day11-ticket-queue.png
- screenshots/day11-resolved-ticket.png

## État

La structure du Day 11 est prête dans le dépôt. Les tickets ne sont pas marqués comme résolus tant que les tests et validations ne sont pas faits dans le lab.
