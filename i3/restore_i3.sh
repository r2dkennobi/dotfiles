#!/bin/bash
DIR="$HOME/.config/i3"
if [ ! -d $DIR ]; then
    echo "i3 configuration directory not found"
    mkdir -p $DIR
fi
cp ./config $DIR/
