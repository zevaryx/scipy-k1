FROM python:3.8.2-buster

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install build-essential && \
    python3 -m pip install crossenv