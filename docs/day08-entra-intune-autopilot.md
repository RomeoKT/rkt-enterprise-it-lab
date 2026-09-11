# Day 08 — Entra ID, Intune et Autopilot

Étude des bases de la gestion moderne des postes Windows.

Je n'avais pas de tenant Intune complet pour faire un déploiement réel.

## Microsoft Entra ID

Sujets étudiés :

- utilisateurs et groupes
- rôles
- MFA
- SSO
- contrôle d'accès basé sur les rôles

### États d'un appareil

| État | Usage général |
|---|---|
| Microsoft Entra registered | appareil personnel / BYOD |
| Microsoft Entra joined | poste géré principalement dans le cloud |
| Microsoft Entra hybrid joined | poste lié à AD local et à Entra ID |

## Microsoft Intune

- inscription des appareils
- profils de configuration
- conformité
- déploiement d'applications
- mises à jour
- actions à distance
- synchronisation

## Windows Autopilot

J'ai étudié le chemin général : enregistrement de l'appareil, profil Autopilot, premier démarrage, Entra Join, inscription Intune et application des politiques.

![Flux Windows Autopilot](../diagrams/autopilot-device-flow.png)

## Dépannage

Voir [Runbook — Dépannage Microsoft Intune](../operations/intune-troubleshooting-runbook.md).

## Statut

Étude et documentation seulement. Aucun déploiement Intune de production n'est présenté dans ce lab.