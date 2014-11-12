#!/bin/bash
DIR="$HOME/.config/lxterminal"
if [ ! -d $DIR ]; then
    mkdir -p $DIR
fi
cp ./lxterminal.conf $DIR/lxterminal.conf
