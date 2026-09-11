# Day 02 — Dépannage réseau

Cinq problèmes simples ont été reproduits sur W11-01.

| Problème | Symptôme | Cause | Correction |
|---|---|---|---|
| Mauvaise passerelle | réseau local OK, Internet KO | passerelle incorrecte | remettre 10.10.10.1 |
| Mauvais masque | passerelle non joignable normalement | masque /30 | remettre 255.255.255.0 |
| Mauvais DNS | IP joignable, noms non résolus | DNS incorrect | remettre un DNS valide |
| IP dupliquée | connexion instable | deux appareils avec 10.10.10.1 | remettre W11-01 sur 10.10.10.10 |
| Carte désactivée | aucune connectivité | interface Ethernet désactivée | réactiver la carte |

## Commandes utilisées

- ipconfig /all
- ping 10.10.10.1
- ping 1.1.1.1
- ping google.com
- nslookup google.com
- route print
- ncpa.cpl

Après le Day 04, le DNS principal des postes du domaine est DC01, 10.10.20.10.

## Ordre de vérification

Interface → adresse IP → masque → passerelle → DNS → service demandé.