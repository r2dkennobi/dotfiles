#!/bin/bash
# copy configurationfiles
rsync -u /etc/lightdm/* ./lightdm/

# copy theme files
rsync -ur /usr/share/lightdm-another-gtk-greeter/* ./lightdm-another-gtk-greeter/

# copy login image
rsync -u /usr/share/pixmaps/ ./login_bg.jpg
