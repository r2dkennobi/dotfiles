#!/bin/bash
set -Eeuo pipefail
#set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${SCRIPT_DIR}/../.."

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
elif [[ "$OS" == "pop" ]] || [[ "$OS" == "ubuntu" ]] || [[ "$OS" == "parrot" ]]; then
  echo "## Debian based OS detected ##"
  echo "- Update system"
  sudo apt-get update && sudo apt-get full-upgrade && sudo apt-get autoremove

  echo "- Install python and pip"
  sudo apt-get install -y python3-pip

  echo "- Check if Ansible needs to be installed"
  if ! hash ansible > /dev/null; then
    sudo pip3 install -U ansible
  fi
fi

echo "- Install all Ansible deps"
ansible-galaxy install -r "${SCRIPT_DIR}/requirements.yaml"

echo "> Symlinking dotfiles"
while IFS= read -r -d '' file; do
  ln -sfn "$file" "${HOME}/$(basename "$file")"
done < <(find "$DOTFILES_DIR" -maxdepth 1 -name ".*" \
  -not -name ".gitignore" -not -name ".git" -not -name ".gnupg" -print0)
mkdir -p ~/.gnupg
ln -sfn "${DOTFILES_DIR}/.gnupg/gpg.conf"             "${HOME}/.gnupg/gpg.conf"
ln -sfn "${DOTFILES_DIR}/.gnupg/gpg-agent.conf.linux" "${HOME}/.gnupg/gpg-agent.conf"
ln -sfn "${DOTFILES_DIR}/.gitconfig.local.linux"       "${HOME}/.gitconfig.local"
