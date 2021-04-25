#!/bin/bash

cd ..
source config.env

docker stop $VALIDATOR_NAME
