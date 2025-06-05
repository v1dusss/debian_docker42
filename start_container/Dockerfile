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

# Install Powerlevel10k theme
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k

ENV TERM=xterm-256color
ENV COLORTERM=truecolor

# Copy config files
COPY script.sh /
COPY .env /
COPY .p10k.zsh /root/.p10k.zsh

# Run your script
RUN bash /script.sh

# Add Powerlevel10k to .zshrc
RUN echo 'source /root/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc && \
    echo 'source ~/.p10k.zsh' >> /root/.zshrc

# Set working directory
WORKDIR /home/