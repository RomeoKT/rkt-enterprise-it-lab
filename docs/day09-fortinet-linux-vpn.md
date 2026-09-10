# Day 09 — Fortinet, bases Linux et VPN

## Statut

- **FortiGate :** étude et comparaison avec pfSense
- **Linux :** commandes pratiquées sur Ubuntu
- **VPN IPsec :** concepts et méthode de dépannage documentés

Aucun FortiGate de production n'a été administré dans ce laboratoire.

## Objectif

Comprendre les concepts principaux de FortiGate, pratiquer les commandes Linux utiles au dépannage et étudier le fonctionnement d'un VPN IPsec.

## FortiGate

### Concepts étudiés

- interfaces WAN et LAN
- table de routage
- route par défaut
- politiques de pare-feu
- services et ports
- NAT
- sessions
- journaux

### Comparaison FortiGate et pfSense

| FortiGate | pfSense |
|---|---|
| Interface | Interface |
| Firewall Policy | Firewall Rule |
| Service | Protocole / port |
| Action | Pass / Block |
| NAT | NAT |
| Session | State |
| Logging | Firewall Logs |

## Bases Linux

```bash
ip a
ip r
ping -c 4 <IP>
ss -tulpn
dig example.com
curl -I https://example.com
systemctl status <service>
journalctl -p err -b
ps aux
df -h
free -h
```

## VPN

- **Remote Access VPN** : appareil individuel vers réseau d'entreprise
- **Site-to-Site VPN** : réseau vers réseau

![Flux VPN](../diagrams/vpn-flow.png)

### Protocoles et ports importants

- UDP `500` : IKE
- UDP `4500` : NAT Traversal
- protocole IP `50` : ESP, ce n'est pas le port TCP 50

## Dépannage VPN

Voir [Day 09 — Dépannage VPN](../troubleshooting/day09-vpn-troubleshooting.md).

## Ce que j'ai appris

Cette étape m'a permis de relier plusieurs concepts déjà pratiqués avec pfSense aux termes utilisés sur FortiGate, de renforcer mes bases Linux et de comprendre l'ordre général d'un diagnostic VPN.
