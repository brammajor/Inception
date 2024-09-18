all:
	@echo "up      : Create necessary directories and start docker containers in detached mode."
	@echo "build   : Build the Docker images defined in the docker-compose file."
	@echo "rebuild : Rebuild the Docker images without using the cache."
	@echo "stop    : Stop the running containers without removing them."
	@echo "down    : Bring down the containers, networks, and volumes defined in the docker-compose file."
	@echo "logs    : Show the logs for the services defined in docker-compose."
	@echo "status  : Display the status of the containers."
	@echo "clean   : Remove the containers, networks, images, and volumes."
	@echo "fclean  : Perform a clean, and also remove the data directories."
	@echo "re      : Clean everything, rebuild images without cache, and bring the services back up."

up:
	mkdir -p /home/brmajor/data
	mkdir -p /home/brmajor/data/wordpress
	mkdir -p /home/brmajor/data/mariadb
	docker-compose -f srcs/docker-compose.yml up -d

build:
	docker-compose -f srcs/docker-compose.yml build

rebuild:
	docker-compose -f srcs/docker-compose.yml build --no-cache

stop:
	docker-compose -f srcs/docker-compose.yml stop

down:
	docker-compose -f srcs/docker-compose.yml down

logs:
	docker-compose -f srcs/docker-compose.yml logs

status:
	docker-compose -f srcs/docker-compose.yml ps

clean:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes

fclean: clean
	rm -rf /home/brmajor/data

re: clean rebuild up

.PHONY: all up build rebuild stop down logs status clean fclean re