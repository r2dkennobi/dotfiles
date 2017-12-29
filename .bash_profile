#!/bin/bash
for file in ~/.{bashrc,bash_prompt,bash_aliases,bash_exports,bash_functions,env_override}; do
  # Check if file exists and readable
  if [[ -f "$file" ]] && [[ -r "$file" ]]; then
    source "$file"
  fi
done
unset file

# Auto-fix type
shopt -s cdspell

# Append to the bash history file
shopt -s histappend

# Treat a command name as if it were the argument to the cd command
shopt -s autocd

shopt -s globstar

# Cycle through autocomplete candidates
bind Control-j:menu-complete
bind Control-k:menu-complete-backward

# TODO Figure out how to also complete when username is specified
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" -o "nospace" \
  -W "$(grep "^Host" "$HOME/.ssh/config" | grep -v "[?*]" | cut -d " " -f2 | \
  tr ' ' '\n')" scp sftp ssh rsync

# Start programs
setup_ssh_agent &> /dev/null
setup_gpg_agent &> /dev/null
