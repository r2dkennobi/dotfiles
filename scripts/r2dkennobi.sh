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
  # Add latest git. cause reasaons.
  cat <<-EOF > /etc/apt/sources.list.d/git-core.list
  deb http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main
  deb-src http://ppa.launchpad.net/git-core/ppa/ubuntu xenial main
EOF

  # Add the git-core ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys E1DD270288B4E6030699E45FA1715D88E1DF1F24

  # NEOVIM YEAAAA
  cat <<-EOF > /etc/apt/sources.list.d/neovim.list
  deb http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main
  deb-src http://ppa.launchpad.net/neovim-ppa/stable/ubuntu xenial main
EOF

  # Add the neovim ppa gpg key
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
    --recv-keys 9DBB0BE9366964F134855E2255F96FCF8231B6DD

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

  # Add i3
  cat <<-EOF > /etc/apt/sources.list.d/sur5r-i3.list
  deb http://debian.sur5r.net/i3/ xenial main
EOF

  /usr/lib/apt/apt-helper download-file \
    http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2017.01.02_all.deb \
    /tmp/keyring.deb SHA256:4c3c6685b1181d83efe3a479c5ae38a2a44e23add55e16a328b8c8560bf05e5f
  dpkg -i /tmp/keyring.deb && rm /tmp/keyring.deb

}

base_min_install() {
  apt update
  apt -y full-upgrade

  apt -y install \
    wget \
    tmux \
    tree \
    xsel \
    ncdu \
    ninja-build \
    cmake \
    neovim \
    silversearcher-ag \
    --no-install-recommends

  apt autoremove
  apt autoclean
  apt clean
}

base_install() {
  base_min_install

  apt update
  apt -y full-upgrade

  apt -y install \
    ninja-build \
    unity-tweak-tool \
    caffeine \
    volti \
    blueman \
    thunar \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    thunar-gtkhash \
    indicator-cpufreq \
    fcitx \
    fcitx-mozc \
    lxappearance \
    arandr \
    asciidoctor \
    cmus \
    xautolock \
    pasystray \
    pavucontrol \
    tpm-tools \
    binwalk \
    pngcheck

  apt autoremove
  apt autoclean
  apt clean

  install_wm
  install_polybar
}

install_vim() {
  (
  cd "$HOME"

  # Install my custom vim configs
  git clone git@github.com:r2dkennobi/.vim.git "$HOME/.vim"
  ln -snf "$HOME/.vim/.vimrc" "$HOME/.vimrc"
  sudo ln -snf "$HOME/.vim" /root/.vim
  sudo ln -snf "$HOME/.vimrc" /root/.vimrc

  # Install my custom nvim configs
  mkdir -p "${XDG_CONFIG_HOME:=$HOME/.config}"
  git clone git@github.com:r2dkennobi/nvim.git "$XDG_CONFIG_HOME/nvim"
  sudo mkdir -p /root/.config
  sudo ln -snf "$XDG_CONFIG_HOME/nvim" "/root/.config/nvim"

  sudo apt update

  sudo apt -y install python3-pip python3-setuptools foodcritic shellcheck

  pip3 install -U setuptools wheel neovim ansible-lint cmakelint flake8 vim-vint
  )
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
  git checkout 3.0.5
  cmake -GNinja ..
  ninja install
}

usage() {
  echo "./r2dkennobi.sh"
  echo "Usage:"
  echo "  base                    - Setup sources & install base pkgs"
  echo "  basefull                - Setup sources & install all pkgs"
  echo "  vim                     - Install vim & neovim"
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
  elif [[ $cmd == "vim" ]]; then
    install_vim
  else
    usage
  fi
}

main "$@"
