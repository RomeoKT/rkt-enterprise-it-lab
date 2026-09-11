# KB-002 — Diagnostiquer un problème d'accès Internet

## Symptôme

Le poste ne peut pas accéder à Internet.

## Vérifications

1. Configuration IP
   - ipconfig /all
   - réseau attendu : 10.10.10.0/24
   - passerelle : 10.10.10.1
   - DNS du domaine : 10.10.20.10

2. Passerelle
   - ping 10.10.10.1

3. DNS
   - Test-NetConnection 10.10.20.10 -Port 53
   - Resolve-DnsName DC01.corp.rktlab.test -Server 10.10.20.10

4. Accès Internet
   - Test-NetConnection 1.1.1.1 -Port 443

5. Navigateur
   - tester l'ouverture d'un site Web

## Validation

- passerelle accessible
- DNS interne fonctionnel
- sortie TCP 443 fonctionnelle
- navigation Web fonctionnelle

## Catégorie

Réseau / DNS