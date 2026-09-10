# Day 02 — Dépannage réseau

## Incident 1 — Mauvaise passerelle

### Symptôme

- réseau local accessible
- accès Internet impossible

### Diagnostic

```cmd
ipconfig /all
ping 10.10.10.1
ping 1.1.1.1
route print
```

### Cause

La passerelle par défaut était incorrecte.

### Correction

```text
Passerelle : 10.10.10.1
```

### Validation

- passerelle joignable
- accès hors du réseau local rétabli

---

## Incident 2 — Mauvais masque de sous-réseau

### Symptôme

La communication avec la passerelle ne fonctionnait pas normalement.

### Diagnostic

```cmd
ipconfig /all
ping 10.10.10.1
route print
```

### Cause

Un masque `/30` plaçait le poste et la passerelle dans des sous-réseaux différents.

### Correction

```text
Masque : 255.255.255.0 (/24)
```

### Validation

- passerelle joignable
- routage normal

---

## Incident 3 — Mauvais serveur DNS

### Symptôme

- connectivité IP fonctionnelle
- résolution de noms impossible

### Diagnostic

```cmd
ping 1.1.1.1
ping google.com
nslookup google.com
ipconfig /all
```

### Cause

Le serveur DNS configuré n'était pas valide pour cette étape du laboratoire.

### Correction

Rétablir un serveur DNS valide.

> Après le déploiement d'Active Directory, le DNS des postes du domaine devient `DC01` (`10.10.20.10`).

---

## Incident 4 — Adresse IP dupliquée

### Symptôme

- connectivité instable
- conflit réseau

### Cause

Deux appareils utilisaient `10.10.10.1`.

### Correction

```text
W11-01 : 10.10.10.10
pfSense : 10.10.10.1
```

### Validation

La connectivité redevient stable.

---

## Incident 5 — Carte réseau désactivée

### Symptôme

Aucune connectivité réseau sur le poste.

### Diagnostic

```cmd
ncpa.cpl
ipconfig
ping 127.0.0.1
ping 10.10.10.1
```

### Cause

La carte réseau était désactivée dans Windows.

### Correction

Réactiver l'interface Ethernet.

### Validation

- l'interface apparaît dans `ipconfig`
- la passerelle est de nouveau joignable

## Leçon principale

Toujours vérifier l'interface, l'adresse IP, le masque, la passerelle et le DNS avant de modifier le pare-feu ou les services réseau.
