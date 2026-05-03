# Mode Opératoire - Borne Interactive NutriFit

> **Auteur :** Edib Saoud
> **Date :** 03/05/2026  
> **Version :** 1.0  
> **Statut :** Validé  
> **Cible :** Utilisateur Final / Support Technique

---

## Table des Matières

1. [Guide Rapide](#1-guide-rapide)
2. [Description de la Borne](#2-description-de-la-borne)
3. [Accès et Utilisation](#3-accès-et-utilisation)
4. [Procédures Courantes](#4-procédures-courantes)
5. [Problèmes et Solutions](#5-problèmes-et-solutions)
6. [Maintenance de Base](#6-maintenance-de-base)
7. [Contacts](#7-contacts)

---

## 1. Guide Rapide

**Vous êtes nouveau ?** Voici en 30 secondes comment utiliser la borne :

1. ✅ **Lancer la VM** (depuis VirtualBox)
2. ⏳ **Attendre 30 secondes** (démarrage du système)
3. 🌐 **L'application NutriFit s'affiche automatiquement** en plein écran
4. 👆 **Utiliser la souris/tactile** pour naviguer
5. 🏠 **Aller à l'accueil** : bouton "Retour" ou "Home" dans l'app
6. 🔴 **Éteindre** : Fermer la fenêtre de la VM et choisir "Envoyer le signal d'extinction"

---

## 2. Description de la Borne

### Présentation Générale

La **Borne Interactive NutriFit** est un poste informatique spécialisé, configuré en **mode Kiosk**, c'est-à-dire qu'elle ne propose **qu'une seule application** : l'interface NutriFit.

#### Caractéristiques

| Élément | Description |
|:---|:---|
| **Type** | Écran tactile Linux Xubuntu |
| **Taille écran** | 21-24 pouces (haute résolution) |
| **Système d'exploitation** | Xubuntu 22.04 LTS (Linux) |
| **Application** | Navigateur Web en plein écran avec NutriFit |
| **Démarrage** | Automatique (~30s après allumage) |
| **Mode** | Kiosk fermé (pas d'accès aux menus système) |

### Vue Générale de la Borne

```
┌─────────────────────────────────────┐
│                                     │
│      [ÉCRAN TACTILE NutriFit]      │
│                                     │
│   ╔═══════════════════════════╗    │
│   ║  Bienvenue sur NutriFit   ║    │
│   ║                           ║    │
│   ║  [Consulter les régimes]  ║    │
│   ║  [Créer mon profil]       ║    │
│   ║  [Mes recommandations]    ║    │
│   ║                           ║    │
│   ╚═══════════════════════════╝    │
│                                     │
└─────────────────────────────────────┘
```

### Interactions avec la Machine Virtuelle

| Élément | Fonction |
|:---|:---|
| **Démarrage/Arrêt** | Géré via l'interface de VirtualBox |
| **Pointeur** | Souris de l'hôte (capturée par la VM si nécessaire) |
| **Réseau** | Interface virtuelle (Bridge ou NAT) liée à la carte réseau physique |

---

## 3. Accès et Utilisation

### Procédure de Démarrage

**Étape 1 : Allumage**
```
1. Ouvrir VirtualBox sur le poste hôte
2. Sélectionner la machine virtuelle "NutriFit_Kiosk"
3. Cliquer sur le bouton "Démarrer" (flèche verte)
```

**Étape 2 : Attendre le démarrage**
```
⏳ Durée : 30-45 secondes

Pendant ce temps :
- L'écran peut afficher un logo Xubuntu
- La borne charge le système d'exploitation
- NE PAS toucher l'écran durant cette phase
```

**Étape 3 : Accès à l'application**
```
✅ L'écran affiche automatiquement l'interface NutriFit
✅ Prêt à l'emploi (pas de login nécessaire)

Vous pouvez maintenant toucher l'écran !
```

### Utilisation de l'Application

#### Navigation Tactile

```
👆 TOUCHER
   → Appuyer avec le doigt/stylet sur un bouton
   → L'action s'exécute immédiatement

🔄 GLISSER
   → Maintenir le doigt et déplacer
   → Utile pour les listes ou galeries

🔍 ZOOM (si disponible)
   → Écarter 2 doigts pour agrandir
   → Rapprocher 2 doigts pour réduire
```

#### Actions Courantes

| Action | Comment faire ? | Résultat |
|:---|:---|:---|
| **Consulter un régime** | Toucher la carte du régime | Affiche les détails et conseils |
| **Créer un profil** | Toucher "Créer mon profil" | Formulaire de saisie (nom, âge, objectif) |
| **Voir mes recommandations** | Toucher "Mes recommandations" | Affiche les conseils personnalisés |
| **Revenir à l'accueil** | Toucher le bouton "Home" ou "< Retour" | Retour à l'écran principal |
| **Consulter l'aide** | Toucher le "?" ou "Aide" | Affiche les instructions |
| **Quitter une section** | Toucher "Retour" ou le bouton "Accueil" | Retour au menu principal |

### Procédure d'Arrêt

**Arrêt normal (Recommandé) :**
```
1. Fermer la fenêtre de la machine virtuelle (croix en haut à droite)
2. Sélectionner "Envoyer le signal d'extinction" (ACPI shutdown)
3. La VM s'éteint proprement (shutdown gracieux)

Durée totale : 5-10 secondes
```

**Arrêt d'urgence (Cas exceptionnel) :**
```
⚠️ À utiliser UNIQUEMENT si la machine ne répond plus

1. Fermer la fenêtre de la VM
2. Sélectionner "Éteindre la machine" (Coupure électrique forcée)
```

---

## 4. Procédures Courantes

### 4.1 Réinitialiser l'Application

**Cas d'usage :** L'app a planté ou affiche une erreur

```
Méthode 1 : Restart doux
├─ Appuyer le bouton "Retour" plusieurs fois
├─ Ou rafraîchir la page (si bouton disponible)
└─ L'application redémarre

Méthode 2 : Redémarrer la borne
├─ Arrêter la borne (voir section 3, Arrêt Normal)
├─ Attendre 10 secondes
├─ Rallumer la borne
└─ L'application relance automatiquement (30-45s)
```

### 4.2 Problèmes de Connexion Internet

**Cas d'usage :** "L'app dit qu'il n'y a pas de connexion"

```
Vérification 1 : Paramètres Réseau VirtualBox
├─ Vérifier dans les paramètres de la VM que la carte réseau est bien "Connectée"
├─ S'assurer que le mode d'accès est bien configuré (Bridge/NAT)
└─ Attendre 5 secondes pour reconnecter

Vérification 2 : Redémarrer la borne
├─ Arrêter la borne
├─ Attendre 10 secondes
├─ Rallumer
└─ Vérifier la connexion

Vérification 3 : Contacter le support technique
└─ Si le problème persiste, voir section 7 (Contacts)
```

### 4.3 L'Écran Ne Répond Plus

**Cas d'usage :** Tactile figé ou non-réactif

```
Étape 1 : Attendre 10 secondes
└─ Peut être une pause de chargement

Étape 2 : Toucher l'écran 1-2 fois
└─ Relancer la détection tactile

Étape 3 : Redémarrer l'application
└─ Bouton Retour ou rafraîchir

Étape 4 : Redémarrer la borne
├─ Arrêt normal (3 sec sur bouton alimentation)
├─ Attendre 10 secondes
├─ Rallumer
└─ Attendez le redémarrage complet (~45s)

Étape 5 : Si toujours bloqué → Support technique
```

### 4.4 Affichage Incorrect (Image inversée, pixelisée, etc.)

**Cas d'usage :** L'écran affiche mal

```
Vérification 1 : Câble vidéo (HDMI)
├─ Vérifier que le câble HDMI est bien branché
├─ Débrancher / Rebrancher (attendre 5s)
└─ L'écran doit redevenir normal

Vérification 2 : Résolution écran
├─ Redémarrer la borne
├─ Vérifier les paramètres d'affichage (si accessible)
└─ Contacter le support si besoin

Vérification 3 : Support technique
└─ Pas d'amélioration ? Voir section 7
```

---

## 5. Problèmes et Solutions

### Tableau de Dépannage Rapide

| Symptôme | Cause Probable | Solution |
|:---|:---|:---|
| **Borne ne s'allume pas** | Pas de courant | Vérifier branchement électrique, teste sur autre prise |
| **Écran noir après démarrage** | Mode veille | Toucher l'écran ou appuyer bouton alimentation |
| **Démarrage très lent (>60s)** | Mise à jour en cours | Laisser terminer (peut durer 5-10 min) |
| **Application ne charge pas** | Pas internet | Vérifier câble réseau (section 4.2) |
| **Écran tactile ne répond pas** | Blocage tactile / Surtension | Redémarrer borne (section 4.3) |
| **Texte minuscule / floue** | Résolution mauvaise | Contacter support (admin système) |
| **Son absent** | Volume muet | Son désactivé par défaut (normal) |
| **Application crashe** | Erreur applicative | Redémarrer la borne (section 4.1) |

### Logs d'Erreur Courants et Interprétation

**Message : "Cannot reach server"**
```
Signification : Pas de connexion internet
Action : Vérifier câble réseau et redémarrer borne
```

**Message : "Application crashed"**
```
Signification : Le navigateur a planté
Action : Redémarrer la borne (arrêt + rallumage)
```

**Message : "Please wait..."**
```
Signification : Chargement en cours
Action : Attendre 10-30 secondes, NE PAS toucher
```

---

## 6. Maintenance de Base

### Nettoyage

**Écran tactile (IMPORTANT)**
```
Fréquence : 1 fois par semaine

Matériel :
  ✓ Chiffon microfibre sec
  ✓ Eau déminéralisée (si nécessaire)
  ✗ Produits chimiques agressifs
  ✗ Solvants

Procédure :
  1. Éteindre la borne (bouton 3 sec)
  2. Attendre 5 minutes (refroidissement)
  3. Essuyer délicatement l'écran (mouvements circulaires)
  4. Laisser sécher 1 minute
  5. Rallumer la borne
```

**Carcasse et ventilation**
```
Fréquence : 1 fois par mois

  1. Éteindre la borne
  2. Attendre 10 minutes
  3. Essuyer la carcasse avec chiffon doux
  4. Vérifier qu'aucune prise d'air n'est bouchée
  5. Rallumer
```

### Vérifications Régulières

**Quotidien (avant utilisation)**
```
  ✓ La borne démarre-t-elle ?
  ✓ L'écran répond-il au toucher ?
  ✓ L'application NutriFit charge-t-elle ?
  ✓ Pas de messages d'erreur ?
```

**Hebdomadaire**
```
  ✓ Nettoyage de l'écran (voir ci-dessus)
  ✓ Vérification câbles réseau (bien branchés ?)
  ✓ Écoute : bruit anormal de ventilation ?
```

**Mensuel**
```
  ✓ Nettoyage carcasse
  ✓ Vérification de l'espace disque (contact admin si besoin)
  ✓ Test complet de toutes les fonctionnalités
```

### Documentation de Maintenance

Chaque intervention doit être documentée :

```
┌─────────────────────────────────────────┐
│ JOURNAL DE MAINTENANCE - Borne NutriFit │
├─────────────────────────────────────────┤
│ Date       : ________________           │
│ Interv.    : ________________           │
│ Type       : ☐ Nettoyage ☐ Redémarrage│
│              ☐ Test ☐ Réparation       │
│ Observations:                           │
│ ________________                        │
│ ________________                        │
│ Signature  : ________________           │
└─────────────────────────────────────────┘
```

---

## 7. Contacts

### Support Technique Interne

**Pour les problèmes de borne :**

| Problème | Contact | Délai |
|:---|:---|:---|
| **Borne ne s'allume pas / Panne majeure** | Administrateur système | URGENT (< 1h) |
| **Écran tactile défaillant** | Administrateur système | URGENT (< 1h) |
| **Pas de connexion internet** | Administrateur réseau | 2-4h |
| **Application plante régulièrement** | Équipe SLAM (développement) | 24h |
| **Question sur l'utilisation** | Support niveau 1 | 2-4h |

**Contacts :**
```
Administrateur Système (SISR)
  📧 admin@iriesmediaschool.fr
  📞 +33 (0) 1 XX XX XX XX
  📍 Bâtiment A, Bureau 102

Équipe SLAM (Développement)
  📧 slam@iriesmediaschool.fr
  📍 Bâtiment B, Laboratoire Informatique

Support Niveau 1 (Accueil)
  📞 +33 (0) 1 XX XX XX 00
  📧 support@iriesmediaschool.fr
```

### Processus de Signalement

**Étape 1 : Décrire le problème**
```
Exemple :
  - Borne allumée depuis ce matin : OK
  - Écran tactile ne répond plus depuis 10:30
  - Redémarrage fait, toujours bloqué
  - Heure actuelle : 11:45
```

**Étape 2 : Contact support (email ou téléphone)**
```
Joindre un technicien avec :
  ✓ Nom / Localisation de la borne
  ✓ Heure exacte du problème
  ✓ Actions déjà effectuées
  ✓ Votre numéro de téléphone
```

**Étape 3 : Intervention**
```
Le support prendra une action :
  → Remise en marche à distance (si possible)
  → Intervention sur site
  → Remplacement temporaire (si nécessaire)
```

### Heures d'Ouverture Support

```
Lundi - Vendredi   : 08:00 - 18:00
Samedi - Dimanche  : Fermé (urgence : 06 XX XX XX XX)
Jours fériés       : Fermé
```

---

## Aide-Mémoire Rapide

**À imprimer et afficher près de la borne :**

```
🔴 BORNE NUTRFIT - AIDE RAPIDE 🔴

✅ DÉMARRAGE
   → Appuyer 1 sec sur le bouton (bas-droit)
   → Attendre 30-45 sec
   → L'app se lance automatiquement

👆 UTILISATION
   → Toucher l'écran pour naviguer
   → Glisser pour scroller
   → Bouton "Retour" pour aller au menu

❌ ÇA NE MARCHE PAS ?
   → Appuyer 3 sec sur le bouton (arrêt)
   → Attendre 10 sec
   → Appuyer 1 sec (redémarrage)
   → Encore bloqué ? → Appelez le support

📞 SUPPORT : +33 1 XX XX XX 00
```

---

**Document créé par :** Edib Saoud pour le BTS SIO  
**Dernière mise à jour :** 03/05/2026  
**Validé par :** Edib Saoud  
**Prochaine révision :** 03/06/2026
