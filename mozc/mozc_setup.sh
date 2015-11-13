#!/bin/bash
wget https://aur.archlinux.org/packages/mo/mozc/mozc.tar.gz
tar xzf mozc.tar.gz
cd mozc
makepkg -si
