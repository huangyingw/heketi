#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

nodeid="$1"
heketi-cli node disable "$nodeid"
heketi-cli node remove "$nodeid"

for deviceid in $(heketi-cli node info "$nodeid" | sed -n '/^Id:[a-f0-9]\+/p' | sed 's/Id:\([0-9a-f]\+\).*/\1/g')
do
    heketi-cli device delete "$deviceid"
done

heketi-cli node delete "$nodeid"
