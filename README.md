# dotfiles

Personal dotfiles for macOS (primary) and Linux (Arch/Debian-based).

## Setup

```bash
bash bootstrap.sh
```

The script detects your OS and runs the appropriate installer.

## What it does

### macOS (`scripts/mac/install.sh`)
- Checks for Xcode Command Line Tools (installs if missing)
- Installs Homebrew if not present
- Enables Touch ID for sudo
- Installs core tools: neovim, tmux, bat, fzf, jq, ripgrep, shellcheck, tree, diff-so-fancy
- Installs Oh My ZSH if not present
- Clones neovim config
- Symlinks all dotfiles into `~`

### Linux (`scripts/linux/install.sh`)
- Detects distro (Arch, Debian/Ubuntu/Pop/Parrot)
- Installs packages via pacman/yay or apt
- Installs and runs Ansible playbooks (see `scripts/linux/roles/`)
- Symlinks all dotfiles into `~`

## Platform-specific configs

Some configs have per-platform variants symlinked by the installer:

| File in repo | Symlinked to |
|---|---|
| `.gnupg/gpg-agent.conf.mac` | `~/.gnupg/gpg-agent.conf` (macOS) |
| `.gnupg/gpg-agent.conf.linux` | `~/.gnupg/gpg-agent.conf` (Linux) |
| `.gitconfig.local.mac` | `~/.gitconfig.local` (macOS) |
| `.gitconfig.local.linux` | `~/.gitconfig.local` (Linux) |

## Machine-local config

Put machine-specific settings (work aliases, env vars, etc.) in `~/.zshrc.local` — it's sourced automatically by `.zsh_custom` but never committed.

## Structure

```
bootstrap.sh          ← entry point
scripts/
├── mac/
│   └── install.sh    ← macOS installer
└── linux/
    ├── install.sh    ← Linux installer + symlink setup
    ├── provision.sh  ← modular manual provisioning
    └── roles/        ← Ansible roles
archive/              ← retired Linux desktop configs (i3, polybar, gtk3)
runbook/              ← notes on networking, security, system setup
```
