#!/bin/bash
set -e

echo "Database: init script running"

service mariadb start

# mysql --help
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`
EOSQL

# mysql -v ON_ERROR_STOP=1 -u "$MYSQL_USER" -D "$MYSQL_DATABASE" <<-'EOSQL'

# CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
# # CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';







# mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# mysql -u root -p${MYSQL_ROOT_PASSWORD}

# exec mysqld_safe
exec mysql

echo "Database: end of script"