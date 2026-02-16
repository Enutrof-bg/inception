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
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

restart: down up

clean:
	docker compose down -v
	rm -rf data/

rebuild : clean down build up