# Day 03 — pfSense et segmentation

pfSense sert de routeur et de pare-feu entre les réseaux du lab.

![Architecture réseau segmentée](../diagrams/architecture-v2-segmented.png)

## Réseaux

| Zone | Réseau | Passerelle |
|---|---|---|
| USERS | 10.10.10.0/24 | 10.10.10.1 |
| SERVERS | 10.10.20.0/24 | 10.10.20.1 |
| MGMT | 10.10.30.0/24 | 10.10.30.1 |
| SECURITY | 10.10.40.0/24 | 10.10.40.1 |

## Configuration faite

- interfaces internes et WAN
- routage inter-réseaux
- NAT sortant
- règles de pare-feu
- DHCP sur USERS pendant les premiers tests
- DNS Resolver avant le déploiement d'Active Directory

À partir du Day 04, DC01 devient le DNS principal des postes du domaine.

## Filtrage

USERS peut sortir vers Internet et joindre les services nécessaires sur SERVERS. L'accès USERS vers MGMT reste bloqué. MGMT garde les accès d'administration utiles.

## Validation

![Règles pfSense](../screenshots/day03-firewall-rules.png)

![Journaux du pare-feu](../screenshots/day03-firewall-log.png)

![DNS Resolver](../screenshots/day03-dns-resolver.png)

Tests utilisés :

- ping 10.10.10.1
- Test-NetConnection 10.10.20.10 -Port 53
- Test-NetConnection 10.10.20.20 -Port 445

## Break/fix

Tests avec mauvais DNS, règle désactivée, NAT sortant désactivé et mauvaise passerelle.

Voir [Day 03 — Dépannage pfSense](../troubleshooting/day03-pfsense-break-fix.md).