#!/bin/bash

# Restore bash configs
cp .bashrc ~
cp .bash_profile ~

# Restore terminal configs
cp ./lxterminal/lxterminal.conf ~/.config/lxterminal/lxterminal.conf 
cp ./terminator/config ~/.config/terminator/config

# Restore Openbox configs
cp -r ./openbox/* ~/.config/openbox/

# Restore vim configs
cp ./vim/.vimrc ~

# Restore tmux configs
cp ./tmux/.tmux.conf ~/.tmux.conf

# Restore screen configs
cp ./screen/.screenrc ~/.screenrc
