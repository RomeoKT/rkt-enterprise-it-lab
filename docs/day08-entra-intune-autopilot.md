# Day 08 — Entra ID, Intune, Autopilot

## Objectif
Comprendre la gestion moderne des endpoints dans le Cloud Microsoft.

## Entra ID
- Annuaire Cloud (ex- Azure AD)
- Gère : Utilisateurs, Groupes, Rôles, MFA, SSO
- RBAC : Rôles au lieu de permissions directes

## États des Appareils
1. Entra Registered : BYOD (PC perso)
2. Entra Joined : PC Cloud uniquement
3. Hybrid Joined : PC local + Cloud

## Intune
- MDM (Mobile Device Management) et MAM
- Fonctions :
  - Enrollment (inscription)
  - Configuration Profiles (paramètres)
  - Compliance Policies (vérification antivirus, etc.)
  - App Deployment (installation Office, Teams)
  - Update Rings (mises à jour)
  - Remote Actions (Wipe, Retire, Sync)

## Autopilot
- Zero-touch deployment
- Workflow :
  1. Hash matériel importé
  2. Profil Autopilot créé
  3. PC allumé par l'utilisateur
  4. Connexion M365
  5. Entra Join
  6. Intune Enrollment
  7. Configurations
  8. Applications
  9. Conformité
  10. Prêt

## Conditional Access
- Règles basées sur :
  - MFA
  - Conformité Intune
  - Localisation
  - Risque utilisateur