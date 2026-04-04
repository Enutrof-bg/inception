help:
	@echo "make build"
	@echo "make up"
	@echo "make down"
	@echo "make restart"
	@echo "make clean"
	@echo "make rebuild"

NAME = inception

all: ${NAME}

${NAME}: build up

build:
	mkdir -p /home/kevwang/data/mariadb /home/kevwang/data/wordpress
	docker compose -f srcs/docker-compose.yml build

up:
	mkdir -p /home/kevwang/data/mariadb /home/kevwang/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d

down:
	docker compose -f srcs/docker-compose.yml down

restart: down up

clean:
	docker compose -f srcs/docker-compose.yml down -v
	docker run --rm -v /home/kevwang/data/mariadb:/data alpine sh -c 'rm -rf /data/*'
	docker run --rm -v /home/kevwang/data/wordpress:/data alpine sh -c 'rm -rf /data/*'

fclean: clean
	docker system prune -f

rebuild : clean down build up

re: rebuild

