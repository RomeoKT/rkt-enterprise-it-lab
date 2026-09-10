# Day 03 — Dépannage pfSense

## Incident 1 — Résolution DNS impossible

### Symptôme

- connectivité IP fonctionnelle
- noms de domaine non résolus

### Cause

Un mauvais serveur DNS était configuré pendant les tests du Day 03.

### Correction

Le poste a été remis sur le DNS Resolver pfSense utilisé à cette étape :

```text
10.10.10.1
```

### Validation

```cmd
nslookup google.com
```

> Après le déploiement d'Active Directory au Day 04, les postes membres utilisent `DC01` (`10.10.20.10`) comme DNS principal.

---

## Incident 2 — Règle de pare-feu désactivée

### Symptôme

Le réseau USERS ne pouvait plus accéder à Internet.

### Diagnostic

Les journaux pfSense montraient du trafic bloqué.

![Journaux pfSense](../screenshots/day03-firewall-log.png)

### Cause

La règle autorisant le trafic Internet depuis USERS avait été désactivée.

### Correction

Réactiver la règle attendue.

### Validation

- trafic autorisé visible dans pfSense
- accès Internet rétabli

---

## Incident 3 — NAT sortant désactivé

### Symptôme

- passerelle locale accessible
- accès Internet impossible

### Cause

Les adresses privées internes n'étaient plus traduites vers l'interface WAN.

### Correction

Rétablir le NAT sortant automatique dans pfSense.

### Validation

L'accès Internet fonctionne de nouveau.

---

## Incident 4 — Mauvaise passerelle

### Symptôme

Le poste communiquait sur son réseau local, mais pas avec les réseaux distants.

### Cause

La passerelle par défaut du poste était incorrecte.

### Correction

```text
Passerelle : 10.10.10.1
```

### Validation

- passerelle accessible
- routage vers les réseaux autorisés fonctionnel

## Méthode retenue

```text
Configuration locale
↓
Passerelle
↓
DNS
↓
Routage
↓
Pare-feu
↓
NAT
↓
Journaux
↓
Validation
```
