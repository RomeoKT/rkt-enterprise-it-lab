# KB-001 — Réinitialiser un mot de passe Active Directory

## Symptôme

L'utilisateur ne peut plus ouvrir sa session parce que son mot de passe est oublié ou expiré.

## Vérifications

1. Confirmer l'identité de l'utilisateur selon la procédure de l'organisation.
2. Vérifier que le compte existe et qu'il n'est pas désactivé.
3. Vérifier si le compte est verrouillé.

## Résolution avec ADUC

1. Ouvrir `dsa.msc`.
2. Rechercher l'utilisateur.
3. Clic droit → **Réinitialiser le mot de passe**.
4. Saisir un mot de passe temporaire.
5. Pour un compte utilisateur standard, cocher **L'utilisateur doit changer le mot de passe à la prochaine ouverture de session**.
6. Déverrouiller le compte si nécessaire.
7. Valider.

## Validation

L'utilisateur ouvre sa session avec le mot de passe temporaire et le change lorsque demandé.

## Catégorie

Authentification / Active Directory
