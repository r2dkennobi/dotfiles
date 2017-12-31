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
