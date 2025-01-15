#!/bin/bash


# Load .env
if [ -f .env ]; then
	source .env
else
	echo ".env file not found!"
	exit 1
fi

if [ ! "$DETACHED_MODE" = "True" ]; then
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
docker build -f ./start_container/Dockerfile -t $IMAGE_NAME .

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