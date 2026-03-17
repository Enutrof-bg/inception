#!/bin/bash

# Attendre un peu que la DB soit prête (optionnel mais recommandé)
sleep 10

if [ ! -f /var/www/html/wp-config.php ]; then
    # Téléchargement de WordPress
    wp core download --allow-root

    # Création du fichier wp-config.php
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306

    # Installation finale (Admin, mot de passe, email)
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi

# Création du dossier nécessaire pour PHP-FPM
mkdir -p /run/php

# Lancement de PHP-FPM en arrière-plan
exec /usr/sbin/php-fpm7.4 -F