call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'flazz/vim-colorschemes'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'

" Plug 'Shougo/neocomplete.vim'
" Plug 'Shougo/vimproc' , { 'do': 'make'}

" filetype plugins
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

"
" Settings
"
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard^=unnamed
set clipboard^=unnamedplus

set noshowmatch                 " Do not show matching brackets by flickering
set nocursorcolumn
set noshowmode                  " We show the mode with airline or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set wildmenu                    " Better command-line completion

let mapleader=","
" set smartindent

" File Type settings
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" Enable syntax highlighting
syntax on

if has("gui_running")
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    " Set the window maximized by default
    set lines=999
    set columns=999

endif

" Color scheme
" colorscheme desert256
" colorscheme wombat
colorscheme jellybeans

" Toggle spelling with F6
set spelllang=en_us
nnoremap <F6> :setlocal spell! spell?<CR>

set guifont=Inconsolata\ 12

" diff options
set diffopt=vertical

" Instead of failing a command because of unsaved changes, raise a
" dialogue asking if you wish to save changed files.
set confirm

" Set the command window height to 2 lines
set cmdheight=2

" Find tags file recursively
set tags=tags;

" No preview window in completeopt
set completeopt-=preview

" ============
" = Mappings =
" ============

" Move windows with Ctrl + direction
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Remove highlight when pressing ESC
nnoremap <esc> :noh<CR><esc>

" New Tab
nnoremap :t :tabe 

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make space execute the 'q' macro.
" Press qq to start recording, q to stop, then [space] to execute.
" noremap <Space> @q

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

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ===========
" = Plugins =
" ===========

" ==================== syntastic ====================
let g:syntastic_auto_loc_list = 2 " manual open. automatic close.
nnoremap <Leader>e :Errors<CR>
nnoremap <Leader>ne :lclose<CR>

" Use godef for :GoDef
let g:go_def_mode = "godef"
" Better integration with vim-go when saving and opening files
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
" let g:go_list_type = "quickfix"

" ==================== vim-go ====================
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <leader>g <Plug>(go-doc)   " Open the relevant Godoc for the word under the cursor
au FileType go nmap <leader>r <Plug>(go-run)   " go run the current file
au FileType go nmap <leader>b <Plug>(go-build) " go build the current file
au FileType go nmap <leader>t <Plug>(go-test)  " go test the current file

" ==================== airline ====================
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" Cycle through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-w> :bd<CR>


" ==================== NerdTree ====================
nmap <F4> :NERDTreeToggle<CR>

" ==================== TagBar ====================
nmap <F5> :TagbarToggle<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1		
let g:delimitMate_expand_space = 1		
let g:delimitMate_smart_quotes = 1		
let g:delimitMate_expand_inside_quotes = 0		
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'		

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
