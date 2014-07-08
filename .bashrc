# Add nano as default editor
export EDITOR=vim
export TERMINAL=lxterminal
export BROWSER=firefox
# Gtk themes
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Enable 256 colors for terminal
export TERM=xterm-256color

# Enable case insensitive tab completion
bind 'set completion-ignore-case on'

# Color for ls
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

# Auto-fix type
shopt -s cdspell

# Aliases
alias ls='ls -lhF --color=auto'
[ ! "$UID" = "0" ] && archbey2
alias ocaml="rlwrap ocaml"
alias open="xdg-open"
alias :q="exit"
alias grep="grep --color=auto"

# Add IDE folders to PATH
PATH="${PATH}:$HOME/android-studio/bin:$HOME/idea-IC-133.331/bin"
# Add Android SDK to path
PATH="${PATH}:$HOME/android-studio/sdk/platform-tools"
PATH="${PATH}:$HOME/android-studio/sdk/tools"
PATH="${PATH}:$HOME/android-studio/sdk/build-tools/android-4.4"
# Add ruby gem path
PATH="${PATH}:/home/apo11o/.gem/ruby/2.1.0/bin"

# Setup gtest directory
export GTEST_DIR="/home/apo11o/gtest-1.7.0"
export C_INCLUDE_PATH="/home/apo11o/gtest-1.7.0/include"
export CPLUS_INCLUDE_PATH="/home/apo11o/gtest-1.7.0/include"

# Add ARM toolchain to PATH
PATH="${PATH}:${PATH}:/opt/ARM/bin"
PATH="${PATH}:${PATH}:/opt/stlink"

# Set custom bash prompt
PS1="\n\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\$?\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

###########################
# Color Scheme for echo   #
###########################
RCol='\e[0m'  # Text Reset

# Regular       Bold             Underline
Blk='\e[0;30m'; BBlk='\e[1;30m'; UBlk='\e[4;30m';
Red='\e[0;31m'; BRed='\e[1;31m'; URed='\e[4;31m';
Gre='\e[0;32m'; BGre='\e[1;32m'; UGre='\e[4;32m';
Yel='\e[0;33m'; BYel='\e[1;33m'; UYel='\e[4;33m';
Blu='\e[0;34m'; BBlu='\e[1;34m'; UBlu='\e[4;34m';
Pur='\e[0;35m'; BPur='\e[1;35m'; UPur='\e[4;35m';
Cya='\e[0;36m'; BCya='\e[1;36m'; UCya='\e[4;36m';
Wht='\e[0;37m'; BWht='\e[1;37m'; UWht='\e[4;37m';

#High Intensity  BoldHigh Intens   Background       High Intensity Backgrounds
IBlk='\e[0;90m'; BIBlk='\e[1;90m'; On_Blk='\e[40m'; On_IBlk='\e[0;100m';
IRed='\e[0;91m'; BIRed='\e[1;91m'; On_Red='\e[41m'; On_IRed='\e[0;101m';
IGre='\e[0;92m'; BIGre='\e[1;92m'; On_Gre='\e[42m'; On_IGre='\e[0;102m';
IYel='\e[0;93m'; BIYel='\e[1;93m'; On_Yel='\e[43m'; On_IYel='\e[0;103m';
IBlu='\e[0;94m'; BIBlu='\e[1;94m'; On_Blu='\e[44m'; On_IBlu='\e[0;104m';
IPur='\e[0;95m'; BIPur='\e[1;95m'; On_Pur='\e[45m'; On_IPur='\e[0;105m';
ICya='\e[0;96m'; BICya='\e[1;96m'; On_Cya='\e[46m'; On_ICya='\e[0;106m';
IWht='\e[0;97m'; BIWht='\e[1;97m'; On_Wht='\e[47m'; On_IWht='\e[0;107m';


export LS_COLORS='no=00:fi=00:di=01;34:ow=34;40:ln=35:pi=30;44:so=35;44:do=35;44:bd=33;44:cd=37;44:or=05;37;41:mi=05;37;41:ex=01;31:*.cmd=01;31:*.exe=01;31:*.com=01;31:*.bat=01;31:*.reg=01;31:*.app=01;31:*.txt=32:*.org=32:*.md=32:*.mkd=32:*.h=32:*.c=32:*.C=32:*.cc=32:*.cpp=32:*.cxx=32:*.objc=32:*.sh=32:*.csh=32:*.zsh=32:*.el=32:*.vim=32:*.java=32:*.pl=32:*.pm=32:*.py=32:*.rb=32:*.hs=32:*.php=32:*.htm=32:*.html=32:*.shtml=32:*.erb=32:*.haml=32:*.xml=32:*.rdf=32:*.css=32:*.sass=32:*.scss=32:*.less=32:*.js=32:*.coffee=32:*.man=32:*.0=32:*.1=32:*.2=32:*.3=32:*.4=32:*.5=32:*.6=32:*.7=32:*.8=32:*.9=32:*.l=32:*.n=32:*.p=32:*.pod=32:*.tex=32:*.bmp=33:*.cgm=33:*.dl=33:*.dvi=33:*.emf=33:*.eps=33:*.gif=33:*.jpeg=33:*.jpg=33:*.JPG=33:*.mng=33:*.pbm=33:*.pcx=33:*.pdf=33:*.pgm=33:*.png=33:*.ppm=33:*.pps=33:*.ppsx=33:*.ps=33:*.svg=33:*.svgz=33:*.tga=33:*.tif=33:*.tiff=33:*.xbm=33:*.xcf=33:*.xpm=33:*.xwd=33:*.xwd=33:*.yuv=33:*.aac=33:*.au=33:*.flac=33:*.mid=33:*.midi=33:*.mka=33:*.mp3=33:*.mpa=33:*.mpeg=33:*.mpg=33:*.ogg=33:*.ra=33:*.wav=33:*.anx=33:*.asf=33:*.avi=33:*.axv=33:*.flc=33:*.fli=33:*.flv=33:*.gl=33:*.m2v=33:*.m4v=33:*.mkv=33:*.mov=33:*.mp4=33:*.mp4v=33:*.mpeg=33:*.mpg=33:*.nuv=33:*.ogm=33:*.ogv=33:*.ogx=33:*.qt=33:*.rm=33:*.rmvb=33:*.swf=33:*.vob=33:*.wmv=33:*.doc=31:*.docx=31:*.rtf=31:*.dot=31:*.dotx=31:*.xls=31:*.xlsx=31:*.ppt=31:*.pptx=31:*.fla=31:*.psd=31:*.7z=1;35:*.apk=1;35:*.arj=1;35:*.bin=1;35:*.bz=1;35:*.bz2=1;35:*.cab=1;35:*.deb=1;35:*.dmg=1;35:*.gem=1;35:*.gz=1;35:*.iso=1;35:*.jar=1;35:*.msi=1;35:*.rar=1;35:*.rpm=1;35:*.tar=1;35:*.tbz=1;35:*.tbz2=1;35:*.tgz=1;35:*.tx=1;35:*.war=1;35:*.xpi=1;35:*.xz=1;35:*.z=1;35:*.Z=1;35:*.zip=1;35:*.ANSI-30-black=30:*.ANSI-01;30-brblack=01;30:*.ANSI-31-red=31:*.ANSI-01;31-brred=01;31:*.ANSI-32-green=32:*.ANSI-01;32-brgreen=01;32:*.ANSI-33-yellow=33:*.ANSI-01;33-bryellow=01;33:*.ANSI-34-blue=34:*.ANSI-01;34-brblue=01;34:*.ANSI-35-magenta=35:*.ANSI-01;35-brmagenta=01;35:*.ANSI-36-cyan=36:*.ANSI-01;36-brcyan=01;36:*.ANSI-37-white=37:*.ANSI-01;37-brwhite=01;37:*.log=01;32:*~=01;32:*#=01;32:*.bak=01;33:*.BAK=01;33:*.old=01;33:*.OLD=01;33:*.org_archive=01;33:*.off=01;33:*.OFF=01;33:*.dist=01;33:*.DIST=01;33:*.orig=01;33:*.ORIG=01;33:*.swp=01;33:*.swo=01;33:*,v=01;33:*.gpg=34:*.gpg=34:*.pgp=34:*.asc=34:*.3des=34:*.aes=34:*.enc=34:*.sqlite=34:'
