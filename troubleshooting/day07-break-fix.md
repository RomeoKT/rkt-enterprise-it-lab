# Day 07 — Dépannage Windows avec Process Monitor

## Scénario

Un utilisateur ne pouvait pas créer de fichier dans un dossier de test local. L'objectif était d'utiliser Process Monitor pour trouver l'opération refusée.

## Système concerné

| Élément | Valeur |
|---|---|
| Poste | `W11-01` |
| Domaine | `corp.rktlab.test` |
| Utilisateur | `CORP\sarah.tremblay` |
| Dossier | `C:\RKT-Day07\Restricted` |

## Symptôme

Sarah pouvait lire le dossier, mais pas créer ou modifier un fichier.

## Diagnostic avec Process Monitor

Filtres appliqués :

```text
Result is ACCESS DENIED
Path begins with C:\RKT-Day07\Restricted
```

Reproduction :

```powershell
New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt"
```

Process Monitor a montré une opération `ACCESS DENIED`.

## Cause

Le compte possédait uniquement les permissions `Read and Execute`. La permission `Modify` manquait.

## Correction

```cmd
icacls "C:\RKT-Day07\Restricted" /grant:r "CORP\sarah.tremblay:(OI)(CI)(M)"
```

> Cette permission directe sert uniquement au scénario local de dépannage. Les partages du Day 05 utilisent des groupes AGDLP.

## Validation

```powershell
New-Item -ItemType File -Path "C:\RKT-Day07\Restricted\sarah-test.txt" -Force
Get-Item "C:\RKT-Day07\Restricted\sarah-test.txt"
```

Le fichier est créé correctement après la correction.
