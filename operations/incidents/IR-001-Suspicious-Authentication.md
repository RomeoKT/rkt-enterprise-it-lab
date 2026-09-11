# IR-001 — Authentification suspecte

Scénario prévu pour le Day 10. Il n'a pas été exécuté jusqu'au bout parce que W11-01 n'a pas réussi à envoyer ses événements vers WAZUH01.

Aucun événement ou horaire n'a été inventé.

## Séquence prévue

| Ordre | Événement | Source |
|---:|---|---|
| 1 | échec de connexion | Windows Event 4625 |
| 2 | échec de connexion | Windows Event 4625 |
| 3 | connexion réussie | Windows Event 4624 |
| 4 | compte local créé | Windows Event 4720 |
| 5 | processus créé | Sysmon Event 1 |
| 6 | connexion réseau | Sysmon Event 3 |
| 7 | fichier créé | Sysmon Event 11 |

Cette table décrit le scénario prévu, pas une timeline observée dans Wazuh.

## Systèmes

| Élément | Valeur |
|---|---|
| Endpoint | W11-01 |
| Réseau endpoint | USERS |
| Adresse utilisée pendant les tests | 10.10.10.50 |
| Serveur Wazuh | WAZUH01 |
| Adresse Wazuh | 10.10.40.10 |

## Faits confirmés

- Wazuh installé sur WAZUH01
- dashboard accessible depuis le poste hôte
- passerelle 10.10.40.1 joignable depuis WAZUH01
- test TCP de W11-01 vers 10.10.40.10:1514 en échec
- communication USERS vers SECURITY à corriger

## Analyse prévue

Questions principales :

- quel compte est concerné ?
- quelle machine ?
- quelle source ?
- une connexion a-t-elle réussi ?
- qu'est-ce qui s'est passé ensuite ?
- la création du compte était-elle autorisée ?

## Actions possibles

Si cette séquence apparaissait sans raison dans un vrai environnement :

- vérifier le compte créé
- vérifier les connexions réussies et échouées
- regarder les processus lancés ensuite
- vérifier les connexions réseau
- isoler le poste si nécessaire
- conserver les logs
- désactiver un compte non autorisé

## MITRE ATT&CK

- T1136.001 — Create Account: Local Account
- T1078 — Valid Accounts

## Limite

La chaîne W11-01 → Wazuh Agent → WAZUH01 n'a pas été validée. Ce fichier reste donc un scénario d'analyse documenté.