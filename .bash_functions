#!/bin/bash
RCol='\e[0m'  # Text Reset
BGre='\e[1;32m'; BRed='\e[1;31m'; BBlu='\e[1;34m';

get_status() {
    echo -e ""
    echo -e "         _____           "
    echo -e "       ./_|L|__\.        ${BGre}Welcome back Apo11oH${RCol}"
    echo -e "      / ==[_]O|| \       ${BRed}Shall we play a game?${RCol}"
    echo -e "     _:=||____|.|-:_     "
    echo -e "    ||[] ||====| []||    ${BBlu}Arch:\t\t${RCol}$(uname -m) "
    echo -e "    |:||_|=|U| |_||:|    ${BBlu}Hostname:\t${RCol}$(hostname)"
    echo -e "    |:||[]_=_ =[_||:|    ${BBlu}Uptime:\t${RCol}$(uptime -p)"
    echo -e "    | ||[] [_][]C|| |    ${BBlu}Kernel:\t${RCol}$(uname -r)"
    echo -e "    /|\\_\_|_|_/_//||\    ${BBlu}Shell:\t\t${RCol}$(ps -p$$ -ocmd='')"
    echo -e "   |___|   /|\   |___|   "
    echo -e "   \---/  |___|  \---/   "
    echo -e ""
}

setup_ssh_agent() {
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent > ~/.ssh-agent-pid
    fi
    if [[ "$SSH_AGENT_PID" == "" ]]; then
        eval "$(<~/.ssh-agent-pid)"
    fi
}

setup_gpg_agent() {
    if ! pgrep -u "$USER" gpg-agent > /dev/null; then
        gpg-agent --daemon --sh
    fi
}

# Get colors in manual pages
man() {
	env \
		LESS_TERMCAP_mb="$(printf '\e[1;31m')" \
		LESS_TERMCAP_md="$(printf '\e[1;31m')" \
		LESS_TERMCAP_me="$(printf '\e[0m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_ue="$(printf '\e[0m')" \
		LESS_TERMCAP_us="$(printf '\e[1;32m')" \
		man "$@"
}

# Helper function to grab a list of GPG ID for the desired key(s)
_gpg_list_keys() {
  gpg --list-keys --keyid-format LONG "$@" 2>/dev/null | ${GREP_BIN:-"ag"} pub
  return $?
}

# Print out the GPG ID for the desired account
gpgid() {
  local COUNT OUTPUT
  COUNT=$(_gpg_list_keys "$@" 2>/dev/null | wc -l)
  if [[ $COUNT -eq 0 ]]; then
    echo "Could not find key. Please try another ID."
    return 1
  elif [[ $COUNT -gt 1 ]]; then
    echo "Too many keys found. Please specify further."
    return 1
  else
    OUTPUT=$(_gpg_list_keys "$@" 2>/dev/null | cut -d'/' -f2 | cut -d' ' -f1)
    echo "$OUTPUT"
    return 0
  fi
}

# Configures the repository with email and signingkey
git-config-id() {
  local USER
  USER="$1"
  if ! [[ "$USER" == *@* ]]; then
    echo "Invalid input. Please specify an email address."
    return 1
  fi
  MATCH=$(gpgid "$USER" 2>/dev/null)
  RESULT=$?
  if [[ $RESULT -eq 0 ]]; then
    git config user.email "$USER"
    git config user.signingkey "$MATCH"
    return 0
  else
    echo "Key ID not found. Failed to configure the respository user configuration."
    return 1
  fi
}
