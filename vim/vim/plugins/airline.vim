" **********************************
" Vim-airline Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(':NeoBundle')
    let g:airline_theme = 'bubblegum'
    let g:airline_left_sep=""
    let g:airline_right_sep=""
    let g:airline_enable_branch = 1
    let g:airline_detect_modified=1
    let g:airline_detect_paste=1
    "let g:airline_powerline_fonts=1
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#showbuffers = 1
    let g:airline#extensions#branch#enabled = 1
endif
