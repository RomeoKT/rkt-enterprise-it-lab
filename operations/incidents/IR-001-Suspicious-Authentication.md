# IR-001 — Authentification suspecte

Ce fichier documente le scénario d'analyse prévu pour le Day 10. Le scénario n'a pas été exécuté jusqu'au bout, car `W11-01` n'a pas réussi à envoyer ses événements vers `WAZUH01`.

Je garde donc ici uniquement ce qui est vérifié et la méthode que j'aurais utilisée pour l'analyse. Aucun événement ou horaire n'a été inventé.

## Contexte

Le scénario devait contenir plusieurs échecs de connexion, une connexion réussie, la création d'un compte local de test, puis de l'activité processus/réseau/fichier.

| Ordre prévu | Événement | Source |
|---:|---|---|
| 1 | échec de connexion | Windows Event `4625` |
| 2 | échec de connexion | Windows Event `4625` |
| 3 | connexion réussie | Windows Event `4624` |
| 4 | compte local créé | Windows Event `4720` |
| 5 | processus créé | Sysmon Event `1` |
| 6 | connexion réseau | Sysmon Event `3` |
| 7 | fichier créé | Sysmon Event `11` |

Cette table représente le scénario prévu, pas une timeline observée dans Wazuh.

## Systèmes concernés

| Élément | Valeur |
|---|---|
| Endpoint | `W11-01` |
| Réseau endpoint | USERS |
| Adresse utilisée pendant les tests | `10.10.10.50` |
| Serveur Wazuh | `WAZUH01` |
| Adresse Wazuh | `10.10.40.10` |

## Ce que j'ai pu confirmer

- Wazuh est installé sur `WAZUH01`
- le dashboard est accessible depuis le poste hôte
- `WAZUH01` rejoint sa passerelle `10.10.40.1`
- le test TCP de `W11-01` vers `10.10.40.10:1514` échoue
- la communication USERS → SECURITY reste à corriger

Je n'ai pas ajouté de captures Sysmon ou Windows Security puisque je n'ai pas obtenu ces preuves correctement.

## Comment j'aurais analysé la séquence

Une série d'échecs de connexion n'est pas suffisante à elle seule pour parler d'incident. Ce qui devient intéressant, c'est le contexte : est-ce qu'une connexion finit par réussir? Est-ce qu'un nouveau compte est créé juste après? Est-ce qu'un processus ou une connexion réseau inhabituelle suit?

Les questions principales auraient été : quel compte, quelle machine, quelle source, quelle heure, quelles actions avant/après et est-ce que l'activité était autorisée?

## Actions possibles si le scénario était réel

Si cette séquence apparaissait sans raison dans un environnement réel, je commencerais par vérifier le compte créé, les connexions réussies/échouées, les processus lancés ensuite et les connexions réseau associées. Si les indices devenaient sérieux, j'isolerais le poste, je préserverais les logs et je désactiverais un compte non autorisé avant de poursuivre l'analyse.

## MITRE ATT&CK

- `T1136.001 — Create Account: Local Account`
- `T1078 — Valid Accounts`

Ces références servent à classer un comportement. Elles ne prouvent pas qu'une action est malveillante sans le contexte autour.

## Limite du lab

La chaîne `W11-01` → Wazuh Agent → `WAZUH01` n'a pas été validée. Le rapport est donc un exercice d'analyse documenté, pas un rapport basé sur une collecte Wazuh complète.

Le point positif de ce Day est surtout la méthode : ne pas confondre installation du serveur, connectivité réseau et collecte réelle des événements.
