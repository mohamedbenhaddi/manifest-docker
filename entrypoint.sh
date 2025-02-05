#!/bin/sh

# Vérifie si le fichier .env existe, sinon le crée
if [ ! -f .env ]; then
    touch .env
fi

# Ajoute une clé secrète si elle n'existe pas
if ! grep -q "TOKEN_SECRET_KEY=" .env; then
    echo "TOKEN_SECRET_KEY=$(openssl rand -hex 32)" >> .env
fi

# Démarrer l’application
exec "$@"