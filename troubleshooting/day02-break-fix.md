# Day 02 — Dépannage réseau

Cinq problèmes testés sur W11-01.

| Problème | Symptôme | Cause | Correction |
|---|---|---|---|
| Mauvaise passerelle | réseau local OK, Internet KO | passerelle incorrecte | remettre 10.10.10.1 |
| Mauvais masque | passerelle non joignable normalement | masque /30 | remettre 255.255.255.0 |
| Mauvais DNS | IP joignable, noms non résolus | DNS incorrect | remettre le bon DNS |
| IP dupliquée | connexion instable | deux appareils avec la même IP | remettre l'IP prévue |
| Carte désactivée | aucune connectivité | interface Ethernet désactivée | réactiver la carte |

## Commandes

- ipconfig /all
- ping 10.10.10.1
- ping 1.1.1.1
- ping google.com
- nslookup google.com
- route print
- arp -a
- ncpa.cpl

Après le Day 04, le DNS principal est DC01, 10.10.20.10.

Ordre : interface, IP, masque, passerelle, DNS, service.
