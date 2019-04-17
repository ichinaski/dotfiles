call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'Raimondi/delimitMate'
Plug 'w0rp/ale'

" filetype plugins
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'pangloss/vim-javascript', {'for' : 'javascript'}

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

"
" Settings
"
set noerrorbells                " No beeps
set autoindent
set number                      " Show line numbers 
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf-8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set laststatus=2
set hidden
set noshowmatch                 " Do not show matching brackets by flickering
set nocursorcolumn
set noshowmode                  " We show the mode with airline or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set wildmenu                    " Better command-line completion
set expandtab                   " No tabs, exacept otherwise noted
set completeopt-=preview        " No preview window in completeopt
set diffopt=vertical

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard+=unnamed
set clipboard+=unnamedplus


" File Type settings
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=8 sts=4 sw=4
autocmd Filetype sh setlocal ts=4 sts=4 sw=4

" Enable syntax highlighting
syntax on

" Color scheme
colorscheme jellybeans

" ============
" = Mappings =
" ============
let mapleader=","

" Cycle through buffers
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-w> :bd<CR>

" Move windows with Ctrl + direction
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Remove highlight when pressing (double) ESC
nnoremap <esc><esc> :noh<CR><esc>

" New Tab
nnoremap :t :tabe 

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

nnoremap <F6> :setlocal spell! spell?<CR>

" Make space execute the 'q' macro.
" Press qq to start recording, q to stop, then [space] to execute.
" noremap <Space> @q

" Go to last edited position
nnoremap <c-q> `.

" Common typo
nnoremap :Q :q

" ===========
" = Plugins =
" ===========

" =================== ale ==========================
let g:ale_linters = {
\    'go': ['go build'],
\    'python': ['flake8'],
\}

" ==================== vim-go ====================
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_info_mode = "gocode"
let g:go_def_mode = "gopls"
let g:go_test_show_name = 1

let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1

let g:go_addtags_transform = 'camelcase'

au FileType go nmap <leader>g <Plug>(go-doc)   " Open the relevant Godoc for the word under the cursor
au FileType go nmap <leader>r <Plug>(go-run)   " go run the current file
au FileType go nmap <leader>b <Plug>(go-build) " go build the current file
au FileType go nmap <leader>t <Plug>(go-test)  " go test the current file

" ==================== airline ====================
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename

" ==================== NerdTree ====================
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
noremap <Leader>f :NERDTreeFind<cr>

let NERDTreeShowHidden=1

" ==================== vim-json ====================
let g:vim_json_syntax_conceal = 0

" ==================== vim-javascript ====================
let g:jsx_ext_required = 0

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1		
let g:delimitMate_expand_space = 1		
let g:delimitMate_smart_quotes = 1		
let g:delimitMate_expand_inside_quotes = 0		
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'		
