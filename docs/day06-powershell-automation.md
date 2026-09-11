# Day 06 — PowerShell

Quatre scripts ont été ajoutés pour automatiser des tâches du lab.

## Fichiers

- [New-RKTUsers.ps1](../scripts/New-RKTUsers.ps1)
- [Disable-RKTUser.ps1](../scripts/Disable-RKTUser.ps1)
- [Get-RKTInventory.ps1](../scripts/Get-RKTInventory.ps1)
- [Test-RKTNetwork.ps1](../scripts/Test-RKTNetwork.ps1)
- [users.csv](../configs/users.csv)

## New-RKTUsers.ps1

Crée des utilisateurs Active Directory depuis users.csv, choisit l'OU du département et ajoute le compte au bon groupe.

Le mot de passe temporaire est demandé pendant l'exécution et n'est pas enregistré dans le dépôt.

## Disable-RKTUser.ps1

Désactive un compte, retire les groupes du département, déplace l'utilisateur vers Disabled-Accounts et écrit un journal.

## Get-RKTInventory.ps1

Récupère le système, la mémoire, les adresses IPv4, le stockage, l'utilisateur connecté et la date de collecte.

## Test-RKTNetwork.ps1

Teste la passerelle, le DNS interne, DC01, FS01, Internet en TCP 443, DNS en TCP 53 et SMB en TCP 445.

Les résultats sortent en PASS ou FAIL.

## Gestion des erreurs

Les scripts utilisent try/catch et des vérifications simples avant les actions importantes.

Les journaux sont enregistrés dans C:\RKTLogs.