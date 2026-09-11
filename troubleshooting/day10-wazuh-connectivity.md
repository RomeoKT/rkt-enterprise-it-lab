# Day 10 — Dépannage de la connexion Wazuh

Le problème du Day 10 n'était pas l'accès au dashboard. Le vrai blocage était la communication entre `W11-01` et le manager Wazuh.

## Situation

| Machine | Adresse | Réseau |
|---|---|---|
| `W11-01` | `10.10.10.50` | USERS |
| `WAZUH01` | `10.10.40.10` | SECURITY |
| pfSense | `10.10.10.1` / `10.10.40.1` | routage entre les deux zones |

Depuis `W11-01`, le ping vers `10.10.40.10` expirait et `Test-NetConnection 10.10.40.10 -Port 1514` retournait `TcpTestSucceeded : False`.

Du côté de `WAZUH01`, l'interface `ens33` avait bien `10.10.40.10/24` et la passerelle `10.10.40.1` répondait. Le serveur n'était donc pas simplement hors réseau.

## Ce que j'ai vérifié

1. adresse IP et route par défaut de `WAZUH01`
2. accès à la passerelle SECURITY
3. test TCP 1514 depuis `W11-01`
4. règles pfSense sur l'interface USERS
5. ports 1514/1515 prévus pour Wazuh
6. pare-feu local afin de ne pas confondre ICMP et trafic TCP Wazuh

Un problème DNS local avec `127.0.0.53` a aussi été observé sur `WAZUH01`. Je l'ai gardé séparé du problème USERS → SECURITY pour éviter de mélanger deux pannes différentes.

## Résultat

La communication agent-manager n'a pas été validée pendant le temps du Day 10. Le dashboard restait accessible depuis l'hôte, donc je n'ai pas considéré l'installation Wazuh entière comme défectueuse.

Le point à reprendre est le chemin réseau/service entre l'endpoint et le manager.

## Reprise prévue

La prochaine fois, je commencerai par confirmer que Wazuh écoute bien sur les ports attendus, puis je regarderai les logs pfSense pendant un test depuis `W11-01`. Ensuite : ordre des règles USERS, pare-feu Ubuntu et, si nécessaire, capture de paquets des deux côtés de pfSense.

## Ce que ce problème m'a appris

Un service Web accessible et un agent capable de joindre son manager sont deux validations différentes. Le dépannage est plus simple quand je teste chaque morceau de la chaîne séparément au lieu de conclure directement que « Wazuh ne marche pas ».
