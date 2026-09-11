# Day 05 — Dépannage Active Directory

Quatre incidents ont été testés dans le lab.

## 1. GPO non appliquée

Problème : W11-01 était hors de l'OU Laval\Computers.

Correction : remettre le poste dans la bonne OU.

Validation :

- gpupdate /force
- gpresult /scope computer /r

## 2. Groupe Finance manquant

Problème : Sarah Tremblay n'était plus membre de GG_FINANCE_USERS.

Correction :

- Add-ADGroupMember -Identity "GG_FINANCE_USERS" -Members "sarah.tremblay"

Validation :

- Get-ADGroupMember "GG_FINANCE_USERS"
- nouvelle ouverture de session
- accès à \\FS01\Finance

## 3. Permissions NTFS incorrectes

Problème : DL_FINANCE_RW n'avait plus les permissions nécessaires.

Correction :

- icacls "C:\Shares\Finance" /grant "CORP\DL_FINANCE_RW:(OI)(CI)(M)" /T

Validation :

- icacls "C:\Shares\Finance"

## 4. Lecteur réseau absent

Problème : le ciblage de GPO-Map-Drives ne visait pas correctement GG_FINANCE_USERS.

Configuration attendue :

- chemin : \\FS01\Finance
- lecteur : F:
- groupe : CORP\GG_FINANCE_USERS

Validation :

- gpupdate /force
- gpresult /r
- net use