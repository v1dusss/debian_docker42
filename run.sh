#!/bin/bash

# check docker info and save exit status
# if running start the container
# else start Docker --> start container
docker info &>/dev/null
status=$?

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

MAX_WAIT=30
SECONDS=0

if [ $status -eq 0 ]; then
	echo "Docker is running correctly"
	sh $SCRIPT_DIR/start_container/start.sh
else
	echo "Error, Docker is not running or installed"
	read -p "Do you want to run 42toolbox docker_init.sh (y/n): " answer
	case $answer in
		[Yy]* )
			echo "Starting 42toolbox docker_init.sh ..."
			sh $SCRIPT_DIR/Docker_42toolbox/init_docker.sh
			while ! docker info >/dev/null 2>&1; do
				if [ $SECONDS -ge $MAX_WAIT ]; then
					echo "Docker failed to start within $MAX_WAIT seconds. Exiting."
					exit 1
				fi
				echo "Waiting for Docker to start..."
				sleep 1
			done
			echo "Docker is ready. Starting container..."
			sh $SCRIPT_DIR/start_container/start.sh
			;;
		[Nn]* )
			echo "Abort, not starting 42toolbox docker_init.sh"
			;;
		* )
			echo "Invalid input. Please enter 'y' or 'n'"
			;;
	esac
fi