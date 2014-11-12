#!/bin/bash
DIR="$HOME/.vim"
if [ -d "$DIR" ]; then 
    rsync -u ~/.vimrc ./vimrc
    rsync -ur ~/.vim/* ./vim/
else
    echo "VIM: could not find vim directory"
fi
