# KB-001 — Réinitialiser un mot de passe AD

## Symptôme
L'utilisateur ne peut pas se connecter.

## Cause
Mot de passe oublié ou expiré.

## Solution

1. Ouvrir ADUC (`dsa.msc`)
2. Trouver l'utilisateur
3. Clic droit → Réinitialiser le mot de passe
4. Saisir un nouveau mot de passe
5. Décocher "L'utilisateur doit changer..." si besoin
6. OK

## Validation
L'utilisateur se connecte avec le nouveau mot de passe.

## Catégorie
Authentification / AD