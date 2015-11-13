#!/bin/bash
git clone https://github.com/ggreer/the_silver_searcher
cd the_silver_searcher
./configure
make
sudo make install
