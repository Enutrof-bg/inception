#!/bin/bash
set -e

echo "WordPress: Waiting for MariaDB..."
until mariadb-admin ping -h"mariadb" -P"3306" -u"$WORDPRESS_DB_USER" -p"$(cat /run/secrets/wp_password)" > /dev/null 2>&1; do
	sleep 2
done
echo "WordPress: MariaDB is ready"

echo "WordPress: Configuring WordPress"
if [ ! -f /var/www/html/wp-config.php ]; then
	wp core download --allow-root --path=/var/www/html
	echo "WordPress: Creating wp-config.php"
	wp config create --allow-root \
		--skip-check \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$(cat /run/secrets/wp_password)" \
		--dbhost="$WORDPRESS_DB_HOST"
fi


if ! wp core is-installed --allow-root --path=/var/www/html > /dev/null 2>&1; then
	echo "WordPress: Installing WordPress"
	wp core install --path=/var/www/html --url="$DOMAIN_NAME" \
					--title="$SITE_TITLE" \
					--admin_user="$ADMIN_USER" \
					--admin_password="$(cat /run/secrets/user_password)" \
					--admin_email="$ADMIN_EMAIL" \
					--locale=fr_FR \
					--allow-root
fi

if ! wp user get "$JOJO_USER" --allow-root --path=/var/www/html > /dev/null 2>&1; then
	echo "WordPress: Creating user"
	wp user create "$JOJO_USER" "$JOJO_EMAIL" --user_pass="$(cat /run/secrets/jojo_password)" --role=author --allow-root --path=/var/www/html
fi

mkdir -p /run/php

echo "WordPress: Setup complete, starting PHP-FPM"
exec php-fpm -F
