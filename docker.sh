#!/bin/bash
docker build -t scipy-k1 .
docker run -v $PWD:/root/scipy-k1 -it scipy-k1 bash -c "cd /root/scipy-k1 && bash build.sh"