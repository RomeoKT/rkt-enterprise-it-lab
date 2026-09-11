# KB-003 — Diagnostiquer une imprimante réseau

## Symptôme

L'imprimante apparaît hors ligne ou les travaux ne s'impriment pas.

## Vérifications

1. vérifier que l'imprimante est allumée et connectée
2. vérifier son adresse IP
3. tester avec ping adresse_IP
4. ouvrir Paramètres > Bluetooth et appareils > Imprimantes et scanners
5. vérifier la bonne imprimante
6. vérifier la file d'impression
7. vérifier le service avec Get-Service Spooler
8. vérifier que le port correspond à la bonne adresse IP

## Validation

- imprimante en ligne
- page de test imprimée

## Catégorie

Périphérique / Imprimante