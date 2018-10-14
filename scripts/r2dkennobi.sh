#!/bin/bash
set -e
set -o pipefail

export DEBIAN_FRONTEND=noninteractive

get_user() {
  if [[ -z "${TARGET_USER-}" ]]; then
    PS3="Please pick user account: "
    local users
    mapfile -t users < <(find /home/* -maxdepth 0 -printf "%f\\n" -type d)
    select opt in "${users[@]}"; do
      readonly TARGET_USER=$opt
      break
    done
  fi
}

is_sudo() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "Not root. Please run script as root."
    exit 1
  fi
}

setup_min_sources() {
  # Disable downloading translations
  mkdir -p /etc/apt/apt.conf.d
  echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/99translations
}

setup_sources() {
  setup_min_sources

  # Add Yubiko
  cat <<-EOF > /etc/apt/sources.list.d/yubico.list
  deb http://ppa.launchpad.net/yubico/stable/ubuntu xenial main
  deb-src http://ppa.launchpad.net/yubico/stable/ubuntu xenial main
EOF

  # Add the Yubico ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 3653E21064B19D134466702E43D5C49532CBA1A9

  # Add Numix
  cat <<-EOF > /etc/apt/sources.list.d/numix.list
  deb http://ppa.launchpad.net/numix/ppa/ubuntu xenial main
  deb-src http://ppa.launchpad.net/numix/ppa/ubuntu xenial main
EOF

  # Add the Numix ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 43E076121739DEE5FB96BBED52B709720F164EEB

  # Add Tilix
  cat <<-EOF > /etc/apt/sources.list.d/tilix.list
  deb http://ppa.launchpad.net/webupd8team/terminix/ubuntu xenial main
  deb-src http://ppa.launchpad.net/webupd8team/terminix/ubuntu xenial main
EOF

  # Add the Tilix ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 7B2C3B0889BF5709A105D03AC2518248EEA14886

  # Add Parole
  cat <<-EOF > /etc/apt/sources.list.d/ubuntuhandbook1-apps.list
  deb http://ppa.launchpad.net/ubuntuhandbook1/apps/ubuntu xenial main
  deb-src http://ppa.launchpad.net/ubuntuhandbook1/apps/ubuntu xenial main
EOF

  # Add the Parole ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys A0062203196CA4482DDB859E4C1CBE14852541CB

  # Add i3
  cat <<-EOF > /etc/apt/sources.list.d/sur5r-i3.list
  deb http://debian.sur5r.net/i3/ xenial universe
EOF

  /usr/lib/apt/apt-helper download-file \
    http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2018.01.30_all.deb \
    /tmp/keyring.deb SHA256:baa43dbbd7232ea2b5444cae238d53bebb9d34601cc000e82f11111b1889078a
  dpkg -i /tmp/keyring.deb && rm /tmp/keyring.deb

  # Add Docker registry
  cat <<-EOF > /etc/apt/sources.list.d/docker.list
  deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable
EOF

  # Add Docker GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

  # Add Google Chrome apt repo
  cat <<-EOF > /etc/apt/sources.list.d/google-chrome.list
  deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
EOF

  # Add Google Chrome GPG key
  curl https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
}

setup_resilio_sync_sources() {
  # Add Resilio Sync
  cat <<-EOF > /etc/apt/sources.list.d/resilio-sync.list
  deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free
EOF

  # Add the Resilio Sync ppa gpg key
  wget -qO - https://linux-packages.resilio.com/resilio-sync/key.asc | apt-key add -
}

base_install() {
  base_min_install

  apt update
  apt -y full-upgrade

  apt -y install \
    numix-gtk-theme \
    numix-icon-theme \
    numix-icon-theme-circle \
    numix-icon-theme-square \
    docker-ce \
    parole \
    --no-install-recommends

  apt autoremove
  apt autoclean
  apt clean

  install_wm
  install_polybar
  install_universal_ctags
  install_docker
}

install_resilio_sync() {
  apt update
  apt -y install resilio-sync --no-install-recommends
  apt autoremove
  apt autoclean
  apt clean
}

install_wm() {
  local pkgs=(feh i3 i3lock i3status scrot suckless-tools rofi)

  apt -y install "${pkgs[@]}" --no-install-recommends
}

install_polybar() {
  local pkgs=(cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev \
    libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config \
    python-xcbgen xcb-proto libxcb-xrm-dev libxcb-cursor-dev i3-wm libasound2-dev \
    libmpdclient-dev libiw-dev libcurl4-openssl-dev)

  # Install dependencies
  apt -y install "${pkgs[@]}" --no-install-recommends

  # Build Polybar
  local temp_dir
  temp_dir=$(mktemp -d)
  git clone --recursive https://github.com/jaagr/polybar "$temp_dir/polybar"
  mkdir -p "$temp_dir/polybar/build" && cd "$_"
  git checkout 3.2.1
  cmake -GNinja ..
  ninja install
}

install_universal_ctags() {
  local temp_dir
  temp_dir=$(mktemp -d)
  git clone --recursive https://github.com/universal-ctags/ctags "$temp_dir/ctags"
  cd "$temp_dir/ctags"
  ./autogen.sh
  ./configure
  make
  make install
}

install_rust() {
  curl https://sh.rustup.rs -sSf | sh -s -- -y --nomodify-path
}

install_gdb() {
  wget -O "$HOME/.gdbinit-gef.py" https://github.com/hugsy/gef/raw/master/gef.py
}

install_docker() {
  sudo gpasswd -a "$TARGET_USER" docker
}

install_go() {
  sudo snap install go --classic
  mkdir -p "$HOME/go"
}

setup_ssh() {
  local default_ssh
  default_ssh="Host *\n    IdentitiesOnly yes\n    AddKeysToAgent yes"
  default_ssh_pat="Host *\s*IdentitiesOnly yes\s*AddKeysToAgent yes"
  if [[ -e "$HOME/.ssh" ]]; then
    if [[ -e "$HOME/.ssh/config" ]]; then
      grep -qvP "$default_ssh_pat" "$HOME/.ssh/config" || echo -e "$default_ssh" >> "$HOME/.ssh/config"
    else
      touch "$HOME/.ssh/config"
      setup_ssh
    fi
  else
    mkdir -p "$HOME/.ssh"
    setup_ssh
  fi
}

usage() {
  echo "./r2dkennobi.sh"
  echo "Usage:"
  echo "  base                    - Setup sources & install base pkgs"
  echo "  basefull                - Setup sources & install all pkgs"
  echo "  vim                     - Install vim & neovim"
  echo "  wm                      - Install window manager apps"
  echo "  dev                     - Install development tools"
  echo "  vivaldi                 - Install Vivaldi (Chrome without the Google)"
  echo "  resilio                 - Install Resilio Sync"
  echo "  go                      - Install Go"
  echo "  ssh                     - Setup default ssh configs"
}

main() {
  local cmd=$1

  if [[ -z "$cmd" ]]; then
    usage
    exit 1
  fi

  if [[ $cmd == "basemin" ]]; then
    is_sudo
    get_user
    setup_min_sources
    base_min_install
  elif [[ $cmd == "base" ]]; then
    is_sudo
    get_user
    setup_sources
    base_install
  elif [[ $cmd == "wm" ]]; then
    is_sudo
    install_wm
    install_polybar
  elif [[ $cmd == "dev" ]]; then
    is_sudo
    install_universal_ctags
    install_gdb
  elif [[ $cmd == "vivaldi" ]]; then
    is_sudo
    install_vivaldi
  elif [[ $cmd == "resilio" ]]; then
    is_sudo
    setup_resilio_sync_sources
    install_resilio_sync
  elif [[ $cmd == "go" ]]; then
    install_go
  elif [[ $cmd == "ssh" ]]; then
    setup_ssh
  else
    usage
  fi
}

main "$@"
