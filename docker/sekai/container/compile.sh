#!/bin/bash

exec 2>&1
set -e
set -x

SEKAID_BRANCH="testnet-2"
GOLANG_ARCH="amd64"
GO_VERSION="1.15.6"
GO_TAR=go$GO_VERSION.linux-$GOLANG_ARCH.tar.gz

echo "INFO: Installing latest go $GOLANG_ARCH version $GO_VERSION https://golang.org/doc/install ..."
cd /tmp

curl -s	https://dl.google.com/go/$GO_TAR -o $GO_TAR
tar -C /usr/local -xvf $GO_TAR &>/dev/null

git clone -b $SEKAID_BRANCH https://github.com/KiraCore/sekai
cd sekai

/usr/local/go/bin/go build ./cmd/sekaid
mv sekaid /usr/bin/
ln -s /usr/bin/sekaid /root

# clean
rm -rf /go /usr/bin/go /tmp/*
