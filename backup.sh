#!/bin/bash

# Backup bash configs
cp ~/.bashrc .
cp ~/.bash_profile .

# Backup terminal configs
mkdir -p lxterminal terminator
cp ~/.config/lxterminal/lxterminal.conf ./lxterminal/
cp ~/.config/terminator/config ./terminator/

# Backup Openbox configs
mkdir -p openbox
cp -r ~/.config/openbox/* ./openbox/

# Backup vim configs
mkdir -p vim
cp ~/.vimrc ./vim/

# Backup tmux configs
mkdir -p tmux
cp ~/.tmux.conf ./tmux/

# Backup screen configs
mkdir -p screen
cp ~/.screenrc ./screen/
