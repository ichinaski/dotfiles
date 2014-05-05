" Activate pathogen plugin
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Encoding and language of the menu (gvim)
set encoding=utf-8

let mapleader=","

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

" gvim. TODO: Move this to a separate .gvimrc config file
if has("gui_running")
    set guioptions-=T

    " Set the window maximized by default
    set lines=999
    set columns=999

    " Remove highlight when pressing ESC
    nnoremap <esc> :noh<CR><esc>
endif

" Clipboard compatibility
if has("unnamedplus")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

" Backup stuff
set nobackup
set nowritebackup

" Line numbers
set number

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

" Tabs
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

" Find tags file recursively
set tags=tags;

" ============
" = Mappings =
" ============

" tab next/previous with keys
"nnoremap <C-S-H>   :tabp<ENTER>
"nnoremap <C-S-L>   :tabn<ENTER>
"nnoremap <C-tab>   :tabn<ENTER>
"nnoremap <C-S-tab> :tabp<ENTER>

" Move windows with Ctrl + direction
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" New Tab
nnoremap :t :tabe 

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make space execute the 'q' macro.
" Press qq to start recording, q to stop, then [space] to execute.
noremap <Space> @q

" Go to last edited position
nnoremap <c-q> `.

" XML formatter - http://vim.wikia.com/wiki/Pretty-formatting_XML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" Omni Completion
set omnifunc=syntaxcomplete#Complete

" ===========
" = Plugins =
" ===========

" GitGutter: Change sign column color, matching line number column
highlight clear SignColumn

" go-vim
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" gofmt Go source files when they are saved
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Regenerate Go tags file with gotags
" Note: ctags-compatible tag generator for Go https://github.com/jstemmer/gotags
" au BufWritePost *.go silent! !gotags -R . > tags &
nnoremap <Leader>t :silent !gotags -R . > tags &<CR>

" Do not split windows with godef
let g:godef_split=0

" MiniBufExpl
nmap <F3> :MBEToggle<CR>
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" NerdTree
nmap <F4> :NERDTreeToggle<CR>
