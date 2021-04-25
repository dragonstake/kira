#!/bin/bash

cd ..
source config.env

SECRETS="-v $SECRETS_DIR:$SEKAID_HOME/.secrets"
NAME="--name $VALIDATOR_NAME"

docker run --rm $NAME $SECRETS -it $IMAGE_NAME  "$@"
