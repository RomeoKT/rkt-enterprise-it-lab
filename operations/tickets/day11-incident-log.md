# Day 11 — Journal d'incidents

Ce fichier regroupe la file utilisée pour l'exercice Day 11.

## Queue

| ID | Incident | Priorité | Traitement |
|---|---|---|---|
| INC-101 | Internet unavailable | High | traité |
| INC-102 | DNS failure | High | traité |
| INC-103 | Firewall block | High | traité |
| INC-104 | Account locked | High | traité |
| INC-105 | Domain join failure | Medium | queue |
| INC-106 | GPO not applied | Medium | queue |
| INC-107 | Slow workstation | Low | queue |
| INC-108 | Printer unavailable | Low | queue |
| INC-109 | Windows service stopped | Medium | queue |
| INC-110 | Finance share denied | High | traité |
| INC-111 | Multiple failed logins | Highest | escalade |
| INC-112 | Wazuh agent disconnected | High | escalade |

La priorité est basée sur l'impact, l'urgence et le service touché.

## INC-101 — Internet unavailable

Scope : W11-01.

Cause simulée : carte réseau désactivée.

Diagnostic : vérifier l'état de la carte avec Get-NetAdapter et tester la passerelle 10.10.10.1.

Correction : réactiver la carte réseau.

Validation : la carte revient à l'état Up et la passerelle répond.

## INC-102 — DNS failure

Scope : W11-01.

Cause simulée : mauvais serveur DNS sur le poste.

Diagnostic : vérifier la connectivité IP puis tester la résolution de DC01.corp.rktlab.test.

Correction : remettre DC01, 10.10.20.10, comme DNS principal.

Validation : la résolution DNS interne fonctionne de nouveau.

## INC-103 — Firewall block

Scope : W11-01 vers FS01.

Cause simulée : règle de pare-feu bloquant SMB vers FS01.

Diagnostic : tester le port TCP 445 vers 10.10.20.20 puis vérifier la règle de blocage.

Correction : retirer la règle de blocage.

Validation : le test TCP 445 vers FS01 fonctionne de nouveau.

## INC-104 — Account locked

Scope : compte Active Directory de test.

Cause simulée : seuil de verrouillage atteint après plusieurs mots de passe incorrects.

Diagnostic : rechercher les comptes verrouillés dans Active Directory.

Correction : déverrouiller le compte après vérification.

Validation : la propriété LockedOut revient à False.

## INC-110 — Finance share denied

Scope : accès Finance vers FS01.

Cause simulée : compte Finance absent du groupe GG_FINANCE_USERS.

Diagnostic : vérifier l'appartenance au groupe.

Correction : remettre le compte dans GG_FINANCE_USERS.

Validation : le compte apparaît de nouveau dans le groupe Finance.

## INC-111 — Multiple failed logins

Décision : escalade vers la sécurité.

Raison : plusieurs échecs de connexion demandent une corrélation des journaux et une vérification du compte avant de conclure à un incident.

Aucune attaque réelle n'est déclarée dans le lab.

## INC-112 — Wazuh agent disconnected

Décision : escalade vers réseau / sécurité.

Contexte : le Day 10 a montré que W11-01 ne valide pas encore la connexion TCP vers WAZUH01 sur le port 1514.

Les vérifications de base ont porté sur l'adresse de WAZUH01, la passerelle SECURITY, les règles pfSense et les ports Wazuh.

La suite demande une vérification plus poussée du chemin réseau et du service Wazuh.
