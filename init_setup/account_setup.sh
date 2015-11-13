#!/bin/bash
if [ ! -z $1 ]
then
    sudo useradd -m -G wheel -s /bin/bash $1
    sudo passwd $1
    visudo
fi
