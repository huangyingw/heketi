#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./install.sh
sleep 0.5s
cp -fv ./topology.json /etc/heketi/topology.json
heketi-cli topology load --json=/etc/heketi/topology.json
