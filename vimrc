" Encoding and language of the menu (gvim)
set encoding=utf-8
set langmenu=en_US.UTF-8

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Allow intelligent auto-indenting for each filetype
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" No wrap-around search
" set nows

" Remove toolbar (gvim)
set guioptions-=T

" Clipboard compatibility
set clipboard=unnamedplus

" Backup stuff
set nobackup
set nowritebackup

" Line numbers
set number

" Set the window maximized by default
set lines=999
set columns=999

" Color scheme
colorscheme murphy

" no case search by default (ic), unless capital letters used
set ignorecase
set smartcase

" Highlight as you type
set incsearch
set hlsearch

" Enable spelling
set spell
set spell spelllang=en_us

" Set OS specifics.
if has("win32")
    set guifont=Consolas:h12
    " Adds windows default copy/paste keybindings (Ctrl-C, Ctrl-V,...)
    source $VIMRUNTIME/mswin.vim
    behave mswin
else
    set guifont=Inconsolata\ 12
endif

" diff options
set diffopt=vertical

" Tab stuff
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

" Instead of failing a command because of unsaved changes, raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
"set visualbell

" Set the command window height to 2 lines
set cmdheight=2

" ============
" = Mappings =
" ============

" tab next/previous with keys
nnoremap <C-S-H>   :tabp<ENTER>
nnoremap <C-S-L>   :tabn<ENTER>
nnoremap <C-tab>   :tabn<ENTER>
nnoremap <C-S-tab> :tabp<ENTER>

" Remove highlight when pressing ESC
nnoremap <esc> :noh<CR><esc>

" New Tab
nnoremap :t :tabe 

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
