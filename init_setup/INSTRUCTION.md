## Current Arch Linux installation procedure

### Base setup
#### Disk partition setup
Use fdisk/gdisk to setup all the partitions.
```
/dev/sda1   fat32   1G
/dev/sda2   swap    8G
/dev/sda3   ext4    Rest
```

Format the file systems
```
# mkfs.fat -F32 /dev/sda1
# mkswap /dev/sda2
# mkfs.ext4 /dev/sdb3
```

Mount the file systems
```
# mount /dev/sda3 /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt
# swapon /dev/sda2
```

Install the base packages
```
# pacstrap /mnt base base-devel
```

Generate the fstab
```
# genfstab -p /mnt >> /mnt/etc/fstab
```

Change root
```
# arch-chroot /mnt
```

Setup hostname
```
# echo <hostname> > /etc/hostname
```

Setup timezone
```
ln -sf /usr/share/zoneinfo/<zone>/<subzone> /etc/localtime
```

Setup locale
```
// Uncomment required locale
# sudoedit /etc/locale.gen
# locale-gen
```

Set locale preference
```
# echo LANG=<selected locale> > /etc/locale.conf
```

Configure initial RAM disk
```
# mkinitcpio -p linux
```

Change root password
```
# passwd
```

Setup bootloader
For GPT-partitioned systems:
```
# bootctl install
# touch /boot/loader/entries/arch.conf
// Content of /boot/loader/entries/arch.conf
title       Arch Linux
linux       /vmlinuz-linux
initrd      /initramfs-linux.img
options     root=/dev/sda3 rw
# touch /boot/loader/loader.conf
// Content of /boot/loader/loader.conf
timeout 3
default arch
```
For other systems:
```
# grub-install --target=i386-pc --recheck --debug /dev/sda
# grub-mkconfig -o /boot/grub/grub.cfg
```

### Post-installation setup
Create user
```
# useradd -m -g users -G wheel -s /bin/bash <username>
# passwd <username>
```

Install Xorg
(Probably don't need this many. Also asuuming no GPU)
```
# pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils mesa xorg-twm xterm xorg-xclock xf86-input-synaptics xf86-video-intel
```

Font setup
```
# pacman -S ttf-dejavu adobe-source-han-sans-jp-fonts
// To get a more compatabilities with websites
# yaourt -S ttf-ms-win10
```

General app setup
```
# pacman -S gvim wget git lightdm i3 networkmanager network-manager-applet rxvt-unicode firefox dmenu
```

Enable services
```
# systemctl enable NetworkManager
# systemctl enable lightdm
```

Configure lightdm
