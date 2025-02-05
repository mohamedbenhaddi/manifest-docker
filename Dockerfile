# Utilisation de la version de Node spécifiée
ARG NODE_VERSION=21.0.0
FROM node:${NODE_VERSION}-alpine

# Définir le répertoire de travail
WORKDIR /usr/src/app/src

# Copier uniquement package.json et package-lock.json pour optimiser le cache Docker
COPY src/package.json src/package-lock.json ./

# Vérifier que package.json est bien copié
RUN ls -la 

# Installer les dépendances
RUN npm install --only=production

# Copier le reste des fichiers après l’installation des dépendances
COPY src . 

# Copier le script d'entrée
COPY entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh
RUN chown node:node /usr/src/app/entrypoint.sh

# Exposer le port de l’application
EXPOSE 1111

# Passer à l'utilisateur non-root pour plus de sécurité

# Utiliser l'entrypoint pour exécuter le script avant de lancer l’application
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# Lancer l’application
CMD ["npm", "run", "manifest"]
