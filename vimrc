" Basics {
"    profile start syntastic.log
"    profile! file */bundle/syntastic/*
    filetype off
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
" My plugins (managed via vundle)
    Bundle 'gmarik/vundle'
    Bundle 'altercation/vim-colors-solarized'
"    Bundle 'msanders/snipmate.vim'
    Bundle 'tpope/vim-fugitive'
    Bundle 'scrooloose/syntastic'
    Bundle 'vim-scripts/vimwiki'
    Bundle 'mileszs/ack.vim'
"    Bundle 'ervandew/supertab'
    Bundle 'kien/ctrlp.vim'
    Bundle 'tomtom/tcomment_vim'
"    Bundle 'PeterRincker/vim-argumentative'
    Bundle 'Raimondi/delimitMate'
    Bundle 'Shougo/neocomplete.vim'
    Bundle 'Shougo/neosnippet.vim'
    Bundle 'honza/vim-snippets'
    Bundle 'bling/vim-airline'
    Bundle 'ntpeters/vim-better-whitespace'
"    Bundle 'hcs42/vim-erlang-runtime'

    filetype plugin indent on
    syntax on " syntax highlighting on
    filetype indent on
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
    " set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    "              | | | | |  |   |      |  |     |    |
    "              | | | | |  |   |      |  |     |    + current
    "              | | | | |  |   |      |  |     |       column
    "              | | | | |  |   |      |  |     +-- current line
    "              | | | | |  |   |      |  +-- current % into file
    "              | | | | |  |   |      +-- current syntax in
    "              | | | | |  |   |          square brackets
    "              | | | | |  |   +-- current fileformat
    "              | | | | |  +-- number of lines
    "              | | | | +-- preview flag in square brackets
    "              | | | +-- help flag in square brackets
    "              | | +-- readonly flag in square brackets
    "              | +-- rodified flag in square brackets
    "              +-- full path to file in the buffer
" }
" Autocommands {
    if has("autocmd")
        "autocmd FileType tex source ~/.vim/latex.vim
        "autocmd FileType erlang source ~/.vim/erlang.vim
    endif " has("autocmd")
set textwidth=80
set shiftwidth=4
set expandtab
set tabstop=4
set tabpagemax=25
set autoindent
set autochdir
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

"====== Neocomplete
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Neosnippet. Configuration taken from the README
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?  "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" highlight trailing whitespaces
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" autocmd BufWinLeave * call clearmatches()
