# Runbook — Dépannage Intune

## Scénario 1 — L'utilisateur ne peut pas se connecter

### Symptôme
L'utilisateur entre son mot de passe mais MFA échoue.

### Causes possibles
- L'application Microsoft Authenticator n'est pas installée
- Le téléphone n'est pas synchronisé
- Le numéro de téléphone est incorrect

### Solutions
1. Vérifier que l'app Authenticator est installée
2. Réinitialiser la méthode MFA dans Entra ID
3. Utiliser un code de secours

---

## Scénario 2 — L'appareil ne s'inscrit pas dans Intune

### Symptôme
Le PC est joint à Entra ID mais n'apparaît pas dans Intune.

### Causes possibles
- Le profil de gestion automatique n'est pas configuré
- L'utilisateur n'a pas de licence Intune

### Solutions
1. Vérifier la licence de l'utilisateur
2. Vérifier que le MDM est configuré sur "Tous"
3. Forcer la synchronisation : `dsregcmd /leave` puis redémarrer

---

## Scénario 3 — L'appareil est non-conforme

### Symptôme
Conditional Access bloque l'accès aux applications.

### Causes possibles
- Antivirus désactivé
- Windows non à jour
- Version d'OS non supportée

### Solutions
1. Dans Intune, vérifier la politique de conformité
2. Mettre à jour Windows
3. Activer l'antivirus
4. Forcer la synchronisation : Paramètres → Comptes → Accès scolaire → Sync

---

## Scénario 4 — Une application est manquante

### Symptôme
L'application (ex: Teams) n'est pas installée.

### Causes possibles
- L'application n'est pas assignée au groupe de l'utilisateur
- L'installation a échoué (erreur de package)

### Solutions
1. Vérifier l'assignation dans Intune
2. Vérifier les logs d'installation sur le PC (Event Viewer)
3. Réinstaller manuellement depuis le Company Portal

---

## Scénario 5 — OneDrive ne se synchronise pas

### Symptôme
Les fichiers OneDrive ne s'affichent pas.

### Causes possibles
- OneDrive n'est pas configuré
- Le client OneDrive est en pause
- Manque d'espace disque

### Solutions
1. Vérifier que OneDrive est lancé
2. Configurer OneDrive avec le compte M365
3. Libérer de l'espace disque