" **************************************
" Kenny Y
" 11/14/2015
" **************************************
" **************************************
" * PLUGINS
" **************************************
" vim-plug
" https://github.com/junegunn/vim-plug
"

if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif


call plug#begin('~/.vim/plugged')
" **************************************
" * BUNDLES
" **************************************
" VimProc
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neocomplete.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/syntastic'
Plug 'Apo11oH/vim-darknight'
Plug 'Apo11oH/gzoom'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'cohama/agit.vim'
Plug 'justinmk/vim-syntax-extra'
Plug 'easymotion/vim-easymotion'
Plug 'hdima/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'arcticicestudio/nord-vim'
Plug 'jacoborus/tender.vim'
Plug 'airblade/vim-gitgutter'
Plug 'nvie/vim-flake8'

call plug#end()

" **************************************
" * RUNTIME PATH
" **************************************
set runtimepath+=~/.vim/custom
set runtimepath+=~/.vim/plugins
runtime! custom/*.vim
runtime! plugins/*.vim

filetype plugin indent on
