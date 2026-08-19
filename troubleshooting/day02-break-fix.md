# Day 02 — Break/Fix

## INC-01 — Wrong Gateway

### Symptom
- accès réseau local OK
- internet ne marche pas

### Expected Configuration
- IP: 10.10.10.10
- Mask: 255.255.255.0
- Gateway: 10.10.10.1

### Broken Configuration
- Gateway: 10.10.10.254

### Commands Used
- ipconfig /all
- ping 10.10.10.1
- ping 1.1.1.1
- route print

### Evidence
- ping 10.10.10.1 OK
- ping 1.1.1.1 FAIL
- mauvaise gateway dans ipconfig

### Root Cause
- default gateway incorrecte

### Resolution
- remettre gateway: 10.10.10.1

### Validation
- ping 10.10.10.1 OK
- ping 1.1.1.1 OK

### What This Taught Me
- même subnet = pas besoin de gateway
- autre réseau = passe par la default gateway


---

## INC-02 — Wrong Subnet Mask

### Symptom
- problème de communication avec la gateway
- réseau ne fonctionne pas normalement

### Expected Configuration
- IP: 10.10.10.10
- Mask: 255.255.255.0 /24
- Gateway: 10.10.10.1

### Broken Configuration
- IP: 10.10.10.10
- Mask: 255.255.255.252 /30
- Gateway: 10.10.10.1

### Commands Used
- ipconfig /all
- ping 10.10.10.1
- route print

### Evidence
- masque /30 au lieu de /24
- 10.10.10.10 et 10.10.10.1 pas dans le même petit subnet

### Root Cause
- mauvais subnet mask

### Resolution
- remettre:
- 255.255.255.0
- /24

### Validation
- ping 10.10.10.1 OK
- réseau normal

### What This Taught Me
- le subnet mask décide quelles IP sont considérées locales
- mauvais masque = mauvais calcul du réseau


---

## INC-03 — Wrong DNS

### Symptom
- internet par IP marche
- noms de domaine ne marchent pas

### Expected Configuration
- DNS: 1.1.1.1
- ou 8.8.8.8

### Broken Configuration
- DNS: 10.10.10.250

### Commands Used
- ping 1.1.1.1
- ping google.com
- nslookup google.com
- ipconfig /all

### Evidence
- ping 1.1.1.1 OK
- ping google.com FAIL
- nslookup google.com FAIL

### Root Cause
- serveur DNS incorrect / inexistant

### Resolution
- remettre DNS:
- 1.1.1.1
- 8.8.8.8

### Validation
- nslookup google.com OK
- ping google.com OK

### What This Taught Me
- connexion IP peut marcher même si DNS est cassé
- DNS sert à résoudre nom → IP


---

## INC-04 — Duplicate IP

### Symptom
- connexion instable ou coupée
- conflit réseau

### Expected Configuration
- W11-01: 10.10.10.10
- pfSense: 10.10.10.1

### Broken Configuration
- W11-01: 10.10.10.1
- pfSense: 10.10.10.1

### Commands Used
- ipconfig /all
- ping 10.10.10.1
- arp -a

### Evidence
- 2 appareils avec la même IP
- comportement ARP pas normal
- perte de connectivité

### Root Cause
- adresse IP dupliquée

### Resolution
- remettre W11-01:
- 10.10.10.10

### Validation
- ping 10.10.10.1 OK
- connexion stable
- plus de conflit

### What This Taught Me
- chaque machine doit avoir une IP unique
- duplicate IP peut casser ARP et la connectivité


---

## INC-05 — Disabled Adapter

### Symptom
- aucune connexion réseau
- interface Ethernet désactivée

### Expected Configuration
- adapter Ethernet Enabled

### Broken Configuration
- adapter Ethernet Disabled

### Commands Used
- ncpa.cpl
- ipconfig
- ping 127.0.0.1
- ping 10.10.10.1

### Evidence
- interface désactivée dans ncpa.cpl
- pas d'IP normale sur l'interface
- ping 127.0.0.1 OK
- ping 10.10.10.1 FAIL

### Root Cause
- network adapter désactivé

### Resolution
- clic droit Ethernet
- Enable

### Validation
- ipconfig montre l'interface
- ping 10.10.10.1 OK

### What This Taught Me
- vérifier l'état de l'adapter avant de chercher plus loin
- loopback peut fonctionner même si la carte réseau est désactivée