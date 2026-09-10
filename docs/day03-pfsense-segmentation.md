# Day 03 — Segmentation réseau avec pfSense

## Objectif

Utiliser pfSense comme pare-feu et routeur entre les différentes zones du laboratoire.

## Architecture

![Architecture réseau segmentée](../diagrams/architecture-v2-segmented.png)

## Réseaux

| Zone | Réseau | Passerelle |
|---|---|---|
| USERS | `10.10.10.0/24` | `10.10.10.1` |
| SERVERS | `10.10.20.0/24` | `10.10.20.1` |
| MGMT | `10.10.30.0/24` | `10.10.30.1` |
| SECURITY | `10.10.40.0/24` | `10.10.40.1` |

Ces zones sont réalisées avec des réseaux VMware host-only. Elles servent à reproduire une segmentation logique dans le laboratoire.

## Services pfSense

- DHCP sur le réseau USERS pendant les premiers tests
- DNS Resolver pendant les tests précédant Active Directory
- NAT sortant automatique
- routage entre les réseaux internes
- règles de pare-feu entre les zones

> À partir du déploiement d'Active Directory, `DC01` (`10.10.20.10`) devient le DNS principal des postes membres du domaine.

## Politique de filtrage

Principes appliqués :

- `USERS → Internet` : autorisé
- `USERS → SERVERS` : accès limité aux services nécessaires à Active Directory, DNS et SMB
- `USERS → MGMT` : bloqué
- `MGMT → réseaux internes` : accès d'administration autorisé selon le besoin
- trafic non autorisé : bloqué

Cette approche applique le principe du moindre privilège sans empêcher les services nécessaires au fonctionnement du domaine.

## Validation

Les règles et journaux pfSense ont été vérifiés directement dans l'interface Web.

![Règles pfSense](../screenshots/day03-firewall-rules.png)

![Journaux du pare-feu](../screenshots/day03-firewall-log.png)

![DNS Resolver](../screenshots/day03-dns-resolver.png)

Les validations réseau ont aussi utilisé des tests comme :

```powershell
ping 10.10.10.1
Test-NetConnection 10.10.20.10 -Port 53
Test-NetConnection 10.10.20.20 -Port 445
```

## Dépannage

Les problèmes suivants ont été volontairement reproduits :

- mauvais serveur DNS
- règle de pare-feu désactivée
- NAT sortant désactivé
- mauvaise passerelle

Voir [Day 03 — Dépannage pfSense](../troubleshooting/day03-pfsense-break-fix.md).

## Ce que j'ai appris

Cette étape m'a permis de comprendre le lien entre routage, règles de pare-feu, NAT et journaux réseau. Une route valide ne signifie pas automatiquement qu'un trafic est autorisé.
