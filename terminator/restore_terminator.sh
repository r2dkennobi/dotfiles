#!/bin/bash
DIR="$HOME/.config/terminator/"
if [ ! -d $DIR ]; then
    mkdir -p $DIR
fi
cp ./config $DIR/config
