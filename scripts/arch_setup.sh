#!/bin/bash

# Set the keyboard layout?

# Partition the disks
fdisk /dev/sda
mkfs.ext4 /dev/sda1
makeswp /dev/sda2

# Mount partitions
mount /dev/sda1 /mnt
#mount /dev/sdaX /mnt/boot
swapon /dev/sda2

# Install the base packages
pacstrap /mnt base base-devel
# Configure the ssytem
genfstab -p /mnt >> /mnt/etc/fstab
arch-chroot /mnt
echo arch_vm > /etc/hostname
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# Uncomment en_US.UTF-8 UTF-8 from /etc/locale.gen
locale-gen

# Install GRUB
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
# Install graphic stuff
pacman -S xorg xterm xorg-server xorg-server-utils xorg-apps xf86-video-vesa xf86-video-intel xorg-xinit xorg-xclock
# Install window manager
pacman -S awesome i3
# Install login manager
pacman -S lightdm
# Install tools
pacman -S tmux git firefox gvim rxvt-unicode wget volumeicon numlockx
# Install network manager
pacman -S networkmanager network-manager-applet xfce4-notifyd gnome-themes-standard

# Add user
useradd -m -G wheel -s /bin/bash apo11o
sudo visudo

# Install fonts
pacman -S adobe-source-code-pro-fonts
git clone https://github.com/powerline/fonts
