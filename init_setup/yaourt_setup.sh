#!/bin/bash

# package-query setup
wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar xzf package-query.tar.gz
cd package-query
makepkg -si
cd ../
rm -rf package-query*

# yaourt setup
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar xzf yaourt.tar.gz
cd yaourt
makepkg -si
cd ../
rm -rf yaourt
rm -rf yaourt.tar.gz
