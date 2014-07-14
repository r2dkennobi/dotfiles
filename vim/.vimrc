" ~/.vimrc
" Kenny Y
" 05/12/2014

" **************************************
" * VARIABLES
" **************************************
:set nocompatible               " get rid of strict vi compatibility!
:set nu                         " line numbering on
:set autoindent                 " autoindent on
:set noerrorbells               " no error bells
:set modeline                   " changes setting based on file
:set showmode                   " show the mode on the dedicated line
:set nowrap                     " no wrapping
:set ignorecase                 " search without regards to case
:set backspace=indent,eol,start " backspace over everything
:set fileformats=unix,dos,mac   " open files from mac/dos
:set exrc                       " open local config files
:set nojoinspaces               " don't add white space when combining lines
:set ruler                      " which line am I on?
:set showcmd                    " show current command
:set showmatch                  " ensure Dyck language
:set incsearch                  " incremental searching
:set bs=2                       " fix backspacing in insert mode
:set bg=dark                    " Set the background to dark
:set expandtab                  " replace tab with space
:set shiftwidth=4               " determins the number of char per indent
:set tabstop=4                  " replaces current tab with specified number
:set wrap                       " enable word wrapping
:set laststatus=2               " Sets the number of lines at the bottom
:set t_Co=256                   " Enable 256 colors in vim
:set ttimeoutlen=50             " Set delay between mode switching
:set wildignore=*.swp,*.bak,*.pyc,*.class   " Ignore certain file formats
:set history=1000               " Remember more commands and search history
":set undolevels=1000            " MOAR UNDOOO
:set nobackup                   " Disable backup files
":set noswapfile                 " Diable swap files (Caution)
colorscheme desert              " Set the colorscheme to desert
"colorscheme hybrid             " Set the colorscheme to desert
:let mapleader='\'              " Default <leader> key

" Custom keybindings
" Capitalizes a single word in insert mode
:inoremap <c-u> <Esc>viwUi
" Shortcut to open the vimrc file for easy editing
:nnoremap <leader> ev :e $MYVIMRC<cr>
" Shortcut to source the vimrc file
:nnoremap <leader>sv :source $MYVIMRC<cr>

" Adjusts the default gvim size
if has("gui_running")
    set lines=35 columns=111
    " If windows gvim, use the following fonts
    if has("win32")
        :set guifont=Consolas:h9:cANSI
    endif
endif

" Unlimited undo
if has('persistent_undo')
    set undodir=!/.vim/undo
    set undofile
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Marks the 80 charactor line position regardless of the vim version
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif

" Expand tabs in certain files to spaces
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,ml,scala,html} set expandtab
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,ml,scala,html} set shiftwidth=2
au BufRead,BufNewFile *.{c,cpp,h,hpp,java,py,ml,scala,html} set tabstop=2

" Do not expand tabs in assembly file.  Make them 8 chars wide.
au BufRead,BufNewFile {*.s,Makefile} set noexpandtab
au BufRead,BufNewFile {*.s,Makefile} set shiftwidth=8
au BufRead,BufNewFile {*.s,Makefile} set tabstop=8

" Show syntax
syntax on

" Automatically treat .md files as .mkd files
au BufRead,BufNewFile *.{markdown,mdown,mkd,mkdn,md} setf markdown

" For switching between many opened file by using ctrl+l or ctrl+h
map <c-e> :next <CR>
map <C-q> :prev <CR>

" For fixing mixed indentation problems
" Note: gg=G (Move to top of file and fix to the end
map <F7> mzgg=G`z<CR>

" For fixing trailing whitespaces
" Note: :%s/\s\+$//
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Swithing between split window
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Automatic parenthesis cursor adjustment
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
" Do I really need this one?
imap // //<Left>
" Used for Perl programming
imap /// ///<Left>

" Status bar related
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\

" Typo fixing
:iabbrev adn and
:iabbrev waht what
:iabbrev tehn then

" **************************************
" * PLUGINS
" **************************************
" NeoBundle Setup
" mkdir -p ~/.vim/bundle
" git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/')) " Required
NeoBundleFetch 'Shougo/neobundle.vim' " Required
filetype plugin indent on " Required for NeoBundle
NeoBundleCheck " If ther are uninstalled bundles, this will clean it

" **************************************
" * BUNDLES
" **************************************
" VimProc
NeoBundle 'Shougo/vimproc', {
            \ 'build' : {
            \     'windows' : 'make -f make_mingw32.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'unix' : 'make -f make_unix.mak',
            \    },
            \ }
set rtp+=~/.vim/bundle/vimproc/autoload/
set rtp+=~/.vim/bundle/vimproc/plugin/

" VimShell
NeoBundle 'Shougo/vimshell'
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '

" Unite.vim
NeoBundle 'Shougo/unite.vim'
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

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
let g:acp_enableAtStartup = 0 " Disable AutoComplPop (Conflict)
let g:neocomplcache_enable_at_startup = 1 " Use neocomplcache
let g:neocomplcache_enable_smart_case = 1 " Use smartcase
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

"" Define dictionary
let g:neocomplcache_dictionary_filetype_lists = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'\.vimshell_hist'
            \}

"" Define keyword
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"" Plugin key-mappings
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

"" Recommended key-mappings.
"" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
"" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"" Enable omni completion
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" NERD Tree
"NeoBundle 'scrooloose/nerdtree'
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"map <C-n> :NERDTreeToggle<CR>
"nnoremap <Leader>1   :e #1<CR>
"nnoremap <Leader>2   :e #2<CR>
"nnoremap <Leader>3   :e #3<CR>
"nnoremap <Leader>4   :e #4<CR>
"nnoremap <Leader>5   :e #5<CR>
"nnoremap <Leader>6   :e #6<CR>
"nnoremap <Leader>7   :e #7<CR>
"nnoremap <Leader>8   :e #8<CR>
"nnoremap <Leader>9   :e #9<CR>
"nmap ,b :buffers<CR>

" Tagbar
NeoBundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" VOoM
NeoBundle 'vim-scripts/VOoM'
nmap <F9> :VoomToggle<CR>

" Vim-airline
NeoBundle 'bling/vim-airline'
let g:airline_theme = 'bubblegum'
let g:airline_enable_branch = 1
let g:airline_left_sep='>'
let g:airline_right_sep='<'
let g:airline_detect_modified=1
let g:airline_detect_paste=1
"let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#showbuffers = 1
let g:airline#extensions#branch#enabled = 1

" Vim-fugitive (github thing)
NeoBundle 'tpope/vim-fugitive'

" TmuxLine ()
NeoBundle 'edkolev/tmuxline.vim'
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

" Vim markdown plugin
NeoBundle 'plasticboy/vim-markdown'

" ctrlp
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Syntastic
"NeoBundle 'scrooloose/syntastic'
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
"let g:syntastic_cpp_compiler='-std=c++11'

" undotree
NeoBundle 'mbbill/undotree'
nmap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'topleft'
let g:undotree_SplitWidth = 35
let g:undotree_diffAutoOpen = 1
let g:undotree_diffpanelHeight = 25
let g:undotree_RelativeTimestamp = 1
let g:undotree_TreeNodeShape = '*'
let g:undotree_HighlightChangedText = 1
let g:undotree_HighlightSyntax = "UnderLined"

" hybrid (color scheme)
NeoBundle 'w0ng/vim-hybrid'
