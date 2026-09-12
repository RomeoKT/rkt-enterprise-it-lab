# Day 11 — Journal d'incidents

## Incidents

| ID | Incident | Priorité | État |
|---|---|---|---|
| INC-101 | Internet unavailable | High | traité |
| INC-102 | DNS failure | High | traité |
| INC-103 | Firewall block | High | traité |
| INC-104 | Account locked | High | traité |
| INC-105 | Domain join failure | Medium | en attente |
| INC-106 | GPO not applied | Medium | en attente |
| INC-107 | Slow workstation | Low | en attente |
| INC-108 | Printer unavailable | Low | en attente |
| INC-109 | Windows service stopped | Medium | en attente |
| INC-110 | Finance share denied | High | traité |
| INC-111 | Multiple failed logins | Highest | escaladé |
| INC-112 | Wazuh agent disconnected | High | escaladé |

## INC-101 — Internet unavailable

- Poste : W11-01
- Cause : carte réseau désactivée
- Vérification : Get-NetAdapter et ping 10.10.10.1
- Correction : réactiver la carte
- Validation : carte Up et passerelle joignable

## INC-102 — DNS failure

- Poste : W11-01
- Cause : mauvais DNS
- Vérification : connectivité IP puis résolution de DC01.corp.rktlab.test
- Correction : remettre 10.10.20.10 comme DNS
- Validation : résolution interne OK

## INC-103 — Firewall block

- Trafic : W11-01 vers FS01
- Cause : règle bloquant SMB
- Vérification : TCP 445 vers 10.10.20.20
- Correction : retirer la règle de blocage
- Validation : TCP 445 OK

## INC-104 — Account locked

- Cible : compte AD de test
- Cause : seuil de verrouillage atteint
- Vérification : comptes verrouillés dans Active Directory
- Correction : déverrouiller le compte
- Validation : LockedOut = False

## INC-110 — Finance share denied

- Cible : accès Finance vers FS01
- Cause : compte absent de GG_FINANCE_USERS
- Vérification : appartenance au groupe
- Correction : remettre le compte dans GG_FINANCE_USERS
- Validation : compte présent dans le groupe

## INC-111 — Multiple failed logins

- État : escaladé vers sécurité
- Raison : vérifier les échecs de connexion et le compte avant de conclure

## INC-112 — Wazuh agent disconnected

- État : escaladé vers réseau / sécurité
- Contexte : TCP 1514 de W11-01 vers WAZUH01 non validé
- Vérifications déjà faites : IP, passerelle SECURITY, règles pfSense et ports Wazuh
