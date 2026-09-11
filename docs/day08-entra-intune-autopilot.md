# Day 08 — Microsoft Entra ID, Intune et Autopilot

## Statut

**Étude et documentation.** Ces services n'ont pas été déployés comme environnement de production dans ce laboratoire.

## Objectif

Comprendre les bases de la gestion moderne des identités et des postes Windows dans l'écosystème Microsoft.

## Microsoft Entra ID

Notions étudiées : utilisateurs, groupes, rôles, authentification multifacteur, SSO et contrôle d'accès basé sur les rôles.

## États d'un appareil

| État | Usage général |
|---|---|
| Microsoft Entra registered | appareil personnel ou BYOD |
| Microsoft Entra joined | appareil géré principalement dans le cloud |
| Microsoft Entra hybrid joined | appareil lié à Active Directory local et Microsoft Entra ID |

## Microsoft Intune

Notions étudiées : inscription des appareils, profils de configuration, politiques de conformité, déploiement d'applications, anneaux de mises à jour, actions à distance et synchronisation.

## Windows Autopilot

Le flux étudié est le suivant :

1. l'appareil est enregistré dans Autopilot
2. un profil Autopilot lui est assigné
3. l'utilisateur démarre le poste pour la première fois
4. le poste rejoint Microsoft Entra ID
5. l'appareil est inscrit dans Intune
6. les politiques et applications sont appliquées
7. le poste est prêt pour l'utilisateur

![Flux Windows Autopilot](../diagrams/autopilot-device-flow.png)

## Dépannage

Voir [Runbook — Dépannage Intune](../operations/intune-troubleshooting-runbook.md).

## Ce que j'ai appris

Cette étape m'a permis de distinguer Active Directory local, Microsoft Entra ID, Intune et Windows Autopilot, ainsi que de comprendre le rôle général de chacun dans la gestion moderne des postes.
