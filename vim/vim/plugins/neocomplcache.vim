" **********************************
" Neocomplcache Settings
" Kenny Y
" 10/23/2014
" **********************************
if neobundle#is_sourced("neocomplcache")
    let g:neocomplcache_enable_at_startup = 1 " Use neocomplcache
    let g:neocomplcache_auto_completion_start_length = 3
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_min_keyword_length = 2
    let g:neocomplcache_min_syntax_length = 2
    let g:neocomplcache_max_list = 1000
    let g:neocomplcache_force_overwrite_completefunc = 1

    "" Define dictionary
    let g:neocomplcache_dictionary_filetype_lists = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'\.vimshell_hist'
                \}

    "" Tab completion
    inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

    "" Define keyword
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns={}
    endif
    let g:neocomplcache_force_omni_patterns.php='[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.c='[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp='[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

endif
