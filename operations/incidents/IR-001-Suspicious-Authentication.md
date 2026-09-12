# IR-001 — Authentification suspecte

Scénario du Day 10. Il n'a pas été terminé parce que W11-01 n'envoyait pas ses événements à WAZUH01.

## Séquence prévue

| Ordre | Événement | Source |
|---:|---|---|
| 1 | échec de connexion | Windows 4625 |
| 2 | échec de connexion | Windows 4625 |
| 3 | connexion réussie | Windows 4624 |
| 4 | compte local créé | Windows 4720 |
| 5 | processus créé | Sysmon 1 |
| 6 | connexion réseau | Sysmon 3 |
| 7 | fichier créé | Sysmon 11 |

## Systèmes

| Élément | Valeur |
|---|---|
| Poste | W11-01 |
| Réseau | USERS |
| Adresse pendant les tests | 10.10.10.50 |
| Serveur Wazuh | WAZUH01 |
| Adresse Wazuh | 10.10.40.10 |

## Faits confirmés

- Wazuh installé sur WAZUH01
- dashboard accessible
- passerelle 10.10.40.1 joignable depuis WAZUH01
- TCP 1514 de W11-01 vers WAZUH01 en échec

## Vérifications prévues

- compte concerné
- machine concernée
- source des événements
- ordre des connexions
- processus lancés ensuite
- connexions réseau

## Si l'activité est suspecte

- vérifier le compte créé
- vérifier les connexions réussies et échouées
- vérifier les processus et connexions réseau
- isoler le poste si nécessaire
- conserver les logs
- désactiver un compte non autorisé

## MITRE ATT&CK

- T1136.001 — Create Account: Local Account
- T1078 — Valid Accounts

Collecte Wazuh sur W11-01 : non validée.
