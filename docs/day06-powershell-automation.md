# Day 06 — Automatisation PowerShell

## Objectif

Automatiser des tâches répétitives d'administration Active Directory et de diagnostic avec PowerShell.

## Fichiers

- [`configs/users.csv`](../configs/users.csv)
- [`scripts/New-RKTUsers.ps1`](../scripts/New-RKTUsers.ps1)
- [`scripts/Disable-RKTUser.ps1`](../scripts/Disable-RKTUser.ps1)
- [`scripts/Get-RKTInventory.ps1`](../scripts/Get-RKTInventory.ps1)
- [`scripts/Test-RKTNetwork.ps1`](../scripts/Test-RKTNetwork.ps1)

## 1. Création automatisée d'utilisateurs

`New-RKTUsers.ps1` lit le fichier `configs/users.csv`.

Colonnes utilisées : `FirstName`, `LastName`, `Department`, `Location` et `Title`.

Pour chaque entrée valide, le script :

1. vérifie les champs obligatoires
2. génère un nom d'utilisateur au format `prenom.nom`
3. vérifie l'OU du département
4. vérifie le groupe global du département
5. crée le compte Active Directory
6. ajoute l'utilisateur au groupe approprié
7. demande un mot de passe temporaire de façon sécurisée
8. force le changement du mot de passe à la prochaine ouverture de session
9. écrit le résultat dans un journal

Les comptes déjà existants sont ignorés proprement au lieu d'arrêter tout le traitement.

## 2. Désactivation d'un utilisateur

`Disable-RKTUser.ps1` :

- recherche le compte
- désactive le compte Active Directory
- retire les groupes départementaux
- déplace le compte vers `Disabled-Accounts`
- journalise les actions

## 3. Inventaire d'un poste

`Get-RKTInventory.ps1` collecte notamment :

- nom du poste
- système d'exploitation
- version
- mémoire RAM
- adresses IPv4
- taille et espace libre du disque `C:`
- utilisateur connecté
- date de collecte

Le résultat est affiché dans PowerShell et exporté au format CSV.

## 4. Validation réseau

`Test-RKTNetwork.ps1` vérifie :

- passerelle
- résolution DNS interne
- connectivité vers `DC01`
- connectivité vers `FS01`
- accès Internet en TCP 443
- DNS en TCP 53
- SMB en TCP 445

Les résultats sont retournés avec un statut `PASS` ou `FAIL` et exportés en CSV.

## Gestion des erreurs

Les scripts utilisent notamment :

```powershell
try {
    # Opération
}
catch {
    # Journaliser l'erreur
}
```

Des validations sont faites avant plusieurs opérations afin d'éviter des erreurs simples, par exemple :

- fichier CSV absent
- colonne CSV manquante
- utilisateur déjà existant
- OU inexistante
- groupe Active Directory inexistant
- service réseau inaccessible

## Journalisation

Les fichiers de log sont enregistrés dans `C:\RKTLogs`.

Aucun mot de passe n'est stocké dans le dépôt.

## Ce que j'ai appris

Cette étape m'a permis de pratiquer les objets PowerShell, les propriétés, les pipelines, les variables, les fonctions, le traitement CSV, `try/catch`, la journalisation et l'automatisation de tâches Active Directory.
