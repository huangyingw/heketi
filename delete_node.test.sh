#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

./delete_node.sh 180338fe8e9aba9cae3f5e3bed6d884a
