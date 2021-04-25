#!/bin/bash

exec 2>&1
set -e
set -x

source config.env

GO_TAR=go$GO_VERSION.linux-$GOLANG_ARCH.tar.gz

echo "INFO: Installing latest go $GOLANG_ARCH version $GO_VERSION https://golang.org/doc/install ..."
cd /tmp

curl -s	https://dl.google.com/go/$GO_TAR -o $GO_TAR
tar -C /usr/local -xvf $GO_TAR &>/dev/null

git clone -b $SEKAID_BRANCH https://github.com/KiraCore/sekai
cd sekai

/usr/local/go/bin/go build ./cmd/sekaid
mv sekaid /sekaid
