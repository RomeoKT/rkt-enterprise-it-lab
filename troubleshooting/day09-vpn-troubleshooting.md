# Day 09 — Dépannage VPN IPsec

Méthode de vérification pour un VPN Site-to-Site.

Aucun tunnel FortiGate de production n'a été administré dans ce lab.

## Ordre de vérification

1. Réseau local
   - adresse IP
   - masque
   - passerelle
   - accès au pare-feu

2. WAN et pair distant
   - connectivité Internet
   - bonne adresse du pair

3. IKE
   - version IKE
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
   - service réellement utilisé
   - DNS 53, HTTPS 443, SMB 445, RDP 3389 selon le besoin

7. NAT
   - vérifier qu'il ne modifie pas le trafic VPN par erreur

8. Logs
   - échec IKE
   - authentification
   - paramètres incompatibles
   - mauvais sélecteur
   - règle bloquante

9. Trafic de retour
   - vérifier les deux sens

## Ports à connaître

- UDP 500 : IKE
- UDP 4500 : NAT Traversal
- IP 50 : ESP

## Validation

Le tunnel doit être établi et le service demandé doit fonctionner dans les deux sens.