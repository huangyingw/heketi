#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

for volumeid in $(heketi-cli volume list | sed -n '/^Id:[a-f0-9]\+/p' | sed 's/Id:\([0-9a-f]\+\).*/\1/g')
do
    heketi-cli volume delete "$volumeid"
done

heketi-cli volume list
