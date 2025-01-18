#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# Load .env

echo "$SCRIPT_DIR/.env"
if [ -f $SCRIPT_DIR/.env ]; then
	source $SCRIPT_DIR/.env
else
	echo "$SCRIPT_DIR/.env file not found!"
	exit 1
fi

if ! grep -q "alias $DOCKER_INIT_ALIAS=" ~/.zshrc; then
	echo "alias $DOCKER_INIT_ALIAS='sh $SCRIPT_DIR/../docker_42toolbox/init_docker.sh'" >> ~/.zshrc
	source ~/.zshrc
fi
if ! grep -q "alias $DOCKER_CLEAN_ALIAS='sh $SCRIPT_DIR/../cleanup_docker.sh'" ~/.zshrc; then
	echo "alias $DOCKER_CLEAN_ALIAS='sh $SCRIPT_DIR/../cleanup_docker.sh'" >> ~/.zshrc
	source ~/.zshrc
fi
if ! grep -q "alias $DOCKER_RUN_ALIAS='sh $SCRIPT_DIR/../run.sh'" ~/.zshrc; then
	echo "alias $DOCKER_RUN_ALIAS='sh $SCRIPT_DIR/../run.sh'" >> ~/.zshrc
	source ~/.zshrc
fi


if [ ! "$DETACHED_MODE" = "True" ] || [ "$START_FROM_SCRATCH" = "True" ] ; then
	echo "deleting old Image and container"
	if [ -n "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
		docker stop $CONTAINER_NAME
	fi
	if [ -n "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
		docker rm $CONTAINER_NAME
	fi
	if [ -n "$(docker images -q $IMAGE_NAME)" ]; then
		docker rmi -f $IMAGE_NAME
	fi
fi

#check if the Container is already running
if [ -n "$(docker ps -q --filter "name=$CONTAINER_NAME")" ]; then
	echo "Container '$CONTAINER_NAME' already Running"
	docker exec -it $CONTAINER_NAME bash
	exit 0
fi

# build Docker-Images
echo "Building Docker image: $IMAGE_NAME..."
# docker build -t $IMAGE_NAME .
docker build -f "$SCRIPT_DIR/Dockerfile" -t "$IMAGE_NAME" $SCRIPT_DIR

if [ $? -ne 0 ]; then
	echo "Error: Docker image build failed!"
	exit 1
fi

#run Docker Images 
echo "Running Docker container with home directory mounted..."

if [ "$DETACHED_MODE" = "True" ]; then
	# Runs Container in background can exit Terminal and stays on
	# to remove container and Image ---> sh cleanup_docker CAUTION!!! this will delete all Docker Images Containers Voulumes and Networks
	docker run -d --name $CONTAINER_NAME -v $HOST_HOME_DIR:$CONTAINER_HOME_DIR $IMAGE_NAME bash -c "while true; do sleep 3600; done"
	until docker ps -q -f name=$CONTAINER_NAME; do
		echo "Waiting for container to start..."
		sleep 2
	done
	docker exec -it $CONTAINER_NAME bash
else
	# removes container and image after terminal is exited
	docker run -it --rm --name $CONTAINER_NAME -v $HOST_HOME_DIR:$CONTAINER_HOME_DIR $IMAGE_NAME
fi