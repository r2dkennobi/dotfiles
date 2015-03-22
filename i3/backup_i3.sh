#!/bin/bash
DIR="$HOME/.config/i3/"
if [ -d $DIR ]; then
    rsync -ur $DIR/* .
else
    echo "i3 configuration directory not found"
fi
