" **********************************
" Unite Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(":NeoBundle")
    let g:unite_enable_start_insert=1
    let g:unite_source_history_yank_enable=1
    noremap <Leader>f :Unite -buffer-name=files file<CR>
    noremap <Leader>b :Unite -buffer-name=files buffer <CR>
    noremap <Leader>r :Unite -buffer-name=register register<CR>
    noremap <Leader>g :Unite grep:.<CR>

    au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
    au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
    au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
endif
