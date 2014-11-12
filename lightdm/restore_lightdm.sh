#!/bin/bash
# copy configurationfiles
sudo cp ./lightdm/* /etc/lightdm/

# copy theme files
sudo cp -r ./lightdm-another-gtk-greeter/* /usr/share/lightdm-another-gtk-greeter/

# copy login image
sudo cp ./login_bg.jpg /usr/share/pixmaps/
