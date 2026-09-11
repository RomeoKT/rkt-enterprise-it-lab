# Day 01 — Base du lab

Préparation de VMware Workstation Pro et des réseaux utilisés par le projet.

## Machines

- PFSENSE01
- DC01
- FS01
- W11-01
- ADMIN01
- UBUNTU01

Les ressources CPU, RAM et disque ont été ajustées selon le rôle de chaque VM.

## Réseaux VMware

| Zone | Réseau |
|---|---|
| USERS | 10.10.10.0/24 |
| SERVERS | 10.10.20.0/24 |
| MGMT | 10.10.30.0/24 |
| SECURITY | 10.10.40.0/24 |

Les réseaux internes sont en host-only. La sortie Internet passe ensuite par pfSense.

## Architecture de départ

![Première version de l'architecture](../diagrams/architecture-v1.png)

## Résultat

La base VMware est prête pour pfSense, Windows Server et les postes clients.