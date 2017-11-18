# post kernel update not working
Likely fix: Install kernel headers
$ sudo apt install linux-headers-$(uname -r)
$ sudo dpkg-reconfigure virtualbox-dkms
