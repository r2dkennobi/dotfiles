#!/bin/bash
sudo reflector --verbose -l 10 --sort rate --save /etc/pacman.d/mirrorlist
