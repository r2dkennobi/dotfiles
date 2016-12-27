#!/bin/bash
DIR="$HOME/.vim"
if [ -d "$DIR" ]; then 
    rsync -u ~/.vimrc ./vimrc
    rsync -u ~/.vimshrc ./vimshrc
    rsync -ur ~/.vim/* ./vim/
    rm -rf ./vim/bundle
    rm -rf ./vim/plugged
    rm -rf ./vim/autoload
else
    echo "VIM: could not find vim directory"
fi
