FROM debian:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install build-essential valgrind g++ -y
RUN apt-get install make

RUN echo HelloWorld

COPY script.sh /
COPY .env /

RUN bash /script.sh

WORKDIR /home/

