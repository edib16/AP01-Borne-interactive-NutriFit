# Procédure d'Installation et Configuration - Borne Kiosk NutriFit

> **Auteur :** Edib Saoud
> **Date :** 03/05/2026  
> **Version :** 1.0  
> **Statut :** Validé  
> **Cible :** Technicien SISR / Administrateur Système

---

## Table des Matières

1. [Pré-requis](#1-pré-requis)
2. [Architecture Réseau](#2-architecture-réseau)
3. [Installation du Système de Base](#3-installation-du-système-de-base)
4. [Configuration du Mode Kiosk](#4-configuration-du-mode-kiosk)
5. [Sécurisation](#5-sécurisation)
6. [Procédures de Maintenance](#6-procédures-de-maintenance)

---

## 1. Pré-requis

### Configuration de la Machine Virtuelle (VirtualBox)

| Paramètre | Requis | Recommandé |
|:---|:---:|:---:|
| **vCPU** | 1 cœur | 2 cœurs |
| **RAM** | 2 GB | 4 GB |
| **Stockage** | 15 GB | 20 GB (Allocation dynamique) |
| **Réseau** | NAT | Accès par pont (Bridge) |
| **Affichage** | 64 MB VRAM | 128 MB VRAM + Accélération 3D |

### Dépendances Logicielles

```
- Xubuntu 22.04 LTS (Image ISO)
- Chromium Browser (v100+)
- XFCE Desktop Environment
- lightdm (Login Manager)
- openssh-server (administration distante)
```

### Éléments à Préparer

- [ ] Oracle VM VirtualBox installé sur le poste hôte
- [ ] Fichier ISO de Xubuntu 22.04 LTS téléchargé
- [ ] Au moins 20 Go d'espace disque disponible sur l'hôte
- [ ] Documentation de base (ce fichier)

---

## 2. Architecture Réseau

### Schéma Réseau Détaillé

```
┌─────────────────────────────────────────────────────┐
│         Réseau Local de l'Établissement              │
│  (Firewall / Switch / DHCP Server)                   │
└──────────────────┬──────────────────────────────────┘
                   │
                   │ Ethernet (statique ou DHCP)
                   │
        ┌──────────▼──────────┐
        │  Machine Virtuelle  │
        │  - IP: 192.168.X.Y  │
        │  - Hostname: kiosk  │
        │  - SSH: Port 22     │
        └──────────┬──────────┘
                   │
        ┌──────────▼──────────┐
        │ Application NutriFit│
        │ http://localhost:80 │
        │ ou URL distante     │
        └─────────────────────┘
```

### Configuration Réseau de la Borne

**Méthode 1 : DHCP (Recommandée)**
```bash
# Accès à internet automatique, IP assignée par le routeur
# Configuration effectuée lors de l'installation
```

**Méthode 2 : IP Statique (Alternative)**
```bash
# Si accès DHCP indisponible
# À configurer après installation (voir section 3.5)
```

---

## 3. Installation du Système de Base

### Phase 1 : Préparation de la Machine Virtuelle

#### Étape 1.1 : Créer la VM dans VirtualBox

1. Ouvrir VirtualBox et cliquer sur **Nouvelle**
2. Nom : `NutriFit_Kiosk` | Type : `Linux` | Version : `Ubuntu (64-bit)`
3. Allouer **4096 MB** de mémoire vive (RAM)
4. Créer un disque dur virtuel de **20 Go** (VDI, dynamiquement alloué)
5. Dans les paramètres (Configuration) de la VM :
   - **Système > Processeur** : 2 vCPU
   - **Affichage** : 128 MB de mémoire vidéo, activer l'accélération 3D
   - **Réseau** : Mode d'accès réseau "Accès par pont" (Bridge) pour que la VM ait sa propre IP locale

#### Étape 1.2 : Attacher l'ISO et démarrer

1. Dans **Configuration > Stockage**, cliquer sur l'icône de CD vide
2. Choisir un fichier de disque et sélectionner le fichier ISO de Xubuntu 22.04 LTS
3. Démarrer la machine virtuelle

### Phase 2 : Installation de Xubuntu

#### Étape 2.1 : Lancer l'installateur Xubuntu

1. Le menu de démarrage de l'ISO s'affiche
2. Sélectionner **"Install Xubuntu"**
3. Choisir la langue : **Français**
4. Cliquer **"Continuer"**

#### Étape 2.2 : Partitionnement du disque

1. **Type de partitionnement** : **Effacer le disque et installer Xubuntu**
2. Sélectionner le disque cible (vérifier : `/dev/sda` ou `/dev/nvme0n1` selon SSD)
3. ⚠️ **ATTENTION** : Cette action efface toutes les données !
4. Confirmer et continuer

#### Étape 2.3 : Configuration d'installation

**Localisation :**
- Fuseau horaire : **Europe/Paris**
- Format langue : **Français**

**Utilisateur principal :**
- Nom complet : `Administrator`
- Nom d'utilisateur : `admin`
- Mot de passe : **[À définir - forte recommandation : mélange majuscules, minuscules, chiffres, symboles]**
- ✅ Se connecter automatiquement : **Non** (décocher)

#### Étape 2.4 : Attendre l'installation

- Durée estimée : 15-20 minutes
- Ne PAS éteindre la machine
- À la fin, retirer l'ISO des périphériques de stockage et redémarrer

---

### Phase 3 : Post-Installation Système

#### Étape 3.1 : Première connexion

```bash
# Connexion avec les identifiants créés
Username: admin
Password: [Votre mot de passe]
```

#### Étape 3.2 : Mettre à jour le système

```bash
# Ouvrir un terminal (Ctrl+Alt+T)
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
```

#### Étape 3.3 : Installer les paquets nécessaires

```bash
# Installation de Chromium et dépendances
sudo apt install -y chromium-browser xfce4-panel-profiles lightdm openssh-server

# Installation d'outils additionnels (optionnel mais recommandé)
sudo apt install -y net-tools htop curl wget
```

#### Étape 3.4 : Activer SSH (accès admin distante)

```bash
# Démarrer le service SSH
sudo systemctl start ssh
sudo systemctl enable ssh

# Vérifier le statut
sudo systemctl status ssh
```

#### Étape 3.5 : Configurer l'adresse IP (si statique nécessaire)

```bash
# Éditer le fichier de configuration réseau
sudo nano /etc/netplan/01-netcfg.yaml
```

**Contenu pour IP Statique :**
```yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - 192.168.1.100/24
      routes:
        - to: 0.0.0.0/0
          via: 192.168.1.1
      nameservers:
        addresses: [8.8.8.8, 8.8.4.4]
```

Appliquer les changements :
```bash
sudo netplan apply
ip addr show  # Vérifier la nouvelle IP
```

---

## 4. Configuration du Mode Kiosk

### Phase 1 : Créer l'utilisateur dédié

#### Étape 1.1 : Créer l'utilisateur "nutrifit"

```bash
# En tant qu'admin
sudo useradd -m -s /bin/bash nutrifit
sudo passwd nutrifit
# Définir un mot de passe simple (ex: nutrifit123)

# Ajouter à des groupes pour fonctionnalités limitées
sudo usermod -aG audio,video nutrifit
```

#### Étape 1.2 : Configurer le répertoire home

```bash
# Créer la structure de base
sudo -u nutrifit mkdir -p /home/nutrifit/.config/chromium
sudo -u nutrifit mkdir -p /home/nutrifit/.local/share/applications
```

### Phase 2 : Configurer Chromium en mode Kiosk

#### Étape 2.1 : Créer le fichier de démarrage de Chromium

```bash
# Créer un script de lancement
sudo nano /usr/local/bin/start-chromium-kiosk.sh
```

**Contenu du script :**
*(Copier le fichier `scripts/start-chromium-kiosk.sh` vers `/usr/local/bin/`)*
```bash
sudo cp scripts/start-chromium-kiosk.sh /usr/local/bin/start-chromium-kiosk.sh
```

**Rendre exécutable :**
```bash
sudo chmod +x /usr/local/bin/start-chromium-kiosk.sh
```

#### Étape 2.2 : Configurer l'autostart

```bash
# Créer le fichier de démarrage automatique
sudo nano /home/nutrifit/.config/autostart.desktop
```

**Contenu :**
*(Copier le fichier `scripts/autostart.desktop`)*
```bash
sudo cp scripts/autostart.desktop /home/nutrifit/.config/autostart.desktop
```

**Permissions :**
```bash
sudo chown nutrifit:nutrifit /home/nutrifit/.config/autostart.desktop
sudo chmod 755 /home/nutrifit/.config/autostart.desktop
```

#### Étape 2.3 : Ajouter au lanceur automatique XFCE

```bash
# Créer le fichier dans autostart XFCE
sudo nano /home/nutrifit/.config/autostart/chromium-kiosk.desktop
```

**Contenu :**
*(Copier le fichier `scripts/chromium-kiosk.desktop`)*
```bash
sudo cp scripts/chromium-kiosk.desktop /home/nutrifit/.config/autostart/chromium-kiosk.desktop
```

```bash
sudo chown nutrifit:nutrifit /home/nutrifit/.config/autostart/chromium-kiosk.desktop
sudo chmod 755 /home/nutrifit/.config/autostart/chromium-kiosk.desktop
```

### Phase 3 : Configurer la session de connexion automatique

#### Étape 3.1 : Modifier la configuration lightdm

```bash
sudo nano /etc/lightdm/lightdm.conf
```

**Uncomment et modifier :**
```ini
# Autologin
autologin-user=nutrifit
autologin-user-timeout=0
autologin-session=xfce
```

---

## 5. Sécurisation

### Phase 1 : Restrictions de session utilisateur

#### Étape 1.1 : Désactiver les raccourcis système dangereux

```bash
# Éditer la configuration XFCE de l'utilisateur nutrifit
sudo nano /home/nutrifit/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

**À désactiver (ajouter/modifier) :**
```xml
<!-- Désactiver Alt+Tab -->
<property name="switch_window_key" type="empty"/>

<!-- Désactiver Alt+F2 (Exécuter) -->
<property name="run_key" type="empty"/>

<!-- Désactiver Super clé -->
<property name="show_desktop_key" type="empty"/>

<!-- Désactiver Ctrl+Alt+T (Terminal) -->
<property name="launch_terminal_key" type="empty"/>
```

#### Étape 1.2 : Masquer la barre de tâches

```bash
# Éditer la configuration du panneau XFCE
sudo nano /home/nutrifit/.config/xfce4/panel/panelrc
```

**Configuration minimale :**
```ini
[General]
Monitors=
WindowManagerWarningShown=true

# Panneau caché en auto-hide
AutoHide=true
```

#### Étape 1.3 : Restreindre l'accès au gestionnaire de fichiers

```bash
# Désinstaller les gestionnaires de fichiers (optionnel)
sudo apt remove -y thunar pcmanfm

# OU masquer l'icône du menu
# À configurer manuellement via le panneau XFCE
```

### Phase 2 : Firewall et Accès Réseau

#### Étape 2.1 : Configurer le firewall ufw

```bash
# Installer ufw
sudo apt install -y ufw

# Configurer le firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Autoriser SSH (admin uniquement)
sudo ufw allow from 192.168.1.0/24 to any port 22
sudo ufw allow from 192.168.1.1 to any port 22  # Routeur

# Activer le firewall
sudo ufw enable

# Vérifier le statut
sudo ufw status
```

#### Étape 2.2 : Restreindre les droits sudoers

```bash
# Vérifier que "nutrifit" ne peut PAS utiliser sudo
sudo visudo

# S'assurer que "nutrifit" n'apparaît pas
# (Seulement "admin" doit avoir accès sudo)
```

### Phase 3 : Snapshots VirtualBox

#### Étape 3.1 : Créer un Snapshot de la VM

```text
# À exécuter sur l'hôte après finalisation du système
1. Éteindre la machine virtuelle proprement.
2. Dans VirtualBox, aller dans le menu "Snapshots" (ou "Instantanés").
3. Cliquer sur "Prendre" (Take).
4. Nommer le snapshot (ex: "NutriFit_Prod_V1").
5. Ce snapshot permettra de restaurer la VM en 1 clic en cas de crash.
```

#### Étape 3.2 : Documenter la configuration

```bash
# Sauvegarder les configurations clés
sudo cp /etc/lightdm/lightdm.conf /home/admin/backup/
sudo cp /home/nutrifit/.config/autostart/* /home/admin/backup/
sudo cp /usr/local/bin/start-chromium-kiosk.sh /home/admin/backup/
```

---

*Note : Les tests de validation se trouvent désormais dans le document dédié `04_CAHIER_DE_RECETTE.md`.*

---

## 6. Procédures de Maintenance

### Maintenance Courante

#### Mise à jour de sécurité (tous les 3 mois)

```bash
# Connexion SSH en tant qu'admin
ssh admin@192.168.1.100

# Vérifier les mises à jour
sudo apt update
sudo apt upgrade -y

# Redémarrer si nécessaire
sudo reboot
```

#### Vérification de l'espace disque

```bash
# Vérifier l'espace disponible
df -h

# Nettoyer les caches
sudo apt autoclean
sudo apt autoremove
```

### Procédure de Restauration de Snapshot

```text
# En cas de panne critique ou drift de configuration

1. Éteindre la VM dans VirtualBox.
2. Aller dans l'onglet "Snapshots" de la VM.
3. Sélectionner le snapshot "NutriFit_Prod_V1".
4. Cliquer sur "Restaurer" (Restore).
5. Démarrer la VM.
# Durée : < 1 minute
```

### Logs Importants

```bash
# Journaux système
sudo journalctl -u lightdm  # Logs de démarrage
sudo journalctl -u ssh      # Logs SSH
journalctl -u user@*        # Logs utilisateur
dmesg                       # Logs noyau
```

---

## Checklist Finale

- [ ] Xubuntu 22.04 LTS installé et à jour
- [ ] Utilisateur "nutrifit" créé
- [ ] Chromium Kiosk configuré et autostart fonctionnel
- [ ] Raccourcis système désactivés
- [ ] SSH actif et restreint par firewall
- [ ] Tests de validation T1-T10 réussis
- [ ] Snapshot de restauration créé et testé
- [ ] Documentation sauvegardée
- [ ] Accès admin documenté (identifiants sécurisés)

**Validation finale :**
Technicien : _____________ Date : _______ Signature : _______

---

## Contacts et Support

- **Problème SSH** → Vérifier firewall : `sudo ufw status`
- **Chromium ne démarre pas** → Logs : `journalctl -u lightdm`
- **Restauration de snapshot** → Procédure section 6 ou contact administrateur
