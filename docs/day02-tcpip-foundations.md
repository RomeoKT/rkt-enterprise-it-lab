# Day 02 — TCP/IP et Wireshark

Ici, je voulais valider les bases réseau du lab avant d'ajouter Active Directory et les autres services.

## Configuration de test

Pour les premiers essais de `W11-01` :

| Paramètre | Valeur |
|---|---|
| IPv4 | `10.10.10.10` |
| Masque | `255.255.255.0` |
| Passerelle | `10.10.10.1` |
| DNS de test | `1.1.1.1` / `8.8.8.8` |

Cette configuration appartient au début du lab. À partir du Day 04, les postes membres du domaine utilisent `DC01` (`10.10.20.10`) comme DNS principal.

## Tests utilisés

```powershell
ipconfig /all
ping 10.10.10.1
ping 1.1.1.1
nslookup google.com
route print
arp -a
```

Je me suis servi de ces commandes pour vérifier l'adresse IP, la passerelle, les routes, le DNS et le cache ARP avant de modifier quoi que ce soit.

## Ce que j'ai observé dans Wireshark

### ICMP

Un `ping` m'a permis de repérer les Echo Request et Echo Reply.

![Capture ICMP](../screenshots/day02-icmp.png)

### DNS

J'ai capturé une résolution de nom pour suivre la requête DNS et la réponse retournée.

![Capture DNS](../screenshots/day02-dns.png)

### TCP

J'ai aussi isolé un three-way handshake : **SYN → SYN-ACK → ACK**.

![Capture TCP](../screenshots/day02-tcp-handshake.png)

## Break/fix

J'ai volontairement reproduit cinq erreurs : mauvaise passerelle, mauvais masque, mauvais DNS, adresse IP dupliquée et carte réseau désactivée.

Le détail est dans [Day 02 — Dépannage réseau](../troubleshooting/day02-break-fix.md).

## Ce que je retiens

Le point le plus utile ici a été de relier les commandes Windows aux paquets vus dans Wireshark. Quand un problème arrive, je vérifie d'abord la couche la plus simple avant de changer la configuration au hasard.
