"""" Begin Vundle Setup Requirements
set nocompatible
filetype on
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ciaranm/inkpot'
Plugin 'andviro/flake8-vim'
Plugin 'scrooloose/syntastic'
Plugin 'linediff.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()
filetype plugin indent on
"""" End Vundle Setup Requirements

" I like colors
syntax on
colorscheme inkpot
" Show cursor position on the status line
set ruler
" Show unprintable characters
set list listchars=trail:·,tab:»-
" Always show the status line
set laststatus=2
" Adjust behavior of the backspace key
set backspace=indent,eol,start
" Show line numbers
set number numberwidth=6
"
set encoding=utf-8
set modeline modelines=5
set wildmode=list:longest
set wildignore=*.o,*.d
if version >= 700
  set diffopt=filler,vertical
endif
set scrolloff=3
set spelllang=en
if exists('+colorcolumn')
  set colorcolumn=80
endif
" Jump to open window containing specified buffer, else split a new window
set switchbuf=useopen,split
" SWIG .i files
autocmd BufRead,BufNewFile *.i set filetype=swig
" Jump to last known position in file, if available
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" C/C++ comment continuation rules
au FileType c,cpp set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
" XML folding
let g:xml_syntax_folding=1
au FileType xml if line('$') < 10000 | setlocal foldmethod=syntax | endif
" Code review helpers
augroup VCSCommand
  au VCSCommand User VCSVimDiffFinish wincmd x
augroup END
nnoremap <F11> <C-W><C-F><C-W>_5<C-W>-:setlocal number<CR>:VCSVimDiff $BRANCHED_ON_REV<CR>
nnoremap <F12> <C-W><C-B>:only<CR>
" Standard convention for code indentation
set tabstop=4 shiftwidth=4 expandtab
"
" vim:ts=2:sw=2:et
