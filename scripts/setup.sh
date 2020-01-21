#!/bin/bash
set -Eeuo pipefail
#set -x

OS=$(awk -F= '$1 == "ID" { print $NF ;}' /etc/os-release)
echo "Detected OS: $OS"

if [[ "$OS" == *"antergos"* ]]; then
  echo "## Archlinux based OS detected ##"
  echo "- Update system"
  sudo pacman -Syyu

  echo "- Check if we need to install AUR helper"
  if ! pacman -Qs yay > /dev/null; then
    echo "Installing yay!"
    BUILD_DIR=$(mktemp -d)
    cd "$BUILD_DIR" || exit
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit
    makepkg -si
    cd ..
  fi

  echo "- Install packages from AUR"
  AUR_PKGS=(google-chrome paman pavumeter keybase-bin caffeine-ng polybar)
  MISSING_PKGS=()
  for pkg in "${AUR_PKGS[@]}"; do
    if ! pacman -Qs "$pkg" > /dev/null; then
      MISSING_PKGS+=("$pkg")
    fi
  done
  if ! [[ ${#MISSING_PKGS[@]} -eq 0 ]]; then
    yay -S "${MISSING_PKGS[@]}"
  fi

  echo "- Check if Ansible needs to be installed"
  if ! pacman -Qs python-pip > /dev/null; then
    echo "- Setup Ansible"
    sudo pacman -S python-pip
    sudo pip install -U ansible
  fi

  # don't forget gem install foodcritic
elif [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "parrot" ]]; then
  echo "## Debian based OS detected ##"
  echo "- Update system"
  sudo apt-get update && sudo apt-get full-upgrade && sudo apt-get autoremove

  echo "- Install python and pip"
  sudo apt-get install -y python-pip

  echo "- Check if Ansible needs to be installed"
  if ! which ansible > /dev/null; then
    sudo pip install -U ansible
  fi
fi

echo "- Install all Ansible deps"
ansible-galaxy install -r requirements.yml
