# KB-003 — Diagnostiquer une imprimante réseau

## Symptôme

L'imprimante apparaît hors ligne ou les travaux ne s'impriment pas.

## Vérifications

1. Vérifier que l'imprimante est allumée et connectée au réseau.
2. Vérifier son adresse IP.
3. Tester la connectivité :

```cmd
ping <IP_IMPRIMANTE>
```

4. Ouvrir **Paramètres → Bluetooth et appareils → Imprimantes et scanners**.
5. Vérifier que le bon périphérique est sélectionné.
6. Vérifier la file d'impression.
7. Vérifier le service Print Spooler :

```powershell
Get-Service Spooler
```

8. Vérifier que le port de l'imprimante correspond à sa bonne adresse IP.

## Validation

- l'imprimante apparaît en ligne
- une page de test s'imprime correctement

## Catégorie

Périphérique / Imprimante
