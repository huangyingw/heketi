#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./delete_volumes.sh

for nodeid in $(heketi-cli node list | sed -n '/^Id:[a-f0-9]\+/p' | sed 's/Id:\([0-9a-f]\+\).*/\1/g')
do
    echo "nodeid --> $nodeid"
    ./delete_node.sh "$nodeid"
done

heketi-cli node list
