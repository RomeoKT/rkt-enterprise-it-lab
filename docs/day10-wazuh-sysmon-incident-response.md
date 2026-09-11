# Day 10 — Wazuh, Sysmon et réponse aux incidents

Le Day 10 devait relier `W11-01` à Wazuh, collecter des événements Windows/Sysmon et construire une petite investigation. L'installation de Wazuh a fonctionné, mais la communication entre l'agent Windows et `WAZUH01` n'a pas été finalisée dans le temps prévu.

Je garde quand même cette étape dans le projet, parce que le dépannage fait partie du lab et que je préfère montrer la limite plutôt que prétendre que tout a fonctionné.

## Ce qui a fonctionné

| Élément | Résultat |
|---|---|
| `WAZUH01` | installé sur Ubuntu 24.04 LTS |
| Adresse | `10.10.40.10/24` |
| Passerelle | `10.10.40.1` |
| Réseau | SECURITY |
| Wazuh Server / Indexer / Dashboard | installés |
| Dashboard | accessible depuis le poste hôte |

## Ce qui a bloqué

`W11-01` se trouvait sur USERS et `WAZUH01` sur SECURITY. Le test TCP de `W11-01` vers `10.10.40.10:1514` échouait, même si `WAZUH01` pouvait joindre sa propre passerelle.

J'ai vérifié les règles pfSense, le routage, les ports Wazuh et le pare-feu, mais la communication agent-manager n'a pas été validée.

Le détail est ici : [Day 10 — Dépannage de la connexion Wazuh](../troubleshooting/day10-wazuh-connectivity.md).

## Sysmon et événements étudiés

Je me suis concentré sur quelques Event IDs faciles à relier à une investigation :

| Source | Event ID | Signification |
|---|---:|---|
| Sysmon | `1` | création d'un processus |
| Sysmon | `3` | connexion réseau |
| Sysmon | `11` | création d'un fichier |
| Windows Security | `4624` | ouverture de session réussie |
| Windows Security | `4625` | ouverture de session échouée |
| Windows Security | `4720` | création d'un compte utilisateur |

La collecte centralisée de ces événements dans Wazuh n'est pas présentée comme réussie dans ce dépôt.

## Méthode d'analyse

Même sans la collecte complète, j'ai travaillé la logique d'une investigation simple : identifier la machine et le compte, remettre les événements dans l'ordre, vérifier ce qui se passe avant et après, déterminer si l'activité est normale ou suspecte, puis documenter les actions possibles.

Pour le scénario d'authentification, j'ai aussi étudié deux références MITRE ATT&CK : `T1136.001` pour la création d'un compte local et `T1078` pour l'utilisation de comptes valides.

Le rapport est ici : [IR-001 — Suspicious Authentication](../operations/incidents/IR-001-Suspicious-Authentication.md).

## Ce que je retiens

Un dashboard accessible ne veut pas dire que toute la chaîne de collecte fonctionne. Ce Day m'a forcé à séparer installation, réseau, service et collecte de logs au lieu de considérer Wazuh comme un seul bloc.

Il reste une vraie tâche à reprendre : faire fonctionner `W11-01` → agent Wazuh → `WAZUH01`, puis valider la remontée des événements avec des preuves réelles.
