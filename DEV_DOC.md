# DEV_DOC

## 1) Project overview

This repository provides a Docker Compose stack with:

- `mariadb`: MariaDB
- `wordpress`: WordPress + PHP-FPM
- `nginx`: HTTPS web server

Compose file: `srcs/docker-compose.yml`.

## 2) Prerequisites

Install:

- Docker Engine
- Docker Compose plugin (`docker compose`)
- GNU Make

Recommended quick checks:

```bash
docker --version
docker compose version
docker run hello-world
```

## 3) Initial setup (from scratch)

1. Go to project root.
2. Ensure secrets exist in `secrets/`:
	- `root_password.txt`
	- `wp_password.txt`
	- `user_password.txt`
	- `jojo_password.txt`
3. Verify environment values in `srcs/.env`.
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
4. Run:

```bash
make build
make up
```

The `Makefile` creates host data directories before startup:

- `/home/kevwang/data/mariadb`
- `/home/kevwang/data/wordpress`

## 4) Build and launch workflow

Available Make targets:

- `make build`: build images
- `make up`: start services in detached mode
- `make down`: stop and remove services
- `make restart`: restart stack (`down` then `up`)
- `make clean`: remove stack and wipe persisted data folders
- `make rebuild`: full reset + rebuild + up

## 5) Useful container/volume commands

```bash
docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs
docker compose -f srcs/docker-compose.yml down -v
docker volume ls
docker volume inspect db_data
docker volume inspect wp_data
```

## 6) Persistence model

The stack uses **named volumes with local driver bind options**:

- `db_data` -> `/home/kevwang/data/mariadb`
- `wp_data` -> `/home/kevwang/data/wordpress`

So volume names exist in Docker, but actual storage is on host paths.

## 7) Service checks and debugging

Basic checks:

```bash
docker ps
docker logs db
docker logs wordpress
docker logs nginx
docker exec db sh -lc 'mysqladmin -u root -p"$(cat /run/secrets/root_password)" ping'
```

If MariaDB fails after changing volume configuration,
run `make rebuild` to reset containers, volumes, and host data directories

## 8) Access points

- Public site: `https://kevwang.42.fr`
- Admin panel: `https://kevwang.42.fr/wp-admin`