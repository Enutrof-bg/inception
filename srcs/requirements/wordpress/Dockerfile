FROM debian:bullseye

# Installation des dépendances système
# php-fpm et php-mysql sont essentiels pour WordPress
RUN apt-get update && apt-get install -y \
    wget \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Installation de WP-CLI (L'outil magique pour configurer WP sans interface)
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Configuration de PHP-FPM pour qu'il écoute sur le port 9000
# Par défaut, il écoute sur un socket local, ce qui empêcherait Nginx de lui parler
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

# Création du dossier pour les fichiers de WordPress
WORKDIR /var/www/html

# On copie le script de configuration
COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

# On expose le port de communication
EXPOSE 9000

# Lancement du script d'initialisation
ENTRYPOINT ["setup.sh"]