# Day 09 — Fortinet, Linux et VPN

Le Day 09 sert surtout à élargir le lab sans faire semblant d'avoir déjà administré tous les produits. J'ai comparé les concepts FortiGate à ce que je connais déjà sur pfSense, pratiqué les commandes Linux de base et revu le fonctionnement d'un VPN IPsec.

## FortiGate : faire le lien avec pfSense

Je me suis concentré sur les notions qui se transfèrent d'un pare-feu à l'autre : interfaces, routes, politiques de pare-feu, services, NAT, sessions et journaux.

| FortiGate | pfSense |
|---|---|
| Firewall Policy | Firewall Rule |
| Service | protocole / port |
| Action | Pass / Block |
| NAT | NAT |
| Session | State |
| Logging | Firewall Logs |

Le but n'était pas d'apprendre des menus par coeur, mais de reconnaître les mêmes concepts avec un autre produit.

## Linux : commandes que j'ai pratiquées

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

Je voulais être capable d'arriver sur une VM Ubuntu et de vérifier rapidement le réseau, un service, les logs et les ressources sans être bloqué par l'outil.

## VPN

J'ai travaillé la différence entre :

- Remote Access VPN : un appareil distant rejoint le réseau de l'entreprise
- Site-to-Site VPN : deux réseaux sont reliés par leurs passerelles VPN

![Flux VPN](../diagrams/vpn-flow.png)

Pour IPsec, les éléments que je retiens sont notamment UDP `500` pour IKE, UDP `4500` pour NAT Traversal et le protocole IP `50` pour ESP.

Le runbook complet est ici : [Day 09 — Dépannage VPN](../troubleshooting/day09-vpn-troubleshooting.md).

## Bilan

Cette journée m'a surtout appris à transférer ce que je sais déjà vers un autre environnement. Je n'ai pas déployé un FortiGate de production; je préfère garder cette limite claire dans le portfolio.
