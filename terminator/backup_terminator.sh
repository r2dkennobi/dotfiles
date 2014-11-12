#!/bin/bash
DIR="$HOME/.config/terminator/"
if [ -d $DIR ]; then
    rsync -u $DIR/config .
else
    echo "termiantor configuration file not found"
fi
