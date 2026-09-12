# Day 02 — TCP/IP et Wireshark

Validation des bases réseau avant Active Directory.

## Configuration de test

| Paramètre | Valeur |
|---|---|
| Poste | W11-01 |
| IPv4 | 10.10.10.10 |
| Masque | 255.255.255.0 |
| Passerelle | 10.10.10.1 |
| DNS de test | 1.1.1.1 / 8.8.8.8 |

À partir du Day 04, les postes du domaine utilisent DC01, 10.10.20.10, comme DNS principal.

## Tests

- ipconfig /all
- ping 10.10.10.1
- ping 1.1.1.1
- nslookup google.com
- route print
- arp -a

## Wireshark

### ICMP

Capture d'un ping avec Echo Request et Echo Reply.

![Capture ICMP](../screenshots/day02-icmp.png)

### DNS

Capture d'une résolution de nom.

![Capture DNS](../screenshots/day02-dns.png)

### TCP

Capture du three-way handshake : SYN, SYN-ACK, ACK.

![Capture TCP](../screenshots/day02-tcp-handshake.png)

## Dépannage

Tests faits avec une mauvaise passerelle, un mauvais masque, un mauvais DNS, une IP dupliquée et une carte réseau désactivée.

Voir [Day 02 — Dépannage réseau](../troubleshooting/day02-break-fix.md).
