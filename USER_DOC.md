# USER_DOC

## 1) What this stack provides

This project runs a small WordPress platform with 3 services:

- **nginx**: HTTPS web server
- **wordpress**: PHP-FPM + WordPress application
- **mariadb**: MariaDB database used by WordPress

## 2) Start and stop the project

From the project root:
- Start (build + run):
```bash
make up
```
- Stop containers:
```bash
make down
```
- Rebuild from scratch:
```bash
make rebuild
```

## 3) Access the website and admin panel

- Website: `https://localhost:8443`
- WordPress admin panel: `https://localhost:8443/wp-admin`

Notes:

- The certificate is self-signed, so your browser may show a security warning.
- Continue to the site if prompted.

## 4) Credentials and where to find them

Credentials are stored in the `secrets/` directory (plain text files):

- `secrets/root_password.txt` → MariaDB root password
- `secrets/wp_password.txt` → WordPress DB user password
- `secrets/user_password.txt` → WordPress admin password
- `secrets/jojo_password.txt` → Additional WordPress user password

Main non-secret values (database name, users, domain) are in `srcs/.env`:
- MARIADB_DATABASE
- MARIADB_USER
- WORDPRESS_DB_NAME
- WORDPRESS_DB_USER
- WORDPRESS_DB_HOST
- DOMAIN_NAME
- SITE_TITLE
- ADMIN_USER
- ADMIN_EMAIL
- JOJO_USER
- JOJO_EMAIL

## 5) Check that services are healthy

Use these commands from the project root:

```bash
docker ps
docker compose -f srcs/docker-compose.yml logs --tail=100
docker exec db sh -lc 'mysqladmin -u root -p"$(cat /run/secrets/root_password)" ping'
```

Expected result for the last command: `mysqld is alive`.

## 6) Data persistence

Project data is persisted on the host in:

- `/home/kevwang/data/mariadb`
- `/home/kevwang/data/wordpress`

If you run `make clean`, containers/volumes are removed and these data folders are also emptied.
