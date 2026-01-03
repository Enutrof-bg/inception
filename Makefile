



NAME = inception

all: $(NAME)

$(NAME):
	docker compose -f srcs/docker-compose.yml up --build -d

clean:
	docker compose -f srcs/docker-compose.yml down
