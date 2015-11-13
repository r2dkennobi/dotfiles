#!/bin/bash
sudo grub-install --target=i386-pc --recheck --debug /dev/sda
sudo grub-mkconfig -o /boot/grub/grub.cfg
