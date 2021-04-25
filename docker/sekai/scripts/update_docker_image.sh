#!/bin/bash

cd ..
source config.env

cp config.env container/config.env
sudo docker build --rm -t $IMAGE_NAME .
rm container/config.env
