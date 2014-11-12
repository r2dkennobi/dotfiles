#!/bin/bash
DIR="$HOME/.config/awesome/"
if [ -d $DIR ]; then
    rsync -ur $DIR/* .
else
    echo "awesom configuration directory not found"
fi
