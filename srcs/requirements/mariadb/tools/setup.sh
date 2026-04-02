#!/bin/bash
set -e

echo "Database: init script running"

mkdir -p /run/mysqld 
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/${MARIADB_DATABASE} ]; then
	service mariadb start

	until mariadb-admin ping > dev/null 2>&1; do
		echo "Waiting for MariaDB to be available..."
		sleep 2
	done

	echo "Database: MariaDB is available, setting up database and user"
	mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"

	echo "Database: Creating user ${MARIADB_USER}"
	mariadb -e "CREATE USER IF NOT EXISTS \`${MARIADB_USER}\`@'%' IDENTIFIED BY '$(cat /run/secrets/wp_password)';"

	echo "Database: Granting privileges to user ${MARIADB_USER} on database ${MARIADB_DATABASE}"
	mariadb -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${MARIADB_USER}\`@'%';"

	echo "Database: Flushing privileges"
	mariadb -e "FLUSH PRIVILEGES;"

	echo "Database: Setting root password"
	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/root_password)';"

	echo "Database: Setup complete, shutting down MariaDB"
	mysqladmin -u root -p$(cat /run/secrets/root_password) shutdown

	echo "Database: Starting MariaDB in safe mode"
fi

exec mysqld_safe

echo "Database: end of script"