# Create a container for sekaid binary

FROM ubuntu:20.04

# Default shell when executing RUN
SHELL ["/bin/bash", "-c"]

WORKDIR /root
COPY ./container .

RUN apt-get update -y
RUN apt-get install -y \
	git \
	tar \
	nano \
	curl

RUN ./compile.sh
RUN rm ./compile.sh

# RUN ./configure.sh
# RUN rm ./configure.sh
