#!/bin/bash

# Récupérer l'adresse IP publique
CLOUD9_IP=$(curl -s ifconfig.me)

# Retourner un JSON valide
echo "{\"cloud9_ip\": \"$CLOUD9_IP\"}"

