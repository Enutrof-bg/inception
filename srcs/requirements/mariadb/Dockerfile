FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    mariadb-server && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# COPY conf/50-server.cnf /etc/mysql/conf.d/50-server.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh
# COPY tools/init.sql /etc/mysql/init.sql

RUN chmod +x /usr/local/bin/setup.sh

# RUN mkdir -p /run/mysqld 

# RUN chmod +x /usr/local/bin/setup.sh
# RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# RUN touch /var/run/mysqld/mysqld.pid
# RUN touch /var/run/mysqld/mysqld.sock

# RUN chown -R mysql:mysql /var/run/mysqld

# EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/setup.sh"]
# CMD ["setup.sh"]

# CMD ["service", "mariadb", "start"]

# CMD ["mysqld_safe"]