This project has been created as part of the 42 curriculum by kevwang

# Inception

## Description

This project implements a small containerized infrastructure using Docker Compose.
The goal is to deploy and connect multiple services:
- **MariaDB** for storage
- **WordPress** running on PHP-FPM
- **Nginx** as the HTTPS server

## Instructions

### 1) Prerequisites

Install the tools needed:
- Docker Engine (https://docs.docker.com/engine/install/debian/)
- Docker Compose (if not installed)
- GNU Make (if not installed)

### 2) Configure environment and secrets

1. Add `srcs/.env` file and adapt env values (NAME=VALUES)
	- Must contain:
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
2. Make sure these files exist in `secrets/` folder at root:
	- `root_password.txt`
	- `wp_password.txt`
	- `user_password.txt`
	- `jojo_password.txt`

### 3) Build and run

From the repository root:

```bash
make build
make up
```

Useful commands:

```bash
make down
make restart
make clean
make rebuild
```

### 4) Access the website
Must modify /etc/hosts file to change localhost to kevwang.42.fr (must looks like this: 127.0.0.1 kevwang.42.fr)
- Website: `https://kevwang.42.fr`
- WordPress admin: `https://kevwang.42.fr/wp-admin`

## Resources

### Technical references

- Docker docs: https://docs.docker.com/
- Docker Compose docs: https://docs.docker.com/compose/
- Nginx docs: https://nginx.org/en/docs/
- MariaDB docs: https://mariadb.com/kb/en/documentation/
- WP-CLI docs: https://developer.wordpress.org/cli/commands/
- Install docker: https://docs.docker.com/engine/install/debian/

### AI usage disclosure

AI was used as an assistant for:

- proofreading and improving English wording in documentation
- clarifying Docker volume behavior (named volumes vs bind mounts)
- suggesting troubleshooting steps for MariaDB initialization
- improving command readability in the Makefile