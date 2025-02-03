#!/bin/bash
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$USER -t scipy-k1 .
docker run -v $PWD:$PWD -it scipy-k1 bash -c "cd $PWD && bash build.sh"