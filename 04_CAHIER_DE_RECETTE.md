# Cahier de Recette et Tests - Borne Kiosk NutriFit

> **Auteur :** Edib Saoud
> **Date :** 03/05/2026  
> **Version :** 1.0  
> **Statut :** Validé  

---

## 1. Objectifs de la Recette

L'objectif de ce document est de valider que la machine virtuelle Kiosk NutriFit répond parfaitement aux exigences de stabilité, de sécurité et d'exploitabilité définies dans le cahier des charges et le dossier de choix technique.

## 2. Tableau de Recette Technique

| N° | Test | Procédure | Résultat Attendu | Statut |
|:---|:---|:---|:---|:---:|
| **T1** | Démarrage système | Redémarrer la VM | Démarrage < 45s, connexion auto `nutrifit` | ✅ Validé |
| **T2** | Lancement Chromium | Observer après login | Chromium en plein écran, URL NutriFit affichée | ✅ Validé |
| **T3** | Navigation app | Cliquer dans l'interface | Réponse fluide, pas de lag | ✅ Validé |
| **T4** | Blocage Alt+Tab | Appuyer Alt+Tab | Pas de changement de fenêtre, bloqué | ✅ Validé |
| **T5** | Blocage Alt+F2 | Appuyer Alt+F2 | Pas d'accès "Exécuter", bloqué | ✅ Validé |
| **T6** | Blocage Ctrl+Alt+T | Appuyer Ctrl+Alt+T | Pas d'accès terminal, bloqué | ✅ Validé |
| **T7** | Accès SSH distante | SSH user@192.168.1.100 (depuis admin) | Connexion réussie | ✅ Validé |
| **T8** | Firewall SSH bloqué | SSH depuis machine non-autorisée | Connexion refusée | ✅ Validé |
| **T9** | Redémarrage stabilité | Redémarrer 5 fois consécutives | Démarrage stable, pas d'erreur | ✅ Validé |
| **T10**| Crash navigateur | Fermer Chromium manuellement | Relance automatique ou redémarrage manuel fluide | ✅ Validé |

## 3. Procédure d'exécution des tests

Pour rejouer ces tests, veuillez consulter le fichier `02_PROCEDURE_INSTALLATION.md` et les scripts d'automatisation dans le dossier `scripts/`.

Les logs système peuvent être vérifiés via :
```bash
sudo journalctl -u lightdm -n 50
sudo journalctl -u ssh -n 50
```

## 4. Conclusion de la recette

L'ensemble des tests critiques de sécurité (T4, T5, T6) et d'exploitation (T1, T2) sont validés. La machine virtuelle peut être déployée en production.
