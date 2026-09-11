# Day 09 — Méthode de dépannage VPN IPsec

## Statut

Scénario documenté pour pratiquer une méthode de diagnostic. Aucun tunnel de production n'est présenté comme ayant été administré.

## Scénario

Deux réseaux doivent communiquer par un VPN Site-to-Site.

## Ordre de diagnostic

### 1. Réseau local

Vérifier l'adresse IP, le masque, la passerelle et l'accès au pare-feu local.

### 2. Connectivité WAN

Vérifier que les deux pare-feu ont une connectivité Internet et une route valide vers le pair distant.

### 3. Adresse du pair VPN

Chaque pare-feu doit utiliser l'adresse WAN correcte du pair distant.

### 4. IKE

Vérifier des deux côtés :

- version IKE
- méthode d'authentification
- clé prépartagée ou certificats
- chiffrement
- intégrité

Ports utilisés couramment : UDP `500` et UDP `4500`.

### 5. Paramètres IPsec

Vérifier les réseaux locaux/distants, le chiffrement, l'intégrité et les traffic selectors.

### 6. État du tunnel

Un tunnel `UP` ne garantit pas que le trafic fonctionne.

### 7. Routage

Chaque site doit savoir joindre le réseau distant.

### 8. Règles de pare-feu

Les règles doivent autoriser le trafic nécessaire entre les deux réseaux.

### 9. NAT

Vérifier que le trafic VPN n'est pas traduit comme du trafic Internet normal lorsque la configuration exige une exemption NAT.

### 10. Journaux

Rechercher notamment les échecs IKE, les erreurs d'authentification, les paramètres incompatibles et les traffic selectors incorrects.

### 11. Tester le vrai service

Exemples : DNS 53, HTTPS 443, SMB 445 et RDP 3389.

### 12. Trafic de retour

Vérifier aussi les routes, règles, sélecteurs VPN et NAT dans le sens retour.

## Validation

Le problème est résolu lorsque le tunnel est établi, le service demandé fonctionne et le trafic de retour est valide.

## Résumé

L'ordre à garder en tête est : réseau local, WAN, pair VPN, IKE, authentification, IPsec, routage, pare-feu, NAT, journaux, test du service, trafic de retour et validation.
