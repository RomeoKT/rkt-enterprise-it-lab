# KB-002 — Problème d'accès Internet

Le poste ne peut pas accéder à Internet.

## Vérifications

1. Configuration IP
   - ipconfig /all
   - réseau : 10.10.10.0/24
   - passerelle : 10.10.10.1
   - DNS : 10.10.20.10

2. Passerelle
   - ping 10.10.10.1

3. DNS
   - Test-NetConnection 10.10.20.10 -Port 53
   - Resolve-DnsName DC01.corp.rktlab.test -Server 10.10.20.10

4. Internet
   - Test-NetConnection 1.1.1.1 -Port 443

5. Navigateur
   - ouvrir un site Web

## Test final

- passerelle accessible
- DNS interne fonctionnel
- TCP 443 fonctionnel
- navigation Web fonctionnelle
