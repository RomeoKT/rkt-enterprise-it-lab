# Runbook — Dépannage Microsoft Intune

Ce runbook vient du Day 08. Je n'avais pas de tenant Intune complet pour reproduire ces cas de bout en bout, donc je l'utilise comme méthode de diagnostic et non comme preuve d'administration en production.

## 1. Problème de connexion ou MFA

Je vérifie d'abord la connexion Internet, la date et l'heure du téléphone, les méthodes d'authentification enregistrées et l'état de Microsoft Authenticator.

## 2. Appareil joint à Entra ID mais absent d'Intune

Ordre de vérification : licence de l'utilisateur, portée MDM, restrictions d'inscription, puis état du poste.

Sur Windows :

```cmd
dsregcmd /status
```

Si l'appareil est déjà inscrit, je lance une synchronisation depuis **Paramètres > Comptes > Accès professionnel ou scolaire > Compte de l'organisation > Infos > Synchroniser**.

`dsregcmd /leave` n'est pas une commande de synchronisation. Elle retire l'enregistrement de l'appareil et ne doit être utilisée que dans un scénario de réparation précis.

## 3. Appareil non conforme

Je vérifie la politique de conformité appliquée, Windows Update, l'antivirus, la version de Windows et la dernière synchronisation.

## 4. Application gérée absente

Je regarde l'assignation de l'application, le groupe ciblé, l'état de synchronisation et le résultat d'installation dans Intune ou Company Portal.

## Ordre que je garde en tête

Je commence par l'identité et la licence, puis l'état de l'appareil, l'inscription, l'assignation, la synchronisation et enfin la conformité. Ça évite de réinitialiser un poste alors que le problème vient simplement d'un groupe ou d'une licence.
