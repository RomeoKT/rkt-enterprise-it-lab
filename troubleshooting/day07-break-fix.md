# Day 07 — Dépannage Windows avec Process Monitor

## Scénario

Sarah pouvait lire C:\RKT-Day07\Restricted mais ne pouvait pas créer ou modifier un fichier.

## Environnement

| Élément | Valeur |
|---|---|
| Poste | W11-01 |
| Domaine | corp.rktlab.test |
| Utilisateur | CORP\sarah.tremblay |
| Dossier | C:\RKT-Day07\Restricted |

## Diagnostic

Filtres Process Monitor :

- Result is ACCESS DENIED
- Path begins with C:\RKT-Day07\Restricted

Commande utilisée pour reproduire le problème :

- New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt"

Process Monitor a montré l'opération refusée.

## Cause

Le compte avait Read and Execute, mais pas Modify.

## Correction

- icacls "C:\RKT-Day07\Restricted" /grant:r "CORP\sarah.tremblay:(OI)(CI)(M)"

Cette permission directe sert seulement au scénario local. Les partages du Day 05 utilisent AGDLP.

## Validation

- New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt" -Force
- Get-Item "C:\RKT-Day07\Restricted\sarah-test.txt"

Le fichier peut ensuite être créé normalement.