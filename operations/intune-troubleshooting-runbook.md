# Dépannage Microsoft Intune

Day 08 : étude seulement. Je n'avais pas de tenant Intune complet.

## Connexion ou MFA

Vérifier :

- Internet
- date et heure du téléphone
- méthodes d'authentification
- Microsoft Authenticator

## Appareil dans Entra ID mais absent d'Intune

Vérifier :

- licence utilisateur
- portée MDM
- restrictions d'inscription
- dsregcmd /status
- dernière synchronisation

Sous Windows : Paramètres > Comptes > Accès professionnel ou scolaire > compte de l'organisation > Infos > Synchroniser.

dsregcmd /leave retire l'enregistrement de l'appareil. Ce n'est pas une commande de synchronisation.

## Appareil non conforme

Vérifier :

- politique de conformité
- Windows Update
- antivirus
- version de Windows
- dernière synchronisation

## Application absente

Vérifier :

- assignation
- groupe ciblé
- synchronisation
- résultat dans Intune ou Company Portal

Ordre : identité, licence, appareil, inscription, assignation, synchronisation, conformité.
