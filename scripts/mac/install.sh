#!/bin/bash
set -Eeuo pipefail
#set -x

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-"$(git -C "${SCRIPT_DIR}" rev-parse --show-toplevel)"}"

if ! xcode-select -p &>/dev/null; then
  echo "> Xcode Command Line Tools not found. Installing..."
  xcode-select --install
  echo "> Re-run this script after installation completes."
  exit 1
fi

if [[ ! -e '/etc/pam.d/sudo_local' ]]; then
  echo "> Enable Touch ID for sudo"
  sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
fi

# Link safe configs early, before the riskier Homebrew/oh-my-zsh/nvim steps, so a
# failure there still leaves a working shell + git + gnupg config.
echo "> Symlinking dotfiles"
ln -sfn "${DOTFILES_DIR}/.tmux.conf"           "${HOME}/.tmux.conf"
ln -sfn "${DOTFILES_DIR}/.gitconfig"           "${HOME}/.gitconfig"
ln -sfn "${DOTFILES_DIR}/.git-commit-tmpl.txt" "${HOME}/.git-commit-tmpl.txt"
ln -sfn "${DOTFILES_DIR}/.gitconfig.local.mac" "${HOME}/.gitconfig.local"
# .bashrc intentionally omitted: not in repo; .bash_profile guards its source.
for f in .bash_profile .bash_aliases .bash_functions .bash_paths \
         .bash_exports .bash_prompt .inputrc .dockerfunc; do
  ln -sfn "${DOTFILES_DIR}/${f}" "${HOME}/${f}"
done
mkdir -p "${HOME}/.gnupg"
chmod 700 "${HOME}/.gnupg"
ln -sfn "${DOTFILES_DIR}/.gnupg/gpg.conf"           "${HOME}/.gnupg/gpg.conf"
ln -sfn "${DOTFILES_DIR}/.gnupg/gpg-agent.conf.mac" "${HOME}/.gnupg/gpg-agent.conf"
mkdir -p "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"
ln -sfn "${DOTFILES_DIR}/.ssh/config" "${HOME}/.ssh/config"

if [[ ! -d '/opt/homebrew/bin' ]]; then
  echo "> Install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure Homebrew is on PATH ahead of macOS system paths, so `bash`, `gpg`, etc.
# resolve to the Homebrew versions and not the stock ones (macOS ships bash 3.2 at
# /bin/bash). brew shellenv PREPENDS to PATH, overriding the order that path_helper
# applies from /etc/paths + /etc/paths.d/homebrew.
#
# Run this idempotently: when Homebrew is pre-installed (e.g. by MDM) the block
# above is skipped, but ~/.zprofile still needs this line. Gate on brew actually
# existing at the expected path so we don't write a line that errors in every
# future shell (e.g. on Intel, where Homebrew lives in /usr/local, not here).
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_SHELLENV='eval "$(/opt/homebrew/bin/brew shellenv)"'
  if ! grep -qF "$BREW_SHELLENV" "/Users/${USER}/.zprofile" 2>/dev/null; then
    echo "> Add Homebrew shellenv to ~/.zprofile"
    printf '\n%s\n' "$BREW_SHELLENV" >> "/Users/${USER}/.zprofile"
  fi
  eval "$BREW_SHELLENV"
else
  echo "> WARNING: /opt/homebrew/bin/brew not found — skipping shellenv setup" >&2
fi

echo "> Install usual applications"
PKGS=(neovim tmux bat fzf jq ripgrep shellcheck gnupg pinentry-mac font-cascadia-code-pl font-cascadia-mono-pl tree diff-so-fancy python)
MISSING=()
for pkg in "${PKGS[@]}"; do
  brew list --formula "$pkg" &>/dev/null || brew list --cask "$pkg" &>/dev/null || MISSING+=("$pkg")
done
[[ ${#MISSING[@]} -gt 0 ]] && brew install "${MISSING[@]}"

# Needs gpg on PATH, so it must run after the brew install above.
if command -v gpg >/dev/null 2>&1; then
  gpg_dir=$(dirname "$(which gpg)")
  if [[ ! -e "${gpg_dir}/gpg2" ]]; then
    echo "> Add gpg2 symlink (probably on macOS)"
    ln -sfn "${gpg_dir}/gpg" "${gpg_dir}/gpg2"
  fi
fi

if [[ ! -d "/Users/${USER}/.oh-my-zsh" ]]; then
  echo "> Install Oh My ZSH"
  curl -L https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
fi

if [[ ! -d "$HOME/.config/nvim" ]]; then
  echo "> Install neovim config"
  git clone git@github.com:r2dkennobi/nvim.git "$HOME/.config/nvim"
fi

# Must run after oh-my-zsh, whose installer overwrites ~/.zshrc.
LINE="source ${DOTFILES_DIR}/.zsh_custom"
FILE="${HOME}/.zshrc"
if ! grep -qF "$LINE" "$FILE"; then
  echo "> Add custom zsh configs to $FILE"
  echo "$LINE" >> "$FILE"
fi
