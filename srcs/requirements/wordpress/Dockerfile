FROM debian:bookworm

RUN set -eux; \
	apt-get update; \
	apt-get install -y php-fpm php-mysql php-mysqli; \
	php_fpm_bin="$(command -v php-fpm || ls /usr/sbin/php-fpm* | head -n 1)"; \
	php_fpm_conf="$(find /etc/php -path '*/fpm/pool.d/www.conf' | head -n 1)"; \
	sed -ri 's|^listen\s*=.*$|listen = 9000|' "$php_fpm_conf"; \
	ln -sf "$php_fpm_bin" /usr/local/sbin/php-fpm; \
	rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    wget \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*
    
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 9000

ENTRYPOINT ["setup.sh"]
# CMD ["php-fpm", "-F"]