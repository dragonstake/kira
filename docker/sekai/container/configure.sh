#!/bin/bash

# VARS
HOME="/root/.simapp"
PERSISTENT_PEER_IP="95.216.241.248"
PERSISTENT_PEER="tcp://09010ec67f0fa4531bc940bc843b2881d2f7c876@$PERSISTENT_PEER_IP:26656"
GENESIS_URI="https://raw.githubusercontent.com/KiraCore/testnet/main/testnet-2/genesis.json"
SEED='tcp://d2d3b727c36cbbf722f1da9aa24c96c7afb91d0d@18.135.115.225:16656,tcp://bc4b1bb08e052b4591098bf8545184d4eb72d339@18.135.115.225:26656,tcp://636d755b2013a8126e0d25881dc531345ec0676c@18.135.115.225:36656,tcp://1361c04cad2006a0a59cb913ca0a4d72c97beea0@165.227.149.134:26656'
sekaid init validador-test --home=$HOME

# cfg config.toml
#sed -iE 's/seeds = *$///'

# download genesis
curl -s -o $HOME/config/genesis.json $GENESIS_URI

sekaid start --home=$HOME
