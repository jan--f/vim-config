" =============================================================================
" Basics {
" =============================================================================
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/syntastic'
    Plugin 'vim-scripts/vimwiki'
    Plugin 'mileszs/ack.vim'
    Plugin 'tomtom/tcomment_vim'
    Plugin 'Raimondi/delimitMate'
    Plugin 'Shougo/neocomplete.vim'
    Plugin 'Shougo/neosnippet.vim'
    Plugin 'honza/vim-snippets'
    Plugin 'bling/vim-airline'
    Plugin 'Rip-Rip/clang_complete'
    Plugin 'chazy/cscope_maps'
    Plugin 'Shougo/unite.vim'
    Plugin 'Shougo/vimproc.vim'
    Plugin 'majutsushi/tagbar'
    call vundle#end()

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

" =============================================================================
" Vim UI {
" =============================================================================
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
    set noswapfile
    set wildmenu " commandline autocompletion
    set wildmode=longest,full
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

    function! ToggleRelNumber()
        if &relativenumber
            set number
        else
            set relativenumber
        endif
    endf
    map <F4> :silent! call ToggleRelNumber()<CR>

" }

" =============================================================================
" Autocommands {
" =============================================================================
    augroup MyAutoCmd
      autocmd!
    augroup END
    " listchar=trail is not as flexible, use the below to highlight trailing
    " whitespace. Don't do it for unite windows or readonly files
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    augroup MyAutoCmd
      autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
      autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
      autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
      autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
    augroup END
    autocmd MyAutoCmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
                \ so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
" }

" =============================================================================
" Font {
" =============================================================================
    if has("gui_running")
      if has("gui_gtk2")
        set guifont=Inconsolata\ 12
      elseif has("gui_win32")
        set guifont=Consolas:h11:cANSI
      endif
    endif
" }

" =============================================================================
" Mappings {
" =============================================================================
    nnoremap <leader>ev :split $MYVIMRC<cr>
" }

" =============================================================================
" NeoComplete {
" =============================================================================
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Recommended key-mappings.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

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
" }

" =============================================================================
" Unite {
" =============================================================================
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>p :<C-u>Unite -buffer-name=files   -start-insert file_rec/async file<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>

autocmd MyAutoCmd FileType unite call s:unite_settings()
function! s:unite_settings()
    nmap <buffer> <ESC> <Plug>(unite_insert_enter)
    imap <buffer> <ESC> <Plug>(unite_exit)
endfunction
" }

" =============================================================================
" DelimitMate {
" =============================================================================
let delimitMate_expand_cr = 1
au FileType c,cpp let b:delimitMate_eol_marker = ";"
" }

" =============================================================================
" Tagbar {
" =============================================================================
  nmap <F5> :TagbarToggle<CR>
" }
