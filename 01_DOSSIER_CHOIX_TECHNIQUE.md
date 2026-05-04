# Dossier de Choix Technique - Borne Interactive NutriFit (Mode Kiosk)

> **Auteur :** Edib Saoud
> **Date :** 03/05/2026  
> **Version :** 1.0  
> **Statut :** Validé

---

## 1. Contexte et Objectif

### Situation
Mise en place d'une borne interactive dédiée au service NutriFit dans le contexte d'un **projet inter-spécialités BTS SIO** (SISR/SLAM). La borne doit être déployée en libre-service dans un environnement public (école, établissement de santé, etc.).

### Problématique
Comment concevoir une borne interactive qui soit :
- **Stable** : Fonctionnement continu sans intervention
- **Sécurisée** : Impossible d'accéder au système d'exploitation pour l'utilisateur
- **Simple** : Lancement automatique de l'application au démarrage
- **Maintenable** : Facile à restaurer en cas de problème

### Besoin Exprimé
- Affichage de l'application métier NutriFit en plein écran
- Aucun accès au bureau ou aux paramètres système
- Autonomie maximale (démarrage automatique)
- Empêcher les comportements malveillants ou accidentels

---

## 2. Analyse des Solutions

### Benchmark Comparatif

| **Critère** | **Windows Embedded** | **Xubuntu + Chromium** | **RaspberryPI (Linux Lite)** |
|:---|:---:|:---:|:---:|
| **Coût licence** | 200€+ par poste | Gratuit (Open Source) | ✅ Gratuit |
| **Facilité d'installation** | Complexe (licence) | ✅ Simple (ISO standard) | ✅ Simple |
| **Performance** | ✅ Optimisée | ✅ Bonne | Limitée (ARM) |
| **Sécurité natif** | ✅ Bonne | Bonne | Bonne |
| **Mode Kiosk** | Native | ✅ Via Chromium | Via navigateur |
| **Flexibilité** | Rigide | ✅ Très flexible | Rigide (peu de ressources) |
| **Support technique** | Payant Microsoft | ✅ Communauté active | Communauté réduite |
| **Configuration matériel** | x86-64 requis | ✅ Compatible tous poste | ARM limité |
| **Stabilité à long terme** | ✅ Très bonne | ✅ Très bonne | Acceptable |
| **Temps de démarrage** | ~60s | ✅ ~30s | ~45s |
| **CHOIX** | | **RETENU** | |

### Justification du Choix : Xubuntu + Chromium Kiosk

**Avantages critiques :**
1. **Coût zéro** : Pas de licence, avantage décisif pour une PME/école
2. **Flexibilité** : Possibilité de customiser complètement le système
3. **Sécurité renforcée** : Restrictions granulaires par session utilisateur
4. **Performance** : Très stable sur du matériel standard (x86-64)
5. **Déploiement facile** : Image ISO standard, scripts Bash pour automation
6. **Support de l'application métier** : Chromium compatible avec la web app NutriFit

**Points d'attention gérés :**
- ❌ Apprentissage Linux léger → Documenté pour maintenance
- ❌ Pas de watchdog natif → Relance manuelle à valider
- ❌ Nécessite hardening → Procédure de sécurisation incluse

---

## 3. Architecture Globale

### Architecture Cible

```
┌─────────────────────────────────────┐
│      Borne Interactive NutriFit     │
│     (Xubuntu 22.04 LTS / x86-64)    │
├─────────────────────────────────────┤
│  Niveau Virtualisation              │
│  └─ Machine Virtuelle VirtualBox    │
│     (2 vCPU, 4GB RAM, 20GB Disque)  │
├─────────────────────────────────────┤
│  Système d'Exploitation             │
│  └─ Xubuntu Desktop (XFCE)          │
│     └─ Utilisateur dédié: nutrifit  │
├─────────────────────────────────────┤
│  Mode Kiosk                         │
│  └─ Session verrouillée             │
│     └─ Autostart : Chromium         │
│        └─ Plein écran + URL fixe    │
├─────────────────────────────────────┤
│  Application Métier (Web)           │
│  └─ http://localhost:8080/nutrifit  │
│  └─ ou URL distante sécurisée       │
└─────────────────────────────────────┘
```

---

## 4. Pré-requis Matériels et Logiciels

### Configuration Machine Virtuelle (VirtualBox)

| Composant | Spécification | Justification |
|:---|:---:|:---|
| **Hyperviseur** | Oracle VM VirtualBox | Gratuit, facile à déployer pour la maquette |
| **vCPU** | 2 cœurs | Suffisant pour faire tourner Chromium fluidement |
| **Mémoire RAM** | 4 GB | Recommandé pour Xubuntu + navigateur web |
| **Stockage** | 20 GB (Allocation dynamique) | Suffisant pour l'OS et les applications |
| **Réseau** | Accès par pont (Bridge) ou NAT | Permet l'accès internet et SSH depuis l'hôte |
| **Affichage** | 128 MB VRAM, accélération 3D | Pour la fluidité de l'interface graphique |

### Dépendances Logicielles

```
Xubuntu 22.04 LTS (Jammy)
├─ Chromium Browser (>= v100)
├─ XFCE Desktop Environment
├─ lightdm (session manager)
├─ Bash Shell (scripts automation)
└─ openssh-server (maintenance distante)
```

---

## 5. Risques et Mitigation

| **Risque** | **Impact** | **Probabilité** | **Traitement** |
|:---|:---:|:---:|:---|
| Contournement du mode Kiosk (Alt+Tab, Alt+F2) | Élevé | Faible | Désactivation des raccourcis système, restrictions session |
| Crash navigateur Chromium | Moyen | Moyen | Redémarrage manuel de la session (procédure validée) |
| Perte d'affichage (écran noir, déconnexion) | Élevé | Faible | Test de stabilité sur 48h, procédure de restauration snapshot |
| Accès SSH compromis | Très élevé | Très faible | SSH réservé admin, clé d'accès, firewall local |
| Dérive de configuration (updates système) | Moyen | Faible | Gel des mises à jour critiques, documentation de base |

---

## 6. Éléments de Sécurité Implémentés

- ✅ **Restriction de session** : Utilisateur dédié `nutrifit` sans droits sudo
- ✅ **Verrouillage bureau** : Pas d'accès au gestionnaire de fichiers ou terminal
- ✅ **Désactivation raccourcis clavier** : Alt+Tab, Ctrl+Alt+T, Super clé
- ✅ **Mode Chromium full-screen** : Barre d'adresse, boutons cachés
- ✅ **Autostart controlé** : Lancement automatique via fichier `.desktop` sécurisé
- ✅ **Firewall local** : Accès SSH restreint à l'adresse admin
- ✅ **Snapshots** : Sauvegarde rapide de l'état de la VM en cas de problème

---

## 7. Livrables et Maintenance

### Fichiers Fournis
1. **Procédure d'Installation** (`02_PROCEDURE_INSTALLATION.md`) → Technicien SISR
2. **Guide Utilisateur** (`03_MODE_OPERATOIRE.md`) → Support technique
3. **Snapshots de la VM** (VirtualBox) → Restauration rapide
4. **Scripts Bash** (autostart, restore) → Automation

### Contrats d'Exploitation
- **Démarrage** : < 45 secondes
- **MTBF** (Mean Time Between Failures) : > 720 heures (1 mois)
- **RTO** (Recovery Time Objective) : < 1 minute (restauration de Snapshot)
- **Disponibilité cible** : 99% durant heures d'exploitation

---

## 8. Conclusion

La solution **Xubuntu + Chromium Kiosk** répond à tous les critères fonctionnels et économiques :
- ✅ **Économique** : Coût zéro en licence
- ✅ **Technique** : Stable, sécurisée, facile à maintenir
- ✅ **Opérationnelle** : Démarrage < 45s, prête pour libre-service
- ✅ **Maintenable** : Documentation et scripts fournis

**Décision** : Solution approuvée et déployée en production pour le projet NutriFit.

---
