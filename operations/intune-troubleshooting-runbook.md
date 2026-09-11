# Runbook — Dépannage Microsoft Intune

## Statut

Document d'étude. Les scénarios servent à organiser une méthode de diagnostic et ne sont pas présentés comme des incidents de production réellement administrés.

## Scénario 1 — Échec de connexion à cause de MFA

### Vérifications

1. vérifier la connexion Internet
2. vérifier l'heure et la date du téléphone
3. vérifier les méthodes d'authentification enregistrées pour l'utilisateur
4. vérifier si Microsoft Authenticator est disponible et correctement configuré

## Scénario 2 — Appareil joint à Entra ID mais absent d'Intune

### Vérifications

1. vérifier que l'utilisateur possède la licence nécessaire
2. vérifier la portée d'inscription MDM
3. vérifier les restrictions d'inscription
4. sur le poste, exécuter :

```cmd
dsregcmd /status
```

5. si l'appareil est déjà inscrit, ouvrir **Paramètres → Comptes → Accès professionnel ou scolaire → Compte de l'organisation → Infos → Synchroniser**

> `dsregcmd /leave` ne doit pas être utilisé comme simple commande de synchronisation. Cette commande retire l'enregistrement de l'appareil et doit être réservée à un scénario de réparation précis.

## Scénario 3 — Appareil non conforme

Vérifier la politique de conformité, Windows Update, l'antivirus, la version de Windows, puis synchroniser l'appareil.

## Scénario 4 — Application gérée absente

Vérifier l'assignation, le groupe ciblé, lancer une synchronisation et vérifier l'état d'installation dans Intune ou Company Portal.

## Méthode générale

1. vérifier l'identité de l'utilisateur
2. vérifier la licence
3. vérifier l'état de l'appareil
4. vérifier l'inscription Intune
5. vérifier l'assignation de la politique ou de l'application
6. lancer une synchronisation si nécessaire
7. vérifier la conformité
8. valider le résultat
