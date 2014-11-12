#!/bin/bash
DIR="$HOME/.vim"
if [ ! -d $DIR ]; then
    mkdir -p $DIR
fi
cp vimrc ~/.vimrc
cp -r vim/* ~/.vim/
