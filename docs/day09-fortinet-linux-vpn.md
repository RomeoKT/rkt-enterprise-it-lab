# Day 09 — Fortinet, Linux et VPN

Pratique Linux et étude de FortiGate et des VPN IPsec.

## FortiGate et pfSense

| FortiGate | pfSense |
|---|---|
| Firewall Policy | Firewall Rule |
| Service | protocole / port |
| Action | Pass / Block |
| NAT | NAT |
| Session | State |
| Logging | Firewall Logs |

Sujets vus : interfaces, routes, règles de pare-feu, services, NAT, sessions et logs.

## Linux

Commandes pratiquées :

- ip a
- ip r
- ping -c 4 adresse_IP
- ss -tulpn
- dig example.com
- curl -I https://example.com
- systemctl status service
- journalctl -p err -b
- ps aux
- df -h
- free -h

## VPN

- Remote Access VPN : un appareil distant rejoint le réseau.
- Site-to-Site VPN : deux réseaux sont reliés par leurs passerelles VPN.

![Flux VPN](../diagrams/vpn-flow.png)

IPsec : UDP 500 pour IKE, UDP 4500 pour NAT-T et IP 50 pour ESP.

Voir [Dépannage VPN](../troubleshooting/day09-vpn-troubleshooting.md).

FortiGate et VPN : étude. Linux : pratique sur VM.
