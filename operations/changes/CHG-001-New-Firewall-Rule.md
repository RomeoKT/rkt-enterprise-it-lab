# CHG-001 — Accès Wazuh

## Raison

Permettre à W11-01 de joindre WAZUH01 pour l'agent Wazuh.

## Changement

Sur pfSense, ajouter deux règles limitées à :

- source : W11-01
- destination : 10.10.40.10
- TCP 1514
- TCP 1515
- logs activés

## Risque

Une règle trop large ouvrirait un accès inutile entre USERS et SECURITY.

## Étapes

1. Firewall > Rules > USERS
2. Ajouter TCP 1514 vers 10.10.40.10
3. Ajouter TCP 1515 vers 10.10.40.10
4. Activer les logs
5. Appliquer les règles

## Test

Depuis W11-01 :

- Test-NetConnection 10.10.40.10 -Port 1514
- Test-NetConnection 10.10.40.10 -Port 1515

## Retour arrière

Supprimer ou désactiver les deux règles puis appliquer la configuration.

Voir [le dépannage du Day 10](../../troubleshooting/day10-wazuh-connectivity.md).

## État

À valider.
