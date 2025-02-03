FROM python:3.8.2-buster

ARG UNAME=builder
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential && \
    python3 -m pip install crossenv

USER $UNAME