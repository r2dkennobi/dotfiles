" **********************************
" VimShell Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(":NeoBundle")
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    let g:vimshell_prompt =  '$ '
endif
