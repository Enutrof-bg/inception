FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/server.cnf /etc/mysql/mariadb.conf.d/server.cnf

COPY tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld

EXPOSE 3306

ENTRYPOINT ["setup.sh"]