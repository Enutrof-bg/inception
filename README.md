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

## Project Description
- Docker usage is interesting in various way. For 42 school project, it is useful to
work with for sharing project code between every member and working smoothly with the same setting as everyone. It can also be used to work with tools not installed on school computer by using container and installing needed tools.

- The docker is structured in way that each folder is responsible for his service and his container, to avoid unnecessary file copy when building the docker, and be easier to upgrade and debug if a problem arise.

### Comparison
- 1) **Virtual Machines vs Docker**
	- While virtual machine create and simulate a whole new computer, Docker share the host computer kernel and isolate process in container to make the process think like a new computer with the use of namespaces from the linux node to isolate process and cgroups to limits host computer ressources usage.

- 2) **Secrets vs Environment Variables**
	- Secrets are an useful way to share sensible data with container and making them not easily visible (with command like docker inspect) while environement variable are shared with the container and easily accessible.

- 3) **Docker Network vs Host Network**
	- In the docker network, each container has not access to the host network and a new private network is created when the docker is built. The network must be configured if you want the container to be able to communicate between each other, each container has his own IP adress.
	On the host network, "port" is ignored in the docker compose and each container are using the host network, if a container is listening a port, it is listening directly from the host port

- 4) **Docker Volumes vs Bind Mounts**
	- Bind mounts store the volume on the host computer storage and are easily accessible and can be modified, which is more suitable during development process, while docker volume store data in a secret folder inside container, it is more performant and easier to share between container