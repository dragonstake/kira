# container to create sekaid binary

FROM ubuntu:20.04 AS builder

# Default shell when executing RUN
SHELL ["/bin/bash", "-c"]

LABEL stage=intermediate

WORKDIR /
COPY ./container .

RUN apt-get update -y
RUN apt-get install -y \
	git \
	tar \
	nano \
	curl

RUN ./compile.sh
RUN rm ./compile.sh



# container to run sekaid

FROM ubuntu:20.04


WORKDIR /root

COPY ./container/configure.sh .
COPY ./container/config.env .
COPY ./container/replace.pl .

COPY --from=builder /sekaid /usr/bin/sekaid

RUN apt-get update -y
RUN apt-get install -y \
	tar \
	nano \
	less \
	curl

RUN ./configure.sh
RUN rm ./configure.sh

