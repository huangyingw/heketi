#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./install.sh
sleep 0.5s
heketi-cli topology load --json=/etc/heketi/topology.json
