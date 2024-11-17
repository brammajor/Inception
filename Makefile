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
	mkdir -p /home/bram/data
	mkdir -p /home/bram/data/wordpress
	mkdir -p /home/bram/data/mariadb
	sudo docker-compose -f srcs/docker-compose.yml up -d

build:
	sudo docker-compose -f srcs/docker-compose.yml build

rebuild:
	sudo docker-compose -f srcs/docker-compose.yml build --no-cache

stop:
	sudo docker-compose -f srcs/docker-compose.yml stop

down:
	sudo docker-compose -f srcs/docker-compose.yml down

logs:
	sudo docker-compose -f srcs/docker-compose.yml logs

status:
	sudo docker-compose -f srcs/docker-compose.yml ps

clean:
	sudo docker-compose -f srcs/docker-compose.yml down --rmi all --volumes

fclean: clean
	rm -rf /home/bram/data

re: clean rebuild up

.PHONY: all up build rebuild stop down logs status clean fclean re