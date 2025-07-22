FROM ghcr.io/cirruslabs/flutter:3.22.1

# Étape 2 : Définir le dossier de travail dans le conteneur
WORKDIR /app

# Étape 3 : Copier les fichiers de configuration pour installer les dépendances
COPY pubspec.yaml pubspec.yaml
COPY pubspec.lock pubspec.lock

# Étape 4 : Télécharger les dépendances (si fichiers présents)
RUN flutter pub get

# Étape 5 : Copier tout le code de l'application
COPY . .

# Étape 6 : Générer les fichiers nécessaires à Flutter (facultatif mais utile)
RUN flutter pub get
RUN flutter doctor
RUN flutter build apk --release

# Étape 7 : Le conteneur démarre en mode terminal (aucun serveur à lancer ici)
CMD ["bash"]
