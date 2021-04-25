#!/bin/bash

set -e
set -x

source config.env


sekaid init $VALIDATOR_NAME --home=$SEKAID_HOME

# cfg config.toml
./replace.pl "seeds =.*$" "seeds = \"$SEED\"" $SEKAID_HOME/config/config.toml
./replace.pl "persistent_peers =.*$" "persistent_peers = \"$PERSISTENT_PEER\"" $SEKAID_HOME/config/config.toml


# download genesis
curl -s -o $SEKAID_HOME/config/genesis.json $GENESIS_URI
