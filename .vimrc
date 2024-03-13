" .vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Runtime Path Manipulation
filetype off
execute pathogen#infect()

" No need to be compatible with vi
set nocompatible

" Show the mode (Command mode=null, INSERT, APPEND, ...)
set showmode

" Show command in action
set showcmd

" File type aware
filetype plugin indent on

" Syntax highlighting
syntax enable

" But only up to certain column to speed up
set synmaxcol=120

" Show matching parenthesis etc.
set showmatch

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" Background
set background=light
colorscheme solarized
set cursorline
set cursorcolumn

" Allow color schemes to do bright colors without forcing bold.
"if &t_Co == 8 && $TERM !~# '^linux'
"  set t_Co=16
"endif

" Show weird characters
set list

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
  endif
endif

" Line numbers
set number

" Cursor position
set ruler

" Always show statusline
set laststatus=2

" Show title
"set title

" TODO: What is this?
"set display+=lastline

" Use left-right keys in the menu
set wildmenu

" Use TAB to expand the menu?
set wildmode=longest,list:longest

" Do not beep
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Fast terminal - nicer redraw
set ttyfast

" Do not wrap long lines
set nowrap

" Width of text - then wrap
set textwidth=120

" Show a column
if has('colorcolumn')
  set colorcolumn=80
end

" Make cursor stay in the center of the screen
set scrolloff=10
set sidescrolloff=5

if has('gui_running')
  set guifont=Inconsolata:h18
endif

" VimRoom width
if !exists( "g:vimroom_width" )
  let g:vimroom_width=120
endif

" Allow backspacing over identation, end-of-line, and start-of-line
set backspace=2

" Allow for buffers with not yet saved changes
set hidden

" Reread files changed on disk but not in vim
set autoread

" Recognize also Mac EOL
set fileformats+=mac

" History
if &history < 1000
  set history=1000
endif

" Number of page tabs at max
if &tabpagemax < 50
  set tabpagemax=50
endif

" Save vim information for later usage
if !empty(&viminfo)
  set viminfo^=!
endif

" Incremental search
set incsearch

" Highlight search
set hlsearch

" Search lower and upper case with /string, but case sensitive with /String
" search with * works as usual
set ignorecase
set smartcase

" Spell
set spell

" Autoindentation
set autoindent

" Use 2 char width for displaying a TAB
set tabstop=2

" Use 2 spaces when using autoindent/cindent used with > and <
set shiftwidth=2

" TAB in the start of a line inserts 'shiftwidth' spaces instead of 'tabstop'
set smarttab

" Expand tabs to spaces when TAB is pressed.
set expandtab

" Make backspace and delete recognize to remove 'shiftwidth' number of spaces
set softtabstop=2

" Indenting follows 'shifwidth', i.e., jump to next indenting line and not
" 'shiftwidth' from the current position
set shiftround

" Do not scan all include files for autocompletion
set complete-=i
set complete=.,b,u

" Folding
set foldmethod=indent
set foldignore=

" Define shell type for :! or :sh
set shell=/bin/bash

" Autosave file when switiching to terminal with :!
set autowrite

" Wait for ???
set ttimeout
set ttimeoutlen=50

" Keybindings et al.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap = normal mode
" vnoremap = visual mode
" inoremap = insert mode

" Bring own help
" nnoremap <leader>h :e      ~/.vim/myhelp.txt<CR>
nnoremap <leader>h :tabnew ~/.vim/myhelp.txt<CR>

" Make use of a mouse
set mouse=a

" Make backspace work nicely
set backspace=indent,eol,start

" ; is an alias for :
nnoremap ; :

" Avoid system help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Avoid silly error
nnoremap :Wq :wq
nnoremap :W :w

" Search with ask
nnoremap <leader>a :Ack

" Toogle smart pasting
"set pastetoggle=<leader>p
nnoremap <leader>p :set invpaste paste?<CR>

" Reselect pasted text
nnoremap <leader>v V`]

" Use TAB to jump between brackets
" nnoremap <tab> %
" vnoremap <tab> %

" Completition menu
imap <tab> <C-p>

" Remove trailing whitespace on <leader><space>
nnoremap <leader><space> :%s/\s\+$//<cr>:let @/=''<CR>

" Toggle list
nnoremap <leader>l :set invlist<CR>

" Rewrap a paragraph
nnoremap <leader>q gq
nnoremap <leader>q gqip
nnoremap <leader>q gqap

" Splitting windows
nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh :sp<CR>
nnoremap <leader>so <vC-w>s<C-w>l
nnoremap <leader>sq <C-W>o

" Moving between windows
nnoremap <leader><left> <C-w>h
nnoremap <leader><up> <C-w>k
nnoremap <leader><down> <C-w>j
nnoremap <leader><right> <C-w>l

" Moving between buffers
nnoremap <leader>bc :badd<space>
nnoremap <leader>bs :Scratch<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bk :bdelete<CR>

" Moving between tabs
nnoremap <leader>tc :tabnew<space>
nnoremap <leader>ts :tabnew<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tk :tabclose<CR>

" Toggle numbers
nnoremap <leader>n :NumbersToggle<CR>
nnoremap <leader>nn :NumbersOnOff<CR>

" Toggle VimRoom
" nnoremap <silent> <leader>w <Plug>VimroomToggle<CR>
nnoremap <leader>w :VimroomToggle<CR>

" Toggle highlight search results
nnoremap <leader>hh :nohlsearch<CR>

" Commenting
xmap <leader>cc <Plug>Commentary
nmap <leader>cc <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap <leader>cu <Plug>CommentaryUndo

" Correcting spelling mistakes
nnoremap \s ea<C-X><C-S>

"compiling using F3
"map <F3> : call CompileGcc()<CR>
"func! CompileGcc()
"  exec "w"
"  exec "!gcc % -o %<"
"endfunc

"compile and execute using F9
"map <F9> :call CompileRunGcc()<CR>
"func! CompileRunGcc()
"  exec "w"
"  exec "!gcc % -o %<"
"  exec "! ./%<"
"endfunc
"
" Execute Pyhon file being edited with <Shift> + e:
" map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" File specific stuff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Comment character using commentary.vim
"autocmd FileType apache set commentstring=#\ %s

" My functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" function! MyHelp()
" endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc ends here
