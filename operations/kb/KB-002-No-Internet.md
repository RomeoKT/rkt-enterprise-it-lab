# KB-002 — Pas d'Internet

## Symptôme
L'utilisateur ne peut pas accéder à Internet.

## Causes
1. Mauvaise IP ou gateway
2. Mauvais DNS
3. Câble débranché

## Solution — Étapes

1. Vérifier `ipconfig /all`
   - IP valide
   - Gateway = 10.10.10.1
   - DNS = 10.10.20.10

2. Tester la connectivité
   - `ping 127.0.0.1` → OK
   - `ping 10.10.10.1` → OK
   - `ping 1.1.1.1` → OK

3. Tester DNS
   - `nslookup google.com` → OK

## Validation
- `ping 1.1.1.1` OK
- `nslookup google.com` OK
- Le navigateur affiche une page

## Catégorie
Réseau / DNS
