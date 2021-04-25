#!/bin/bash

cd ..
source config.env

# Check other instance is not running
docker ps -a | grep $VALIDATOR_NAME
if [[ $? -eq 0 ]]; then
	echo "Another instance exists"
	exit 1;
fi

SECRETS="-v $SECRETS_DIR:$SEKAID_HOME/.secrets"
NAME="--name $VALIDATOR_NAME"
CMD="sekaid start --home=$SEKAID_HOME"

docker run -d --rm $NAME -it $IMAGE_NAME $CMD
