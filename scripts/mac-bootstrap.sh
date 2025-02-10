#!/bin/bash
set -Eeuo pipefail
#set -x

if [[ ! -d '/opt/homebrew/bin' ]]; then
  echo "> Install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo >> "/Users/${USER}/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/${USER}/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ ! -e '/etc/pam.d/sudo_local' ]]; then
  echo "> Enable Touch ID for sudo"
  sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
fi

echo "> Install usual applications"
brew install neovim tmux bat fzf jq ripgrep shellcheck font-cascadia-code-pl font-cascadia-mono-pl tree diff-so-fancy

if [[ ! -d "/Users/${USER}/.oh-my-zsh" ]]; then
  echo "> Install Oh My ZSH"
  curl -L https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
fi

if [[ ! -d "$HOME/.config/nvim" ]]; then
  echo "> Install neovim config"
  git clone git@github.com:r2dkennobi/nvim.git "$HOME/.config/nvim"
fi

if command -v gpg >/dev/null 2>&1; then
  gpg_dir=$(dirname "$(which gpg)")
  if [[ ! -e "${gpg_dir}/gpg2" ]]; then
    echo "> Add gpg2 symlink (probably on macOS)"
    ln -sfn "${gpg_dir}/gpg" "${gpg_dir}/gpg2"
  fi
fi

ln -sfn "$(pwd)/../.tmux.conf" "${HOME}/.tmux.conf"
ln -sfn "$(pwd)/../.gitconfig" "${HOME}/.gitconfig"
ln -sfn "$(pwd)/../.git-commit-tmpl.txt" "${HOME}/.git-commit-tmpl.txt"
mkdir -p "${HOME}/.gnupg"
ln -sfn "$(pwd)/../.gnupg/gpg.conf" "${HOME}/.gnupg/gpg.conf"
ln -sfn "$(pwd)/../.gnupg/gpg-agent.conf" "${HOME}/.gnupg/gpg-agent.conf"


LINE="source $(pwd)/../.zsh_custom"
FILE="${HOME}/.zshrc"
if ! grep -qF "$LINE" "$FILE"; then
  echo "> Add custom zsh configs to $FILE"
  echo "$LINE" >> "$FILE"
fi
