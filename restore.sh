#!/bin/bash

# Backup bash configs
cp .bashrc ~
cp .bash_profile ~

# Backup terminal configs
cp ./lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf 
cp ./terminator/config ~/.config/terminator/config

# Backup Openbox configs
cp -r ./openbox/* ~/.config/openbox/

# Backup vim configs
cp ./vim/.vimrc ~

# Backup tmux configs
cp ./tmux/.tmux.conf ~/.tmux.conf
