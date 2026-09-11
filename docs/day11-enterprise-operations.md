# Day 11 — Opérations TI

Le Day 11 regroupe une file de 12 incidents simulés pour pratiquer la priorisation, le dépannage, l'escalade et la documentation.

## Queue d'incidents

| ID | Incident | Catégorie | Traitement |
|---|---|---|---|
| INC-101 | Internet unavailable | Réseau | traité |
| INC-102 | DNS failure | Réseau | traité |
| INC-103 | Firewall block | Réseau | traité |
| INC-104 | Account locked | Active Directory | traité |
| INC-105 | Domain join failure | Active Directory | queue |
| INC-106 | GPO not applied | Active Directory | queue |
| INC-107 | Slow workstation | Endpoint | queue |
| INC-108 | Printer unavailable | Endpoint | queue |
| INC-109 | Windows service stopped | Endpoint | queue |
| INC-110 | Finance share denied | Permissions | traité |
| INC-111 | Multiple failed logins | Sécurité | escalade |
| INC-112 | Wazuh agent disconnected | Sécurité | escalade |

La priorité est basée sur l'impact, l'urgence et le service touché.

Le détail des 12 incidents est dans [le journal du Day 11](../operations/tickets/day11-incident-log.md).

## Méthode

Pour les tickets traités, je garde le même ordre :

- scope
- preuve
- hypothèse
- test
- cause
- correction
- validation
- documentation

## Cinq traitements documentés

INC-101 : carte réseau et passerelle de W11-01.

INC-102 : connectivité IP et DNS interne sur DC01.

INC-103 : blocage SMB vers FS01 et validation du port TCP 445 après correction.

INC-104 : verrouillage d'un compte Active Directory de test et déverrouillage.

INC-110 : accès Finance et appartenance au groupe GG_FINANCE_USERS.

## Escalades

INC-111 est escaladé vers la sécurité. Plusieurs échecs de connexion demandent une vérification des journaux et du compte avant de conclure à un incident.

INC-112 est escaladé vers réseau / sécurité. Le Day 10 a montré que W11-01 ne valide pas encore la connexion TCP vers WAZUH01 sur le port 1514.

## Change Management

Le changement lié aux règles Wazuh est documenté ici : [CHG-001 — Règle Wazuh](../operations/changes/CHG-001-New-Firewall-Rule.md).

Le changement reste en attente de validation tant que la communication Wazuh n'est pas confirmée.

## Mini revue ITGC

La revue couvre quatre points : gestion des accès, gestion des changements, logs et monitoring, sauvegarde et récupération.

Voir [ITGC Mini Review](../operations/audit/ITGC-mini-review.md).

## État

Le Day 11 est terminé dans le dépôt avec la queue d'incidents, les traitements documentés, les deux escalades, le change request et la mini revue ITGC.

Les incidents sont des scénarios de lab. Le problème Wazuh reste volontairement indiqué comme non résolu au lieu d'inventer une validation.