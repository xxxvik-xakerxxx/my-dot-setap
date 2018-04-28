" General Settings{{{

if &compatible
    set nocompatible
endif

if !exists("g:syntax_on")
    syntax enable
endif

filetype plugin indent on

set autoindent
set autoread
set backspace=indent,eol,start 
set clipboard=unnamedplus
set complete-=t
set expandtab
set fillchars+=fold:\  " whitespace
set fillchars+=vert:\  " whitespace
set foldmethod=marker
set foldopen=insert,jump,mark,search,undo,quickfix
set hidden
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:‡\ ,nbsp:·
set nocursorline
set noshowmode
set noswapfile
set shiftwidth=4
set shortmess+=a
set shortmess+=c
set shortmess+=I
set shortmess+=s
set smartcase
set smarttab
set splitbelow
set splitright
set tabstop=4
set ttimeout
set ttimeoutlen=10
set ttyfast
set undodir=/tmp/undo
set undofile
set wildmenu

"}}}

" Plugins{{{
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Raimondi/delimitMate' 
    " let delimitMate_expand_cr = 1
    let delimitMate_smart_matchpairs = '^\%(\w\|\!\|[£]\|[^[:space:][:punct:]]\)'
Plug 'tpope/vim-commentary'
Plug 'mhinz/vim-sayonara'
Plug 'ap/vim-buftabline' 
    let g:buftabline_show=1
Plug 'tommcdo/vim-lion' 
    let g:lion_squeeze_spaces = 1
Plug 'junegunn/fzf.vim' 
    Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
    let g:fzf_layout = { 'down': '~20%' }
    let $FZF_DEFAULT_COMMAND='rg /home/vxid/ --files --hidden --smart-case -uu -g
                \"!{.git,node_modules,music}/*"'
call plug#end()
"}}}

" UI{{{

colorscheme operator
set statusline=%<\ %f\ %m%r%=

" Cursor
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\e[6 q"
    let &t_SR = "\e[4 q"
    let &t_EI = "\e[2 q"
endif
"}}}

" Bindings {{{

let mapleader=" "
nnoremap <Leader><Space> :FZF<CR>
nnoremap <Leader>v       :source $MYVIMRC<CR>
nnoremap <Leader>z       :setlocal spell! spelllang=fr<CR>
nnoremap <c-l> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

xnoremap < <gv
xnoremap > >gv

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
nnoremap <C-K> :Sayonara!<CR>

noremap Y y$

nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
"}}}

" Autocommands {{{
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
"}}}
