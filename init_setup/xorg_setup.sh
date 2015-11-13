#!/bin/bash
sudo pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils mesa
sudo pacman -S xorg-twm xterm xorg-xclock
sudo pacman -S xf86-input-synaptics

# Check graphics
lspci | grep VGA

# Check driver
sudo pacman -Ss | grep Intel
sudo pacman -S xf86-video-intel
