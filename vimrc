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
Plugin 'scrooloose/syntastic'
Plugin 'linediff.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'powerline/fonts'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'plasticboy/vim-markdown'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-scripts/vim-coffee-script'
call vundle#end()
filetype plugin indent on
"""" End Vundle Setup Requirements

" I like colors
syntax on
colorscheme inkpot
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

" Coffeescript stuff
autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType coffee setlocal colorcolumn=101 textwidth=99

" Markdown stuff
let g:vim_markdown_folding_disabled = 1

" Syntastic
let g:syntastic_html_checkers = []
if filereadable('.eslintrc.js') || filereadable('.eslintrc.yaml') || filereadable('.eslintrc.yml') || filereadable('.eslintrc.json') || filereadable('.eslintrc')
  let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_html_checkers = ['eslint']
endif
if !empty(glob('node_modules/.bin/eslint'))
  let g:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
  let g:syntastic_html_eslint_exec = 'node_modules/.bin/eslint'
endif
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_python_exec = 'python'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline
let g:airline_detect_paste=1
let g:airline_inactive_collapse=1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1

" Allow for system-specific settings that shouldn't be shared everywhere
if filereadable(glob("~/.vimrc_local"))
  source ~/.vimrc_local
endif

"
" vim:ts=2:sw=2:et
