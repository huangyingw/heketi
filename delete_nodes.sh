#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

for nodeid in $(heketi-cli node list | sed -n '/^Id:[a-f0-9]\+/p' | sed 's/Id:\([0-9a-f]\+\).*/\1/g')
do
    ./delete_node.sh "$nodeid"
done
heketi-cli node list
