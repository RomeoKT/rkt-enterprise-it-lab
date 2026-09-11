# Day 05 — GPO, services de fichiers et permissions

Le Day 05 est la partie Windows Server la plus complète du lab : `FS01`, partages SMB, groupes AGDLP, GPO, lecteurs réseau et Windows LAPS.

## FS01

| Paramètre | Valeur |
|---|---|
| Nom | `FS01` |
| IPv4 | `10.10.20.20` |
| Passerelle | `10.10.20.1` |
| DNS | `10.10.20.10` |
| Domaine | `corp.rktlab.test` |

Les principaux partages sont `\\FS01\Finance`, `\\FS01\HR`, `\\FS01\IT` et `\\FS01\Public`.

## Permissions avec AGDLP

Je n'ai pas donné les permissions directement aux utilisateurs. Le modèle utilisé est : **Account → Global Group → Domain Local Group → Permission**.

Exemple Finance : `Sarah Tremblay` → `GG_FINANCE_USERS` → `DL_FINANCE_RW` → `\\FS01\Finance`.

![Modèle de permissions AGDLP](../diagrams/ad-permission-model.png)

Ce modèle rend les accès plus faciles à suivre : les utilisateurs appartiennent aux groupes de leur département, puis les groupes locaux de domaine portent les permissions sur les ressources.

## GPO créées

- `GPO-Workstations-Security`
- `GPO-Map-Drives`
- `GPO-Screen-Lock`
- `GPO-Account-Lockout`
- `GPO-Windows-Firewall`

Pour vérifier l'application des stratégies, j'ai utilisé :

```cmd
gpupdate /force
gpresult /r
gpresult /h C:\gpresult.html
```

Le lecteur `F:` des utilisateurs Finance pointe vers `\\FS01\Finance` avec Group Policy Preferences et un ciblage par groupe de sécurité.

## Share vs NTFS

J'ai dû bien séparer les deux niveaux : les permissions de partage contrôlent l'accès SMB, tandis que les permissions NTFS contrôlent les dossiers et fichiers. Le résultat final dépend des deux.

## Windows LAPS

Windows LAPS a été configuré pour `W11-01` afin d'éviter de réutiliser le même mot de passe administrateur local. Aucun mot de passe LAPS n'est stocké dans ce dépôt.

## Break/fix

J'ai reproduit quatre problèmes : poste dans la mauvaise OU, utilisateur retiré de son groupe, permissions NTFS incorrectes et lecteur réseau absent à cause d'un mauvais ciblage GPO.

Les étapes de diagnostic sont dans [Day 05 — Dépannage Active Directory](../troubleshooting/day05-ad-break-fix.md).

## Ce que je retiens

La partie la plus importante n'était pas de créer les GPO ou les partages, mais de comprendre pourquoi un accès fonctionne ou non : OU, groupe, GPO, partage et NTFS peuvent tous intervenir dans le même problème.
