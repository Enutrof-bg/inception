#!/bin/bash
set -e

if [ ! -f /var/www/html/index.php ]; then
    tmp_dir="$(mktemp -d)"
    curl -fsSL https://wordpress.org/latest.tar.gz -o "$tmp_dir/wordpress.tar.gz"
    tar -xzf "$tmp_dir/wordpress.tar.gz" -C "$tmp_dir"
    cp -a "$tmp_dir/wordpress/." /var/www/html/
    rm -rf "$tmp_dir"
fi

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

mkdir -p /run/php

exec php-fpm -F