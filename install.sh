#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

wget -nc https://glide.sh/get | sh
apt-get install -y mercurial
glide install
make
cp -fv ./heketi /usr/local/bin
cp -fv ./client/cli/go/heketi-cli /usr/local/bin
heketi --version
heketi-cli --version
systemctl restart heketi
