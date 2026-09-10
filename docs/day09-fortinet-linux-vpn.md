# Day 09 — Fortinet, Linux Survival and VPN

## Objective

Study FortiGate firewall concepts, map them to pfSense, practice essential Linux commands on Ubuntu, and learn VPN fundamentals. No production FortiGate was administered.

---

## FortiGate Fundamentals

FortiGate is Fortinet's firewall platform. It sits at the same position as PFSENSE01 in the lab.

### Key Concepts
- Interfaces (WAN, LAN)
- Routing table and default route (0.0.0.0/0)
- Firewall Policies (source, destination, service, action)
- Stateful firewall and state table
- NAT (address translation)
- Logging and Monitoring

### FortiGate vs pfSense

| FortiGate | pfSense |
|---|---|
| Interface | Interface |
| Firewall Policy | Firewall Rule |
| Service | Protocol / Port |
| Action | Pass / Block |
| NAT | NAT |
| Session | State |
| Logging | Firewall Logs |

Routing answers: where does the packet go?
Firewall policy answers: is the packet allowed?

A valid route does not mean traffic is allowed.

---

## Linux Survival

Basic commands practiced on Ubuntu to inspect and troubleshoot without advanced knowledge.

### Network
- `ip a` — show interfaces and IPs
- `ip r` — show routing table
- `ping -c 4 <IP>` — test connectivity
- `ss -tulpn` — show listening ports
- `dig example.com` — DNS resolution
- `curl -I https://example.com` — HTTP/HTTPS test

### Services and Logs
- `systemctl status <service>` — service state
- `systemctl restart <service>` — restart service
- `systemctl --failed` — list failed services
- `journalctl -p err -b` — errors since boot

### Processes and Resources
- `ps aux` — list processes
- `top` — real-time processes
- `df -h` — disk usage
- `free -h` — memory usage

### Files and Permissions
- `ls -la` — list files with permissions
- `cat <file>` — read a file
- `tail -f <file>` — follow a log
- `grep "ERROR" file` — search text
- `chmod 644 file` — change permissions (r=4, w=2, x=1)
- `chown user:group file` — change owner

### Troubleshooting Workflow
ip a → ip r → ping → dig → ss -tulpn → curl → systemctl → journalctl → ps aux → df -h → free -h

---

## VPN Fundamentals

VPN = Virtual Private Network. Creates a protected tunnel through an untrusted network.

### Two Types
- **Remote Access VPN** : individual device ↔ corporate network
- **Site-to-Site VPN** : network ↔ network

### IPsec and IKE
- **IPsec** provides confidentiality, integrity, authentication
- **IKE** negotiates parameters and authenticates peers before IPsec

Flow:
Peers contact → IKE negotiation → authentication → parameters agreed → IPsec established → encrypted traffic

text

### Important Ports
- UDP 500 → IKE
- UDP 4500 → NAT Traversal
- IP Protocol 50 → ESP (not TCP port 50)

### Split vs Full Tunnel
- **Split Tunnel** : corporate traffic via VPN, Internet direct
- **Full Tunnel** : all traffic via VPN

---

## Concepts Learned

- FortiGate architecture and pfSense mapping
- Linux networking, services, logs, resources, permissions
- Remote Access VPN and Site-to-Site VPN
- IPsec, IKE, encryption, authentication
- Split tunnel vs full tunnel