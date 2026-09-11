# Day 03 — Dépannage pfSense

Quatre problèmes ont été reproduits autour de pfSense.

| Problème | Symptôme | Cause | Correction |
|---|---|---|---|
| DNS | IP fonctionne, noms non résolus | mauvais DNS | remettre le DNS prévu |
| Règle pare-feu | USERS ne sort plus sur Internet | règle désactivée | réactiver la règle |
| NAT sortant | passerelle OK, Internet KO | NAT désactivé | remettre le NAT automatique |
| Passerelle | réseau local OK, réseaux distants KO | mauvaise passerelle | remettre 10.10.10.1 |

## Vérifications utiles

- nslookup google.com
- logs pfSense
- règles de l'interface USERS
- configuration NAT
- passerelle du poste

![Journaux pfSense](../screenshots/day03-firewall-log.png)

Après le Day 04, les postes du domaine utilisent DC01, 10.10.20.10, comme DNS principal.

## Ordre de vérification

Configuration locale → passerelle → DNS → routage → pare-feu → NAT → logs.