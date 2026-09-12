# Day 08 — Entra ID, Intune et Autopilot

Étude de la gestion moderne des postes Windows. Je n'avais pas de tenant Intune complet pour faire un déploiement.

## Microsoft Entra ID

- utilisateurs et groupes
- rôles
- MFA
- SSO
- contrôle d'accès basé sur les rôles

### États d'un appareil

| État | Usage |
|---|---|
| Microsoft Entra registered | appareil personnel / BYOD |
| Microsoft Entra joined | poste géré dans le cloud |
| Microsoft Entra hybrid joined | poste lié à AD local et Entra ID |

## Microsoft Intune

- inscription des appareils
- profils de configuration
- conformité
- applications
- mises à jour
- actions à distance
- synchronisation

## Windows Autopilot

Flux étudié : enregistrement de l'appareil, profil Autopilot, premier démarrage, Entra Join, inscription Intune et application des politiques.

![Flux Windows Autopilot](../diagrams/autopilot-device-flow.png)

Voir [Dépannage Microsoft Intune](../operations/intune-troubleshooting-runbook.md).

Day 08 : étude seulement.
