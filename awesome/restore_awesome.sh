#!/bin/bash
DIR="$HOME/.config/awesome"
if [ ! -d $DIR ]; then
    echo "awesome configuration directory not found"
    mkdir -p $DIR
fi
cp -r ./themes $DIR/
cp -r ./*.lua $DIR/
