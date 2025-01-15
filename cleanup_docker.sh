#!/bin/bash

#sh cleanup_docker CAUTION!!! this will delete all Docker Images Containers Voulumes and Networks

# stopp and remove Containers
if [ -n "$(docker ps -qa)" ]; then
	docker stop $(docker ps -qa)
	docker rm $(docker ps -qa)
fi

# remove docker images
if [ -n "$(docker images -qa)" ]; then
	docker rmi -f $(docker images -qa)
fi

# remove Volumes
if [ -n "$(docker volume ls -q)" ]; then
	docker volume rm $(docker volume ls -q)
fi

# Remove networks
if [ -n "$(docker network ls -q)" ]; then
	docker network rm $(docker network ls -q) 2>/dev/null || true
fi

echo "Cleanup complete!"
