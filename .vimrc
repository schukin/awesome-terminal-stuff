set nobackup		" Don't keep a backup file
set number		" Show line numbers
set showmatch		" Show matching brackets
set matchpairs+=<:>	" Have % bounce between angled brackets, as well as other kinds
set nocompatible	" Does cool VIM stuff

" ### Tabs ##################
set softtabstop=4
set shiftwidth=4
set tabstop=4
set noexpandtab
set autoindent

" ### Status ################
set title		" Show title in menu bar
set ruler		" Show cursor position all the time
set showmode		" Show current mode
set showcmd		" Show partially-typed commands

set cursorline		" Highlight cursor line
"set cursorcolumn	" Highlight cursor column

syntax on		" Syntax highlighting

set wildmenu
set wildmode=list:longest,full

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Highlight things that we find with the search
set hlsearch

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;
