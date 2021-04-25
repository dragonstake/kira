#!/bin/bash

# Usage: move this file to "config.env" and set up

# build. Vars to compile the GO binary
SEKAID_BRANCH="testnet-2"
GOLANG_ARCH="amd64"
GO_VERSION="1.15.6"

# docker
VALIDATOR_NAME="validador-test"
IMAGE_NAME="sekaid:latest"

# config
SEKAID_HOME="/root/.simapp"
## local path to secrets
SECRETS_DIR="/tmp/.secrets"
GENESIS_URI="https://raw.githubusercontent.com/KiraCore/testnet/main/$SEKAID_BRANCH/genesis.json"
PERSISTENT_PEER_IP=""
PERSISTENT_PEER=""
SEED=''
