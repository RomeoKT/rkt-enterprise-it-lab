# Day 10 — Wazuh, Sysmon et réponse aux incidents

## Statut

**Lab partiel documenté.** Wazuh a été installé sur `WAZUH01` et le dashboard est accessible depuis le poste hôte. La connexion de `W11-01` comme agent Wazuh n'a pas été finalisée.

Aucune capture Sysmon ou Windows Security n'est ajoutée pour cette étape, car ces preuves n'ont pas été obtenues correctement. Le dépôt ne présente donc pas ces éléments comme réalisés.

## Objectif

Découvrir une méthode simple de supervision de sécurité et comprendre comment des événements Windows peuvent être utilisés pendant une investigation.

## WAZUH01

| Paramètre | Valeur |
|---|---|
| Nom | `WAZUH01` |
| Système | Ubuntu 24.04 LTS |
| Adresse IP | `10.10.40.10/24` |
| Passerelle | `10.10.40.1` |
| Réseau | SECURITY |
| Rôle | Wazuh Server, Indexer et Dashboard |

Le dashboard Wazuh a été installé et ouvert depuis le poste hôte.

## Architecture prévue

Le fonctionnement prévu était : `W11-01` → Wazuh Agent → `WAZUH01`.

L'agent devait envoyer les événements Windows et Sysmon vers Wazuh. Cette partie n'a pas été validée à cause d'un problème de communication entre les réseaux USERS et SECURITY.

Voir [Day 10 — Dépannage de la connexion Wazuh](../troubleshooting/day10-wazuh-connectivity.md).

## Sysmon

Sysmon a été étudié pour comprendre les événements Windows plus détaillés utiles en sécurité.

| Event ID Sysmon | Utilité |
|---|---|
| `1` | création d'un processus |
| `3` | connexion réseau |
| `11` | création d'un fichier |

Ces événements auraient dû être collectés par l'agent Wazuh après validation de la connexion. Cette collecte n'est pas présentée comme réussie dans ce dépôt.

## Événements Windows étudiés

| Event ID Windows | Signification |
|---|---|
| `4624` | ouverture de session réussie |
| `4625` | ouverture de session échouée |
| `4720` | création d'un compte utilisateur |

L'objectif était de comprendre comment plusieurs événements simples peuvent être mis dans le bon ordre pour analyser une activité.

## Méthode de réponse aux incidents

La méthode retenue est :

1. identifier l'événement ou le problème
2. récupérer les preuves disponibles
3. construire une chronologie
4. déterminer le compte et la machine concernés
5. vérifier ce qui s'est passé avant et après
6. déterminer si l'activité est normale ou suspecte
7. définir les actions de confinement si nécessaire
8. documenter le résultat

## MITRE ATT&CK

Deux références ont été étudiées pour le scénario :

- `T1136.001 — Create Account: Local Account`
- `T1078 — Valid Accounts`

Le fait qu'une action corresponde à une technique MITRE ATT&CK ne veut pas dire qu'elle est automatiquement malveillante. Le contexte reste nécessaire.

## Rapport d'incident

Le scénario d'investigation est documenté dans [IR-001 — Suspicious Authentication](../operations/incidents/IR-001-Suspicious-Authentication.md).

Ce rapport indique clairement que la centralisation des événements de `W11-01` dans Wazuh n'a pas été validée. Aucun horaire ou événement n'a été inventé pour compléter le laboratoire.

## Ce que j'ai appris

Cette étape m'a permis de comprendre le rôle général de Wazuh, la différence entre un problème d'installation et un problème de communication réseau, les principaux événements Windows/Sysmon utiles à une investigation et l'importance de documenter les limites d'un lab au lieu de présenter des résultats non vérifiés.
