# Day 04 — Active Directory et DNS

Cette étape transforme le lab en vrai environnement Windows de domaine. `DC01` devient le contrôleur de domaine et le serveur DNS interne.

## DC01

| Paramètre | Valeur |
|---|---|
| Nom | `DC01` |
| IPv4 | `10.10.20.10` |
| Masque | `255.255.255.0` |
| Passerelle | `10.10.20.1` |
| DNS | `10.10.20.10` |

Rôles installés : Active Directory Domain Services et DNS Server.

Le domaine utilisé est `corp.rktlab.test`.

## Organisation du domaine

J'ai séparé les objets par sites, départements et rôles pour éviter de tout laisser dans les conteneurs par défaut.

```text
corp.rktlab.test
├── Montreal
│   ├── Users
│   └── Computers
├── Laval
│   ├── Users
│   └── Computers
├── Departments
│   ├── Finance
│   ├── HR
│   ├── IT
│   ├── Sales
│   └── Operations
├── Groups
├── Servers
├── Admins
└── Disabled-Accounts
```

Les OU de départements sont ensuite réutilisées par mes scripts PowerShell. Les OU de sites servent notamment à organiser les postes et à cibler certaines GPO.

## Pourquoi le DNS compte autant ici

Après la promotion de `DC01`, les postes membres du domaine utilisent `10.10.20.10` comme DNS principal. C'est indispensable pour retrouver les services Active Directory et joindre correctement le domaine.

J'ai vérifié le domaine et les services principaux avec :

```powershell
Get-ADDomain
Get-Service DNS,Netlogon,KDC,ADWS
```

## Preuves

![Active Directory Users and Computers](../screenshots/day04-aduc.png)

![DNS Manager](../screenshots/day04-dns-manager.png)

![W11-01 joint au domaine](../screenshots/day04-w11-domain-membership.png)

## Résultat

`W11-01` est joint à `corp.rktlab.test`, la résolution DNS interne fonctionne et la structure AD est prête pour les GPO, les groupes et les services de fichiers du Day 05.

## Point clé

Le dépannage d'un domaine Windows revient très souvent au DNS. C'est la première chose que je vérifie quand un poste ne trouve plus un contrôleur de domaine ou une ressource interne.
