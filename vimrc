" Basics {
"    profile start syntastic.log
"    profile! file */bundle/syntastic/*
    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
" My plugins (managed via vundle)
    Bundle 'gmarik/vundle'
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'tpope/vim-fugitive'
    Bundle 'scrooloose/syntastic'
    Bundle 'vim-scripts/vimwiki'
    Bundle 'mileszs/ack.vim'
    Bundle 'kien/ctrlp.vim'
    Bundle 'tomtom/tcomment_vim'
    Bundle 'Raimondi/delimitMate'
    Bundle 'Shougo/neocomplete.vim'
    Bundle 'Shougo/neosnippet.vim'
    Bundle 'honza/vim-snippets'
    Bundle 'bling/vim-airline'
    Bundle 'ntpeters/vim-better-whitespace'
    Bundle 'Rip-Rip/clang_complete'
    Bundle 'chazy/cscope_maps'

    filetype plugin indent on
    syntax on " syntax highlighting on
    set background=dark
    colorscheme solarized
    set noexrc " don't use local version of .(g)vimrc, .exrc
    set cpoptions=aABceFsmq
    "             |||||||||
    "             ||||||||+-- When joining lines, leave the cursor
    "             |||||||      between joined lines
    "             |||||||+-- When a new match is created (showmatch)
    "             ||||||      pause for .5
    "             ||||||+-- Set buffer options when entering the
    "             |||||      buffer
    "             |||||+-- :write command updates current file name
    "             ||||+-- Automatically add <CR> to the last line
    "             |||      when using :@r
    "             |||+-- Searching continues at the end of the match
    "             ||      at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
" }

" Vim UI {
    set pastetoggle=<F2> "<F2> toggles paste mode
    set cursorcolumn " highlight the current column
    set cursorline " highlight current line
    set incsearch " BUT do highlight as you type you
                   " search phrase
    " <Ctrl-l> redraws the screen and removes any search highlighting.
    nnoremap <silent> <C-l> :nohl<CR><C-l>
    set hlsearch
    set laststatus=2 " always show the status line
    set lazyredraw " do not redraw while running macros
    set linespace=0 " don't insert any extra pixel lines
                     " betweens rows
    set matchtime=5 " how many tenths of a second to blink
                     " matching brackets for
    set novisualbell " don't blink
    set number " turn on line numbers
    set numberwidth=5 " We are good up to 99999 lines
    set report=0 " tell us when anything is changed via :...
    set ruler " Always show current positions along the bottom
    set scrolloff=10 " Keep 10 lines (top/bottom) for scope
    set shortmess=aOstT " shortens messages to avoid
                         " 'press a key' prompt
    set showcmd " show the command being typed
    set showmatch " show matching brackets
    set sidescrolloff=10 " Keep 5 lines at the size
" Autocommands {
    if has("autocmd")
        "autocmd FileType tex source ~/.vim/latex.vim
        "autocmd FileType erlang source ~/.vim/erlang.vim
    endif " has("autocmd")

" mark overlong columns
set cc=90
" linebreak
set tw=100

set shiftwidth=4
set expandtab
set softtabstop=4

set tabpagemax=25
set autoindent
set encoding=utf8

function ToggleRelNumber()
    if &relativenumber
        set number
    else
        set relativenumber
    endif
endf
map <F4> :silent! call ToggleRelNumber()<CR>

" set font in gVim
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif
set exrc

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Autocommands ================================================================


"====== Neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Recommended key-mappings.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

imap <expr><CR> neosnippet#expandable() ?
\ "\<Plug>(neosnippet_expand)" : "\<CR>"
smap <expr><CR> neosnippet#expandable() ?
\ "\<Plug>(neosnippet_expand)" : "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
" let g:neocomplete#force_omni_input_patterns.objc =
"             \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)'
" let g:neocomplete#force_omni_input_patterns.objcpp =
"             \ '\[\h\w*\s\h\?\|\h\w*\%(\.\|->\)\|\h\w*::\w*'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0

