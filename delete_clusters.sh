#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./delete_nodes.sh

for clusterid in $(heketi-cli cluster list | sed -n '/^Id:[a-f0-9]\+/p' | sed 's/Id:\([0-9a-f]\+\).*/\1/g')
do
    echo "clusterid --> $clusterid"
    heketi-cli cluster delete "$clusterid"
done
