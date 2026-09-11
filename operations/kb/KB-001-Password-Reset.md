# KB-001 — Réinitialiser un mot de passe Active Directory

## Symptôme

L'utilisateur ne peut plus ouvrir sa session parce que son mot de passe est oublié ou expiré.

## Vérifications

1. confirmer l'identité de l'utilisateur
2. vérifier que le compte existe
3. vérifier que le compte n'est pas désactivé
4. vérifier si le compte est verrouillé

## Résolution avec ADUC

1. ouvrir dsa.msc
2. rechercher l'utilisateur
3. clic droit > Réinitialiser le mot de passe
4. entrer un mot de passe temporaire
5. demander le changement au prochain login
6. déverrouiller le compte si nécessaire
7. valider

## Validation

L'utilisateur ouvre sa session avec le mot de passe temporaire et le change lorsque demandé.

## Catégorie

Authentification / Active Directory