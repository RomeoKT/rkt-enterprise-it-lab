# Runbook — Dépannage Microsoft Intune

## Statut

Document d'étude. Les scénarios servent à organiser une méthode de diagnostic et ne sont pas présentés comme des incidents de production réellement administrés.

## Scénario 1 — Échec de connexion à cause de MFA

### Vérifications

1. Vérifier la connexion Internet.
2. Vérifier l'heure et la date du téléphone.
3. Vérifier les méthodes d'authentification enregistrées pour l'utilisateur.
4. Vérifier si Microsoft Authenticator est disponible et correctement configuré.

## Scénario 2 — Appareil joint à Entra ID mais absent d'Intune

### Vérifications

1. Vérifier que l'utilisateur possède la licence nécessaire.
2. Vérifier la portée d'inscription MDM.
3. Vérifier les restrictions d'inscription.
4. Sur le poste :

```cmd
dsregcmd /status
```

5. Si l'appareil est déjà inscrit, lancer une synchronisation :

```text
Paramètres
→ Comptes
→ Accès professionnel ou scolaire
→ Compte de l'organisation
→ Infos
→ Synchroniser
```

> `dsregcmd /leave` ne doit pas être utilisé comme simple commande de synchronisation. Cette commande retire l'enregistrement de l'appareil et doit être réservée à un scénario de réparation précis.

## Scénario 3 — Appareil non conforme

Vérifier la politique de conformité, Windows Update, l'antivirus, la version de Windows, puis synchroniser l'appareil.

## Scénario 4 — Application gérée absente

Vérifier l'assignation, le groupe ciblé, lancer une synchronisation et vérifier l'état d'installation dans Intune ou Company Portal.

## Méthode générale

```text
Identité
↓
Licence
↓
État de l'appareil
↓
Inscription
↓
Assignation
↓
Synchronisation
↓
Conformité
↓
Validation
```
