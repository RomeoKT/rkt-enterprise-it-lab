# Day 01 — Fondements de la virtualisation

## Objectif

Préparer l'environnement VMware Workstation Pro et créer les machines virtuelles nécessaires au laboratoire.

## Concepts utilisés

- **Hyperviseur de type 2** : VMware Workstation Pro fonctionne au-dessus du système d'exploitation de l'hôte.
- **Machine virtuelle** : système isolé avec son propre système d'exploitation, ses ressources et ses interfaces réseau.
- **vCPU** : processeurs virtuels attribués à une VM.
- **Mémoire virtuelle** : mémoire RAM attribuée à une VM.
- **Disque virtuel** : fichier représentant le stockage de la VM.
- **Snapshot** : point de restauration utilisé avant une modification importante.
- **Clone** : copie d'une VM permettant de réutiliser une base existante.
- **NAT** : permet à une VM de sortir vers Internet en utilisant la connexion de l'hôte.
- **Host-only** : réseau virtuel isolé utilisé pour les zones internes du laboratoire.
- **Carte réseau virtuelle** : interface réseau d'une VM.
- **Commutateur virtuel** : relie les VMs présentes sur un même réseau virtuel.

## Environnement créé

Six machines virtuelles ont été préparées :

- `PFSENSE01`
- `DC01`
- `FS01`
- `W11-01`
- `ADMIN01`
- `UBUNTU01`

Quatre réseaux VMware host-only ont été créés :

| Zone | Réseau |
|---|---|
| USERS | `10.10.10.0/24` |
| SERVERS | `10.10.20.0/24` |
| MGMT | `10.10.30.0/24` |
| SECURITY | `10.10.40.0/24` |

Les ressources CPU et mémoire sont ajustées selon le rôle de chaque VM afin de ne pas surcharger l'hôte.

## Résultat

L'environnement de virtualisation de base est prêt pour l'installation des systèmes, la configuration de pfSense et le déploiement des services Windows.

![Première version de l'architecture](../diagrams/architecture-v1.png)

## Ce que j'ai appris

Cette étape m'a permis de mieux comprendre la différence entre une VM, un réseau virtuel, le mode NAT et le mode host-only, ainsi que l'importance de bien répartir les ressources de l'hôte.
