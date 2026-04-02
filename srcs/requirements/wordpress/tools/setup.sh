#!/bin/bash
set -e

export WORDPRESS_DB_PASSWORD="$(cat /run/secrets/wp_password)"

if [ ! -f /var/www/html/index.php ]; then
    tmp_dir="$(mktemp -d)"
    curl -fsSL https://wordpress.org/latest.tar.gz -o "$tmp_dir/wordpress.tar.gz"
    tar -xzf "$tmp_dir/wordpress.tar.gz" -C "$tmp_dir"
    cp -a "$tmp_dir/wordpress/." /var/www/html/
    rm -rf "$tmp_dir"
fi

wp core download --locale=fr_FR --allow-root --force

# if [ ! -f /var/www/html/wp-config.php ]; then
	wp config create --allow-root \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$WORDPRESS_DB_PASSWORD" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --force
# fi

# wp core install --title=$SITE_TITLE \
#                 --admin_user=$ADMIN_USER \
#                 --admin_password=$(cat /run/secrets/user_password) \
#                 --admin_email=$ADMIN_EMAIL \
#                 --locale=fr_FR \
#                 --allow-root \
# 				--url=$DOMAIN_NAME \

# wp user create $ADMIN_USER $ADMIN_EMAIL --user_pass=$(cat /run/secrets/user_password) --allow-root

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

mkdir -p /run/php

exec php-fpm -F