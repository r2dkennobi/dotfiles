#!/bin/bash
DIR="$HOME/.config/awesome"
if [ ! -d $DIR ]; then
    mkdir -p $DIR
else
    echo "awesom configuration directory not found"
fi
cp -r ./* $DIR/
