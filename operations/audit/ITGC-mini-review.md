# Mini revue ITGC

## Gestion des accès

Preuves :

- groupes Active Directory utilisés pour les accès
- modèle AGDLP pour les partages
- Windows LAPS configuré sur W11-01

Faiblesse :

Aucun processus formel d'approbation des accès dans le lab.

Amélioration :

Ajouter une demande d'accès simple avec validation avant modification des groupes.

## Gestion des changements

Preuve :

CHG-001 documente un changement de pare-feu avec validation et retour arrière.

Faiblesse :

Aucune approbation formelle ou fenêtre de maintenance.

Amélioration :

Valider les changements importants avant application.

## Logs et monitoring

Preuves :

- logs pfSense disponibles
- Wazuh installé
- dashboard Wazuh accessible

Faiblesse :

W11-01 n'envoie pas encore ses événements vers WAZUH01.

Amélioration :

Corriger la communication agent-manager et valider la collecte Windows.

## Sauvegarde et récupération

Preuve :

Aucun test complet de sauvegarde et restauration n'a encore été validé dans ce projet.

Faiblesse :

La récupération de DC01 et FS01 n'a pas été testée.

Amélioration :

Préparer une sauvegarde de DC01 et FS01 puis tester une restauration.
