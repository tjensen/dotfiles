"""" Begin Vundle Setup Requirements
set nocompatible
filetype on
filetype off
packadd! matchit
" set the runtime path to include Vundle and initialize
if has('win32') || has('win64')
  set rtp+=~/vimfiles/bundle/Vundle.vim
else
  set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tjensen/inkpot'
Plugin 'dense-analysis/ale'
Plugin 'linediff.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'powerline/fonts'
Plugin 'pangloss/vim-javascript'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'plasticboy/vim-markdown'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-scripts/vim-coffee-script'
Plugin 'hashivim/vim-terraform'
Plugin 'PProvost/vim-ps1'
Plugin 'tjensen/vim-enforce'
Plugin 'guns/xterm-color-table.vim'
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
" Plugin 'leafgarland/typescript-vim'
call vundle#end()
filetype plugin indent on
"""" End Vundle Setup Requirements

" I like colors
syntax on
if has('vcon')
  " Windows 10 console now supports 24-bit color!
  set termguicolors
  set t_Co=256
endif
if has("gui_running") || &t_Co > 16
  colorscheme inkpot
else
  colorscheme elflord
endif
" UTF-8 Everywhere!
set encoding=utf-8
" Show unprintable characters
set list listchars=trail:·,tab:»-
" Always show the status line
set laststatus=2
" Adjust behavior of the backspace key
set backspace=indent,eol,start
" Show line numbers
set number numberwidth=6
" Don't pester me when using netrw
let g:netrw_silent = 1
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
" Standard convention for code indentation
set tabstop=4 shiftwidth=4 expandtab
" For toggling paste mode
nnoremap <silent> <leader>pp :setlocal paste!<CR>

" YAML stuff
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType yaml setlocal foldmethod=indent foldlevel=99

" JSON stuff
autocmd FileType json setlocal shiftwidth=2 tabstop=2 softtabstop=2

" HTML stuff
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html if line('$') < 5000 | :syntax sync fromstart | endif

" SCSS stuff
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Python stuff
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal textwidth=99 colorcolumn=101
highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.js match BadWhitespace /\s\+$/

" Javascript stuff
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal colorcolumn=101 textwidth=99

" Typescript stuff
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType typescript setlocal colorcolumn=101 textwidth=99

" Coffeescript stuff
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType coffee setlocal colorcolumn=101 textwidth=99

" Java stuff
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType java setlocal colorcolumn=101 textwidth=99

" Objective C stuff
autocmd FileType objc setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType objc setlocal colorcolumn=101 textwidth=99

" Markdown stuff
autocmd FileType markdown setlocal spell spelllang=en_us
let g:vim_markdown_folding_disabled = 1

" Text stuff
autocmd FileType text setlocal spell spelllang=en_us

" C stuff
autocmd FileType c setlocal textwidth=99 colorcolumn=101

" Ruby stuff
autocmd BufRead,BufNewFile Fastfile set filetype=ruby

" Rust stuff
autocmd FileType rust setlocal textwidth=99 colorcolumn=101
let g:rustfmt_autosave = 1

" ALE
let g:ale_set_quickfix = 1
let g:ale_open_list = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Airline
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

" Allow for system-specific settings that shouldn't be shared everywhere
if filereadable(glob("~/.vimrc_local"))
  source ~/.vimrc_local
endif

"
" vim:ts=2:sw=2:et
