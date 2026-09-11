# Day 10 — Dépannage de la connexion Wazuh

Le dashboard Wazuh fonctionnait. Le problème était la communication entre W11-01 et WAZUH01.

## Environnement

| Machine | Adresse | Réseau |
|---|---|---|
| W11-01 | 10.10.10.50 | USERS |
| WAZUH01 | 10.10.40.10 | SECURITY |
| pfSense | 10.10.10.1 / 10.10.40.1 | routage entre les zones |

## Symptômes

Depuis W11-01 :

- ping vers 10.10.40.10 en échec
- Test-NetConnection 10.10.40.10 -Port 1514 retourne False

Depuis WAZUH01 :

- interface ens33 sur 10.10.40.10/24
- passerelle 10.10.40.1 joignable

## Vérifications faites

- adresse IP et route par défaut de WAZUH01
- passerelle SECURITY
- test TCP 1514 depuis W11-01
- règles pfSense sur USERS
- ports 1514 et 1515
- pare-feu local

Un problème DNS local avec 127.0.0.53 a aussi été vu sur WAZUH01. Il a été gardé séparé du problème USERS vers SECURITY.

## Résultat

La communication agent-manager n'a pas été validée pendant le Day 10.

Le dashboard restait accessible depuis l'hôte, donc l'installation Wazuh de base fonctionnait.

## À reprendre

1. confirmer que Wazuh écoute sur les ports attendus
2. regarder les logs pfSense pendant un test depuis W11-01
3. vérifier l'ordre des règles USERS
4. vérifier le pare-feu Ubuntu
5. faire une capture de paquets si nécessaire