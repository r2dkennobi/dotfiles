#!/bin/bash
DIR="$HOME/.vim"
if [ ! -d $DIR ]; then
    mkdir -p $DIR
fi
cp vimrc ~/.vimrc
cp vimshrc ~/.vimshrc
cp -r vim/* ~/.vim/
