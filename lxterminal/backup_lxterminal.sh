#!/bin/bash
DIR="$HOME/.config/lxterminal/"
if [ -d $DIR ]; then
    rsync -u $DIR/lxterminal.conf .
else
    echo "lxterminal configuration file not found"
fi
