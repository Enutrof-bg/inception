#!/bin/bash
set -e


if [ ! -f /var/www/html/index.php ]; then
	echo "WordPress: Downloading and setting up WordPress files"
    tmp_dir="$(mktemp -d)"
    curl -fsSL https://wordpress.org/latest.tar.gz -o "$tmp_dir/wordpress.tar.gz"
    tar -xzf "$tmp_dir/wordpress.tar.gz" -C "$tmp_dir"
    cp -a "$tmp_dir/wordpress/." /var/www/html/
    rm -rf "$tmp_dir"
fi

echo "WordPress: Configuring WordPress"
wp core download --locale=fr_FR --allow-root --force

# if [ ! -f wp-config.php ]; then
	echo "WordPress: Creating wp-config.php"
	wp config create --allow-root \
    --dbname="$WORDPRESS_DB_NAME" \
    --dbuser="$WORDPRESS_DB_USER" \
    --dbpass="$(cat /run/secrets/wp_password)" \
    --dbhost="$WORDPRESS_DB_HOST" \
    --force
# fi

# if [ ! wp core is-installed --allow-root ]; then
	echo "WordPress: Configuring WordPress"
	wp core install --url=$DOMAIN_NAME \
					--title=$SITE_TITLE \
					--admin_user=$ADMIN_USER \
					--admin_password=$(cat /run/secrets/user_password) \
					--admin_email=$ADMIN_EMAIL \
					--locale=fr_FR \
					--allow-root
# fi

if ! wp user get $JOJO_USER --allow-root > /dev/null 2>&1; then
	echo "WordPress: Creating user"
	wp user create $JOJO_USER $JOJO_EMAIL --user_pass=$(cat /run/secrets/jojo_password) --role=author --allow-root
fi

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html
mkdir -p /run/php

echo "WordPress: Setup complete, starting PHP-FPM"
exec php-fpm -F