# IR-001 — Suspicious Authentication

## Statut

**Scénario documenté, non exécuté complètement.**

Le serveur Wazuh a été installé et son dashboard est accessible. La connexion de `W11-01` comme agent Wazuh n'a pas été finalisée, donc aucun événement Windows ou Sysmon n'est présenté ici comme ayant été centralisé dans Wazuh.

## Executive Summary

Ce scénario avait pour but d'analyser une suite d'événements simples sur un poste Windows : plusieurs échecs de connexion, une connexion réussie, la création d'un compte local, le lancement d'un processus et une connexion réseau.

Le scénario reste volontairement bénin. Aucun malware n'a été utilisé.

Comme la collecte de `W11-01` dans Wazuh n'a pas été validée, le rapport décrit la méthode d'analyse prévue sans inventer de timeline ou de preuves.

## Timeline

Aucune timeline réelle n'est publiée pour ce scénario.

La séquence qui devait être analysée était :

| Ordre | Événement | Source prévue |
|---|---|---|
| 1 | échec d'ouverture de session | Windows Event `4625` |
| 2 | échec d'ouverture de session | Windows Event `4625` |
| 3 | ouverture de session réussie | Windows Event `4624` |
| 4 | création d'un compte local de test | Windows Event `4720` |
| 5 | création d'un processus | Sysmon Event `1` |
| 6 | connexion réseau | Sysmon Event `3` |
| 7 | création d'un fichier | Sysmon Event `11` |

Ces lignes représentent le scénario prévu, pas des événements observés dans Wazuh.

## Affected Asset

| Élément | Valeur |
|---|---|
| Poste | `W11-01` |
| Réseau | USERS |
| Adresse observée pendant le dépannage | `10.10.10.50` |
| Serveur de supervision | `WAZUH01` |
| Adresse Wazuh | `10.10.40.10` |

## Evidence

Les preuves réelles disponibles pour le Day 10 sont les suivantes :

- Wazuh installé sur `WAZUH01`
- dashboard Wazuh accessible depuis le poste hôte
- passerelle SECURITY `10.10.40.1` joignable depuis `WAZUH01`
- test TCP `W11-01` vers `10.10.40.10:1514` en échec
- problème de communication entre les réseaux USERS et SECURITY documenté séparément

Aucune capture `day10-security-events.png` ou `day10-sysmon-events.png` n'est incluse, car ces preuves n'ont pas été obtenues correctement.

## Analysis

Dans un environnement réel, plusieurs échecs de connexion suivis d'une connexion réussie et de la création d'un nouveau compte peuvent justifier une investigation.

L'analyse devrait répondre à ces questions :

- quel compte est concerné ?
- quelle machine a généré les événements ?
- quelle est la source des tentatives ?
- une connexion a-t-elle finalement réussi ?
- qu'est-ce qui s'est produit après la connexion ?
- la création du compte était-elle autorisée ?
- des processus ou connexions réseau inhabituels sont-ils apparus ?

Dans ce lab, ces questions ont été étudiées comme méthode de travail. Elles ne sont pas présentées comme des conclusions issues de Wazuh.

## Scope

Le scénario était limité à `W11-01` dans le laboratoire `corp.rktlab.test`.

Aucune autre machine n'est considérée comme touchée dans ce rapport.

## Containment Recommendation

Si une séquence similaire était inattendue dans un vrai environnement, les premières actions seraient :

- vérifier si le compte créé est autorisé
- désactiver un compte non autorisé
- examiner les connexions réussies et échouées
- vérifier les processus lancés après la connexion
- vérifier les connexions réseau associées
- isoler le poste si des signes de compromission apparaissent
- conserver les journaux utiles avant de faire des changements importants

## Recovery

Après validation de l'incident, il faudrait :

- supprimer les comptes de test ou non autorisés
- rétablir les accès nécessaires
- vérifier que le poste fonctionne normalement
- confirmer que la supervision est de nouveau disponible
- documenter les actions réalisées

## MITRE Mapping

### T1136.001 — Create Account: Local Account

Cette technique correspond à la création d'un compte local. Dans un vrai incident, un attaquant pourrait utiliser cette méthode pour conserver un accès.

### T1078 — Valid Accounts

Cette technique concerne l'utilisation de comptes valides. Une connexion réussie après plusieurs échecs peut devenir intéressante lorsqu'elle est liée à d'autres événements.

Ces références servent à comprendre le scénario. Elles ne prouvent pas à elles seules qu'une activité est malveillante.

## Lessons Learned

- une installation Wazuh fonctionnelle ne garantit pas que tous les endpoints peuvent joindre le manager
- il faut séparer les problèmes réseau des problèmes d'application
- une timeline doit être basée sur des événements réellement observés
- plusieurs événements simples peuvent devenir importants lorsqu'ils sont liés entre eux
- il vaut mieux documenter une limite que publier une preuve inventée

## Lab Limitation

La partie `W11-01` → Wazuh Agent → `WAZUH01` n'a pas été validée pendant le Day 10.

Les captures Sysmon et Windows Security prévues n'ont pas été obtenues correctement et sont volontairement absentes du dépôt.

Ce rapport est donc un scénario d'analyse documenté et non un rapport basé sur une collecte Wazuh complète.
