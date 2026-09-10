# Day 05 — Dépannage Active Directory

## Incident 1 — GPO non appliquée

### Symptôme

La GPO attendue n'était pas appliquée à `W11-01`.

### Cause

`W11-01` avait été placé en dehors de l'OU `Laval\Computers`, où les GPO du poste étaient liées.

### Correction

Remettre `W11-01` dans l'OU appropriée.

### Validation

```cmd
gpupdate /force
gpresult /scope computer /r
```

---

## Incident 2 — Groupe de sécurité manquant

### Symptôme

Sarah Tremblay ne pouvait pas accéder aux ressources Finance.

### Cause

Le compte n'était plus membre de `GG_FINANCE_USERS`.

### Correction

```powershell
Add-ADGroupMember -Identity "GG_FINANCE_USERS" -Members "sarah.tremblay"
```

### Validation

```powershell
Get-ADGroupMember "GG_FINANCE_USERS"
```

Après une nouvelle ouverture de session, l'accès à `\\FS01\Finance` fonctionne.

---

## Incident 3 — Permissions NTFS incorrectes

### Symptôme

Un utilisateur Finance pouvait ouvrir le partage, mais ne pouvait pas modifier les fichiers comme prévu.

### Cause

`DL_FINANCE_RW` ne possédait plus les permissions NTFS nécessaires.

### Correction

```cmd
icacls "C:\Shares\Finance" /grant "CORP\DL_FINANCE_RW:(OI)(CI)(M)" /T
```

### Validation

```cmd
icacls "C:\Shares\Finance"
```

---

## Incident 4 — Lecteur réseau absent

### Symptôme

Le lecteur `F:` n'apparaissait pas pour Sarah Tremblay.

### Cause

Le ciblage de `GPO-Map-Drives` ne visait pas correctement `GG_FINANCE_USERS`.

### Correction

```text
Chemin : \\FS01\Finance
Lecteur : F:
Groupe : CORP\GG_FINANCE_USERS
```

### Validation

```cmd
gpupdate /force
gpresult /r
net use
```

## Leçon principale

Un problème d'accès Active Directory peut venir de plusieurs niveaux : emplacement dans l'OU, appartenance à un groupe, permissions NTFS ou ciblage d'une GPO.
