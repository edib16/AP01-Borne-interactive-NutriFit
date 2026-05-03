#!/bin/bash
# Script de lancement Chromium en mode Kiosk
# Attendre que le serveur X soit disponible
sleep 2

# Lancer Chromium en mode kiosk
chromium-browser \
  --new-window \
  --start-fullscreen \
  --no-first-run \
  --no-default-browser-check \
  --disable-background-networking \
  --disable-breakpad \
  --disable-client-side-phishing-detection \
  --disable-component-extensions-with-background-pages \
  --disable-default-apps \
  --disable-device-discovery-notifications \
  --disable-extensions \
  --disable-features=TranslateUI \
  --disable-sync \
  --enable-features=NetworkService,NetworkServiceInProcess \
  --metrics-recording-only \
  --mute-audio \
  --no-default-browser-check \
  --no-pings \
  "http://localhost:80/nutrifit"
