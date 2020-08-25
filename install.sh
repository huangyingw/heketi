#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

#wget -nc https://glide.sh/get | sh
#apt-get install -y mercurial
#glide install
make
cp -fv ./heketi /usr/local/bin
cp -fv ./client/cli/go/heketi-cli /usr/local/bin
heketi --version
heketi-cli --version
cp -fv ./etc/heketi.json /etc/heketi
cp -fv extras/systemd/heketi.service /etc/systemd/system/heketi.service
systemctl daemon-reexec
systemctl restart heketi
