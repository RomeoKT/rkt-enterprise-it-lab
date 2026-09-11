# Day 06 — PowerShell pour l'administration

À ce point du lab, j'avais déjà assez de tâches répétitives pour que l'automatisation devienne utile. J'ai donc écrit quatre scripts orientés administration et dépannage.

## Fichiers

- [`New-RKTUsers.ps1`](../scripts/New-RKTUsers.ps1)
- [`Disable-RKTUser.ps1`](../scripts/Disable-RKTUser.ps1)
- [`Get-RKTInventory.ps1`](../scripts/Get-RKTInventory.ps1)
- [`Test-RKTNetwork.ps1`](../scripts/Test-RKTNetwork.ps1)
- [`users.csv`](../configs/users.csv)

## `New-RKTUsers.ps1`

Le script lit `configs/users.csv`, vérifie les champs nécessaires, construit le nom d'utilisateur au format `prenom.nom`, choisit l'OU du département et ajoute le compte au bon groupe global.

Le mot de passe temporaire est demandé de façon sécurisée et n'est jamais enregistré dans le dépôt. Les comptes déjà présents sont ignorés proprement au lieu de faire échouer tout le traitement.

## `Disable-RKTUser.ps1`

Ce script sert à traiter le départ d'un utilisateur : recherche du compte, désactivation, retrait des groupes départementaux, déplacement vers `Disabled-Accounts` et journalisation.

## `Get-RKTInventory.ps1`

Il récupère les informations utiles d'un poste Windows : OS, version, mémoire, IPv4, stockage, utilisateur connecté et date de collecte. Le résultat peut être affiché et exporté en CSV.

## `Test-RKTNetwork.ps1`

C'est le script le plus orienté dépannage. Il vérifie la passerelle, le DNS interne, `DC01`, `FS01`, Internet en TCP 443, DNS en TCP 53 et SMB en TCP 445. Chaque test ressort en `PASS` ou `FAIL`.

## Gestion des erreurs

J'ai utilisé `try/catch` et plusieurs validations avant les actions importantes : fichier CSV absent, colonne manquante, utilisateur déjà existant, OU inexistante, groupe absent ou service réseau inaccessible.

Les journaux sont écrits sous `C:\RKTLogs`.

## Pourquoi je garde ces scripts dans le portfolio

Ils montrent mieux mon niveau PowerShell qu'une liste de cmdlets apprises par coeur. Chaque script répond à un besoin réel du lab et peut être relu séparément dans le dossier [`scripts/`](../scripts/).
