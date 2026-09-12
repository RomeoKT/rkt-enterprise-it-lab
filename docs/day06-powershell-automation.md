# Day 06 — PowerShell

Quatre scripts pour automatiser des tâches du lab.

## Fichiers

- [New-RKTUsers.ps1](../scripts/New-RKTUsers.ps1)
- [Disable-RKTUser.ps1](../scripts/Disable-RKTUser.ps1)
- [Get-RKTInventory.ps1](../scripts/Get-RKTInventory.ps1)
- [Test-RKTNetwork.ps1](../scripts/Test-RKTNetwork.ps1)
- [users.csv](../configs/users.csv)

## New-RKTUsers.ps1

Crée les utilisateurs AD depuis users.csv, choisit l'OU du département et ajoute le compte au bon groupe.

## Disable-RKTUser.ps1

Désactive un compte, retire ses groupes de département et déplace l'utilisateur vers Disabled-Accounts.

## Get-RKTInventory.ps1

Récupère le système, la mémoire, les adresses IPv4, le disque et l'utilisateur connecté. Le résultat est exporté en CSV.

## Test-RKTNetwork.ps1

Teste la passerelle, DC01, FS01, le DNS, Internet en TCP 443, DNS en TCP 53 et SMB en TCP 445.

Les statuts sortent en OK ou FAIL.

Get-RKTInventory.ps1 et Test-RKTNetwork.ps1 exportent leurs résultats dans C:\RKTLogs.
