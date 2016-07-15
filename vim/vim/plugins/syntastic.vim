" **********************************
" Unite Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(':NeoBundle')
    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_auto_loc_list=1
    let g:syntastic_enable_signs=1
    let g:syntastic_cpp_compiler_options='-std=c++11'
    let g:syntastic_check_on_wq = 0
    let g:syntastic_mode_map = { "mode": "passive" }
    nnoremap <F12> :SyntasticToggleMode<CR>
    "let g:syntastic_python_python_exec ='/path/to/python'
endif
