# Day 09 — Dépannage VPN IPsec

Ce document sert de méthode de diagnostic pour un VPN Site-to-Site. Je n'ai pas administré un tunnel FortiGate de production dans ce lab; le but est surtout de garder un ordre logique quand un VPN ne passe plus le trafic attendu.

## Scénario

Deux réseaux doivent communiquer à travers un tunnel IPsec entre deux pare-feu.

## Ordre de vérification

### 1. Réseau local

Je commence par l'adresse IP, le masque, la passerelle et l'accès au pare-feu local. Si le poste n'atteint même pas sa passerelle, le VPN n'est pas encore le bon endroit où chercher.

### 2. WAN et pair distant

Les deux passerelles VPN doivent avoir une route valide vers Internet et vers l'adresse du pair distant.

### 3. IKE

Je compare des deux côtés : version IKE, méthode d'authentification, clé prépartagée ou certificats, chiffrement, intégrité et paramètres Diffie-Hellman.

Ports courants : UDP `500` pour IKE et UDP `4500` quand NAT Traversal est utilisé.

### 4. Paramètres IPsec

Je vérifie les réseaux locaux/distants, les proposals, les sélecteurs de trafic et les Security Associations.

### 5. État du tunnel

Un tunnel `UP` n'est pas une preuve que l'application fonctionne. Il faut encore vérifier le routage, les règles de pare-feu et le trafic de retour.

### 6. Routage

Chaque site doit avoir une route correcte vers le réseau distant.

### 7. Pare-feu

Je vérifie que le trafic utile est permis, pas seulement que « le VPN est ouvert ». Le service testé doit correspondre au besoin réel : DNS 53, HTTPS 443, SMB 445, RDP 3389, etc.

### 8. NAT

Je confirme que le trafic VPN n'est pas traduit comme du trafic Internet normal si la configuration exige une exemption NAT.

### 9. Logs

Les journaux servent à distinguer un échec IKE, une erreur d'authentification, un proposal incompatible, un mauvais traffic selector ou un simple blocage de règle.

### 10. Trafic de retour

Je vérifie toujours les deux sens. Un paquet peut atteindre le serveur distant et quand même échouer si la réponse ne revient pas par le bon chemin.

## Validation

Je considère le problème résolu seulement quand le tunnel est établi **et** que le vrai service demandé fonctionne dans les deux sens.

C'est le point principal de ce runbook : ne pas s'arrêter au statut `UP` du tunnel.
