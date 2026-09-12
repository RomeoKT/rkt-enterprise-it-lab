# Day 03 — Dépannage pfSense

Quatre problèmes testés autour de pfSense.

| Problème | Symptôme | Cause | Correction |
|---|---|---|---|
| DNS | IP fonctionne, noms non résolus | mauvais DNS | remettre le DNS prévu |
| Règle pare-feu | USERS ne sort plus sur Internet | règle désactivée | réactiver la règle |
| NAT sortant | passerelle OK, Internet KO | NAT désactivé | remettre le NAT automatique |
| Passerelle | réseau local OK, réseaux distants KO | mauvaise passerelle | remettre 10.10.10.1 |

## Vérifications

- nslookup google.com
- logs pfSense
- règles USERS
- NAT
- passerelle du poste

![Logs pfSense](../screenshots/day03-firewall-log.png)

Après le Day 04, le DNS principal est DC01, 10.10.20.10.

Ordre : poste, passerelle, DNS, routage, pare-feu, NAT, logs.
