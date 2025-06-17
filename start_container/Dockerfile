FROM debian:latest

RUN apt-get update
RUN apt-get upgrade -y

# Install required packages
RUN apt-get install -y \
	build-essential \
	zsh \
	git \
	nano \
	curl \
	wget \
	make \
	cmake \
	g++ \
	zip \
	unzip \
	tar \
	gdb \
	python3 \
	python3-pip \
	python3-venv \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js + npm
# RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
# 	apt-get install -y nodejs

# Copy config files
COPY script.sh /
COPY .env /

# Run your script
RUN bash /script.sh

# Set working directory
WORKDIR /home/