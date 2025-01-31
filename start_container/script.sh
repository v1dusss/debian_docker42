#!/bin/bash


if [ -f .env ]; then
	source .env
else
	echo ".env file not found!"
	exit 1
fi



# Adjust this if you need or dont need some installations on your container
apt install nano
apt install curl
apt-get install -y vim git wget zip unzip tar
apt-get install -y cmake gdb
apt-get install -y python3 python3-pip


echo "PS1='\[\e[0;32m\]$USERNAME@\W \[\e[0;34m\] ~> \[\e[0m\]'" >> ~/.bashrc
echo "alias val='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s'" >> ~/.bashrc
echo "alias hel='valgrind --tool=helgrind -s'" >> ~/.bashrc
