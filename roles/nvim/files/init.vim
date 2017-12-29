""""""""""""""""""""""""""""""""""""""""""""""""
" Neovim config
" Author: r2dkennobi
" Shall we play a game?
""""""""""""""""""""""""""""""""""""""""""""""""

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.config/nvim/')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

" Common settings """""""""""""""""""""""""""""""
set number                      " line numbering on
set noswapfile                  " no swap file!
set expandtab
set tabstop=2
set shiftwidth=2
set wildmenu
set nohlsearch
set wildmode=longest:full,full
set wildignore+=*.swp,*.bak,*.dll,*.o,*.obj,*.pyc.*.exe
set wildignore+=*.jpg,*.gif,*.png,*.class,*.ln
set listchars=tab:>-,trail:-,eol:$,nbsp:%
set colorcolumn=80
" Searching options
set ignorecase
set smartcase
set infercase
set incsearch
set list

" Disable unwanted features
nnoremap Q <nop>                " Ugh, Ex mode
map q <nop>                     " Ugh, macro mode

" Custom key mapping
nmap cp :let @+= expand("~")<CR> " copy current file path to clipboard...?

" Tab navigation
nnoremap <silent> H gT
nnoremap <silent> L gt

" Special keyboard mapping
nnoremap <silent> <F3> :lcd %:p:h<CR> " Change local directory to file location
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <silent> <F6> :set hlsearch!<CR>
nnoremap <silent> <F7> mzgg=G`z<CR>
nnoremap <silent> <F10> :set list!<CR>
nnoremap / /\v

" Panel navigation
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

nmap <silent> <C-e> :wincmd R<CR>
nmap <silent> <Up> :wincmd K<CR>
nmap <silent> <Down> :wincmd J<CR>
nmap <silent> <Left> :wincmd H<CR>
nmap <silent> <Right> :wincmd L<CR>

" Filetype handling
au BufRead,BufNewFile *.{markdown,mdown,mkd,mkdn,md} set syntax=markdown
au BufRead,BufNewFile *.{launch} set syntax=xml
au BufRead,BufNewFile *.{jade} set syntax=jade
au BufRead,BufNewFile *.{rs} set syntax=rust filetype=rust
au BufRead,BufNewFile *.{s,Makefile} set noet sw=8 ts=8
au BufRead,BufNewFile *.{c,cpp,h,hpp} set et sw=2 ts=2
au BufRead,BufNewFile *.{java,ml,scala} set et sw=4 ts=4
au BufRead,BufNewFile *.{conf} set et sw=2 ts=2
augroup filetype_go
  au FileType go set noet sw=4 ts=4 sts=4
augroup END
augroup filetype_ruby
  au FileType ruby set et sw=2 ts=2
augroup END
augroup filetype_html
  au FileType html set et sw=4 ts=4
augroup END
augroup filetype_python
  au FileType python set et sw=4 ts=4 cc=100
augroup END
augroup filetype_shell
  au FileType sh set et sw=2 ts=2
augroup END

try
  colorscheme tender
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme desert
endtry

augroup file_restore
  autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 
augroup END
