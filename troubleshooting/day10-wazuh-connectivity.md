# Day 10 — Dépannage de la connexion Wazuh

## Problème

`W11-01` ne réussissait pas à joindre `WAZUH01` sur les ports utilisés par l'agent Wazuh.

## Environnement

| Machine | Adresse | Réseau |
|---|---|---|
| `W11-01` | `10.10.10.50` | USERS |
| `WAZUH01` | `10.10.40.10` | SECURITY |
| pfSense | `10.10.10.1` / `10.10.40.1` | routage entre les deux réseaux |

## Symptômes observés

Depuis `W11-01` :

- le ping vers `10.10.40.10` expirait
- `Test-NetConnection 10.10.40.10 -Port 1514` retournait `TcpTestSucceeded : False`

Depuis `WAZUH01` :

- l'interface `ens33` avait bien l'adresse `10.10.40.10/24`
- la passerelle `10.10.40.1` répondait au ping
- le ping vers `10.10.10.50` expirait

Un autre problème DNS local a aussi été observé sur `WAZUH01` avec le résolveur `127.0.0.53`. Ce problème a été traité comme un point séparé du problème de communication inter-réseaux.

## Vérifications faites

1. vérification de l'adresse IP et de la route par défaut de `WAZUH01`
2. test de la passerelle SECURITY `10.10.40.1`
3. test TCP depuis `W11-01` vers `10.10.40.10:1514`
4. vérification des règles pfSense sur l'interface USERS
5. préparation de règles pour autoriser TCP `1514` et `1515` vers `WAZUH01`
6. vérification du pare-feu Windows pour ne pas confondre le test ICMP avec le trafic Wazuh

## Résultat

La communication entre `W11-01` et `WAZUH01` n'a pas été validée pendant le temps prévu pour le Day 10.

Le dashboard Wazuh restait accessible depuis le poste hôte, ce qui confirmait que l'installation de base de Wazuh fonctionnait. Le problème était donc traité comme un problème de chemin réseau ou de service entre l'endpoint et le serveur, et non comme une preuve que toute l'installation Wazuh était défectueuse.

## Ce qui reste à vérifier

Pour reprendre ce dépannage plus tard, l'ordre logique est :

1. confirmer que le manager écoute sur TCP `1514` et `1515`
2. vérifier les logs pfSense pendant un test depuis `W11-01`
3. confirmer l'ordre des règles USERS vers SECURITY
4. vérifier le pare-feu Ubuntu
5. faire une capture de paquets sur les interfaces USERS et SECURITY si le problème persiste

## Leçon retenue

Le test du dashboard et le test de l'agent sont deux choses différentes. Un dashboard accessible ne prouve pas que le chemin `W11-01` → `WAZUH01` fonctionne.

Le problème n'a pas été masqué dans le portfolio : l'intégration de l'agent est indiquée comme non terminée.
