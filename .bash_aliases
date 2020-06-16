#!/bin/bash

alias cp='cp -i'
alias mv='mv -i'
alias gpgla='gpg2 --list-keys --keyid-format LONG --fingerprint'
alias gpgsla='gpg2 --list-secret-keys --keyid-format LONG --fingerprint'
alias ports='lsof -i -n -P'
alias services_enabled='systemctl list-unit-files | ag enable'
alias services_disabled='systemctl list-unit-files | ag disable'
alias ssh='ssh -XYC'
alias ssha='ssh -XYCA'
alias rsync='rsync -avh --progress --stats'
alias rrsync='rsync -ravh --progress --stats'
alias agh='ag --hidden'
alias ssh-secure-keygen='ssh-keygen -o -a 100 -t ed25519'
if [[ -e "/usr/bin/apt" ]]; then
  alias sysup='sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y'
elif [[ -e "/usr/bin/pacman" ]]; then
  if [[ -e "/usr/bin/yay" ]]; then
    alias sysup='sudo pacman -Syyu && yay -Syyu --aur'
  else
    alias sysup='sudo pacman -Syyu'
  fi
fi
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
if [[ -e "/usr/bin/bat" ]]; then
  alias cat='bat'
fi
alias preview="fzf --preview 'bat --color \"always\" {}'"
if [[ -e "/usr/local/bin/prettyping" ]]; then
  alias ping="prettyping"
fi
alias punchitchewie="sudo cpupower frequency-set -g performance"
alias rgh="rg --hidden"
alias sudo="sudo "
alias time_east_coast="sudo timedatectl set-timezone America/New_York"
alias time_west_coast="sudo timedatectl set-timezone America/Los_Angeles"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

if ls --color > /dev/null 2>&1; then
  colorflag="--color"
else
  colorflag="-G"
fi
export colorflag
alias l='ls -hXF ${colorflag}'
alias ls='ls -lhXF ${colorflag}'
alias lsa='ls -lahXF ${colorflag}'
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=01;34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:'
LS_COLORS+='bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:'
LS_COLORS+='*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:'
LS_COLORS+='*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:'
LS_COLORS+='*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:'
LS_COLORS+='*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:'
LS_COLORS+='*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:'
LS_COLORS+='*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:'
LS_COLORS+='*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:'
LS_COLORS+='*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:'
LS_COLORS+='*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:'
LS_COLORS+='*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:'
LS_COLORS+='*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:'
LS_COLORS+='*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:'
LS_COLORS+='*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:'
LS_COLORS+='*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:'
LS_COLORS+='*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:'
LS_COLORS+='*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:'
LS_COLORS+='*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:'
LS_COLORS+='*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:'
LS_COLORS+='*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:'
LS_COLORS+='*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:'
LS_COLORS+='*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:'
LS_COLORS+='*.Z=1;35:*.zip=1;35:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:'
LS_COLORS+='*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:'
LS_COLORS+='*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:'
LS_COLORS+='*.v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'

# Flush directory service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# I love map
alias map="xargs -n1"

# afk. just cause
alias afk="i3lock -ti /home/kenny/lockscreen.png"
