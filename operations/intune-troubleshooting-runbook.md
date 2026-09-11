# Runbook — Dépannage Microsoft Intune

Document du Day 08. Aucun tenant Intune complet n'a été utilisé dans ce lab.

## 1. Connexion ou MFA

Vérifier :

- connexion Internet
- date et heure du téléphone
- méthodes d'authentification
- Microsoft Authenticator

## 2. Appareil dans Entra ID mais absent d'Intune

Vérifier :

- licence de l'utilisateur
- portée MDM
- restrictions d'inscription
- état du poste avec dsregcmd /status
- synchronisation de l'appareil

Chemin de synchronisation Windows : Paramètres > Comptes > Accès professionnel ou scolaire > Compte de l'organisation > Infos > Synchroniser.

dsregcmd /leave retire l'enregistrement de l'appareil. Ce n'est pas une commande de synchronisation.

## 3. Appareil non conforme

Vérifier :

- politique de conformité
- Windows Update
- antivirus
- version de Windows
- dernière synchronisation

## 4. Application gérée absente

Vérifier :

- assignation
- groupe ciblé
- synchronisation
- résultat d'installation dans Intune ou Company Portal

## Ordre général

Identité → licence → appareil → inscription → assignation → synchronisation → conformité.