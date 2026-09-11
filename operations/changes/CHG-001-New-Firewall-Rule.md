# CHG-001 — Règle Wazuh

## Raison

Permettre à W11-01 de communiquer avec WAZUH01 pour l'agent Wazuh.

## État actuel

W11-01 est sur le réseau USERS.

WAZUH01 est sur le réseau SECURITY à l'adresse 10.10.40.10.

La connexion TCP vers le port 1514 n'a pas été validée pendant le Day 10.

## Changement prévu

Ajouter des règles pfSense limitées au trafic Wazuh.

Source : W11-01

Destination : 10.10.40.10

Ports : TCP 1514 et TCP 1515

Logs : activés

## Risque

Une règle trop large donnerait aux postes USERS un accès inutile au réseau SECURITY.

## Mise en place

1. Ouvrir pfSense.
2. Aller dans Firewall > Rules > USERS.
3. Ajouter une règle TCP vers 10.10.40.10 pour le port 1514.
4. Ajouter une règle TCP vers 10.10.40.10 pour le port 1515.
5. Activer les logs sur les deux règles.
6. Appliquer les changements.

## Validation

Depuis W11-01, tester :

- Test-NetConnection 10.10.40.10 -Port 1514
- Test-NetConnection 10.10.40.10 -Port 1515

Le changement est validé seulement si les connexions attendues fonctionnent.

## Retour arrière

Désactiver ou supprimer les deux nouvelles règles pfSense, puis appliquer la configuration.

## Preuve liée

Voir [Day 10 — Dépannage Wazuh](../../troubleshooting/day10-wazuh-connectivity.md).

## État

En attente de validation.
