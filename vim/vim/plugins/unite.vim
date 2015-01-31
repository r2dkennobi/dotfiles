" **********************************
" Unite Settings
" Kenny Y
" 10/23/2014
" **********************************
if exists(":NeoBundle")
    let g:unite_enable_start_insert=1
    nnoremap [unite] <Nop>
    nmap <Leader>f [unite]

    nnoremap [unite]u  :<C-u>Unite -no-split<Space>
    nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
    nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
    nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
    nnoremap <silent> ,vr :UniteResume<CR>

    nnoremap <silent> ,vb :Unite build<CR>
    nnoremap <silent> ,vcb :Unite build:!<CR>
    nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>
endif
