help:
	@echo "make build"
	@echo "make up"
	@echo "make down"
	@echo "make restart"
	@echo "make logs"
	@echo "make clean"
	@echo "make rebuild"

# NAME = inception

# all: $(NAME)

# $(NAME):
# 	docker compose -f srcs/docker-compose.yml up -d

# clean:
# 	docker compose -f srcs/docker-compose.yml down

# fclean: clean
# 	docker compose -f srcs/docker-compose.yml down -v

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
	rm -rf data/

rebuild : clean down build up