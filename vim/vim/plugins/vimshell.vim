" **********************************
" VimShell Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(":NeoBundle")
    let g:vimshell_user_prompt = '"(".getcwd().")--(".$USER."@".hostname().")"'
    let g:vimshell_prompt =  '$ '
    let g:vimshell_ignore_case = 1
    let g:vimshell_smart_case = 1
endif
