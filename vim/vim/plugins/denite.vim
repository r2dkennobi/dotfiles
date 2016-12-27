" **********************************
" Unite Settings
" Kenny Y
" 12/26/2016
" 
" References:
" http://qiita.com/okamos/items/4e1665ecd416ef77df7c
" http://baqamore.hatenablog.com/entry/2016/12/16/125341
" **********************************
noremap <Leader>f :Denite file_rec<CR>
noremap <Leader>b :Denite buffer<CR>
noremap <Leader>r :Denite directory_rec<CR>
noremap <Leader>g :Denite -mode=normal grep<CR>

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#map('_', "<C-j>", "<denite:do_action:split>")
call denite#custom#map('insert', "<C-j>", "<denite:do_action:split>")
call denite#custom#map('_', "<C-k>", "<denite:do_action:vsplit>")
call denite#custom#map('insert', "<C-k>", "<denite:do_action:vsplit>")

call denite#custom#map('insert', "jj", "<denite:enter_mode:normal>")
