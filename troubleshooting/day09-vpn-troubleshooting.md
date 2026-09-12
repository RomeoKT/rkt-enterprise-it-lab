# Day 09 — Dépannage VPN IPsec

Checklist étudiée pour un VPN Site-to-Site.

## Vérifications

1. Réseau local
   - IP
   - masque
   - passerelle
   - accès au pare-feu

2. WAN
   - Internet
   - adresse du pair distant

3. IKE
   - version
   - authentification
   - clé ou certificat
   - chiffrement
   - intégrité
   - Diffie-Hellman

4. IPsec
   - réseaux locaux et distants
   - proposals
   - sélecteurs de trafic
   - Security Associations

5. Routage
   - route vers le réseau distant

6. Pare-feu
   - service et port utilisés

7. NAT
   - vérifier qu'il ne modifie pas le trafic VPN

8. Logs
   - IKE
   - authentification
   - paramètres incompatibles
   - sélecteurs
   - règles bloquantes

9. Retour
   - vérifier le trafic dans les deux sens

## Ports

- UDP 500 : IKE
- UDP 4500 : NAT-T
- IP 50 : ESP

Validation : tunnel établi et service demandé fonctionnel dans les deux sens.
