" **********************************
" Tmux Line Settings
" Kenny Y
" 10/23/2014
" **********************************
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_powerline_separators = 0
let g:tmuxline_theme = 'icebert'
let g:tmuxline_preset = {
            \'a'    : '#S',
            \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
            \'win'  : ['#I', '#W'],
            \'cwin' : ['#I', '#W', '#F'],
            \'x'    : '#(date)',
            \'y'    : ['%R', '%a', '%Y'],
            \'z'    : '#H'}
