## Hypervisor

Logiciel qui fait tourner des VMs. VMware Workstation Pro c'est un hyperviseur de type 2, ca roule par dessus Windows. Gratuit maintenant.

## Virtual Machine

Un ordi dans un ordi. Elle a son propre OS, sa propre IP. L'hyperviseur lui fait croire qu'elle est sur du vrai hardware.

## vCPU

Le CPU de ta VM. J'met 2 coeurs pour mes VMs. Pas plus sinon l'hôte lag.

## Virtual Memory

La RAM de ta VM. J'ai 32 Go physique, j'donne 2-4 Go par VM. Faut pas dépasser sinon ca swap.

## Virtual Disk

Un fichier (.vmdk) qui est comme le disque dur de la VM. Ca prend dla place sur ton SSD.

## Snapshot

Un "undo" pour ta VM. Tu prend une photo avant de faire qqch, si tu pètes tout tu reviens en arriere. Ca prend dla place.

## Clone

Copie d'une VM. Pour faire plusieurs VMs sans réinstaller.

## NAT

La VM partage l'IP de ton PC pour sortir sur Internet. Les autres peuvent pas rentrer de l'exterieur.

## Bridged Networking

La VM est sur le meme réseau que ton PC. Pas besoin pour mon lab.

## Host-Only Networking

Réseau isolé, juste les VMs et l'hôte. Parfait pour mon lab.

## Virtual NIC

Carte réseau virtuelle. Une VM peut en avoir plusieurs.

## Virtual Switch

Switch en logiciel. Permet aux VMs sur un même réseau de se parler.

## What I Built Today

Installé VMware Workstation Pro. Downloadé les ISO. Créé mes VMs de base : PFSENSE01, DC01, FS01, W11-01, ADMIN01, UBUNTU01. Configuré 4 réseaux host-only. Commencé diagramme.

## What I Still Need To Configure

Installer les OS. Configurer pfSense. L'adressage IP. Tester que les VMs se ping entre les réseaux.