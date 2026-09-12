# Day 10 — Dépannage Wazuh

Le dashboard fonctionne. Le problème est la connexion entre W11-01 et WAZUH01.

## Machines

| Machine | Adresse | Réseau |
|---|---|---|
| W11-01 | 10.10.10.50 | USERS |
| WAZUH01 | 10.10.40.10 | SECURITY |
| pfSense | 10.10.10.1 / 10.10.40.1 | routage |

## Symptômes

Depuis W11-01 :

- ping vers 10.10.40.10 en échec
- Test-NetConnection 10.10.40.10 -Port 1514 = False

Depuis WAZUH01 :

- ens33 = 10.10.40.10/24
- passerelle 10.10.40.1 joignable

## Vérifications faites

- IP et route par défaut de WAZUH01
- passerelle SECURITY
- TCP 1514 depuis W11-01
- règles pfSense sur USERS
- ports 1514 et 1515
- pare-feu local

Un problème DNS local avec 127.0.0.53 a aussi été vu sur WAZUH01. C'est un problème séparé.

## Résultat

Connexion agent-manager non validée. Le dashboard reste accessible.

## À reprendre

1. vérifier les ports d'écoute Wazuh
2. regarder les logs pfSense pendant le test
3. vérifier l'ordre des règles USERS
4. vérifier le pare-feu Ubuntu
5. capturer le trafic si nécessaire
