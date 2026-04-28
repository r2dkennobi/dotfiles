#!/bin/bash
set -Eeuo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$(uname -s)" in
  Darwin)
    echo "> Detected macOS"
    bash "${DOTFILES_DIR}/scripts/mac/install.sh"
    ;;
  Linux)
    echo "> Detected Linux"
    bash "${DOTFILES_DIR}/scripts/linux/install.sh"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac
