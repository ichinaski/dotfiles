call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/Visual-Mark'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'ruanyl/vim-gh-line'
Plug 'nordtheme/vim'

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

"=====================================================
"===================== SETTINGS ======================
"=====================================================
set belloff=all
set autoindent
set number                      " Show line numbers 
set backspace=indent,eol,start  " Makes backspace key more powerful.
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
set noshowmode                  " We show the mode with airline or lightline
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set wildmenu                    " Better command-line completion
set expandtab                   " No tabs, exacept otherwise noted
set completeopt=longest,menuone " don't preselect, always a menu even with single match
set diffopt=vertical
set cmdheight=2                 " Better display for messages
set updatetime=300              " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c                " don't give |ins-completion-menu| messages.

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard+=unnamed,unnamedplus

" File Type settings
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype sh setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype html setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Color
syntax enable
set termguicolors
colorscheme nord

"=====================================================
"===================== MAPPINGS ======================
"=====================================================
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

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

nnoremap <Leader>ss :setlocal spell! spell?<CR>

" Autocompletion. Triggered with ctrl-space. Enable cycling with TAB
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"=====================================================
"====================== PLUGINS ======================
"=====================================================

" ==================== vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_autodetect_gopath = 1

let g:go_gopls_complete_unimported = 1
let g:go_gopls_gofumpt = 1

" 2 is for errors and warnings
let g:go_diagnostics_level = 2 
let g:go_doc_popup_window = 1
let g:go_doc_balloon = 1

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_fold_enable = []

nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

augroup go
  autocmd!

  autocmd FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical)
  autocmd FileType go nmap <silent> <Leader>s <Plug>(go-def-split)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-def-tab)

  autocmd FileType go nmap <silent> <Leader>i <Plug>(go-doc)
  autocmd FileType go nmap <silent> <Leader>r <Plug>(go-referrers)
  autocmd FileType go nmap <silent> <Leader>d <Plug>(go-diagnostics)

  autocmd FileType go nmap <silent> <leader>b <Plug>(go-build)
  autocmd FileType go nmap <silent> <leader>t <Plug>(go-test)
  autocmd FileType go nmap <silent> <Leader>c <Plug>(go-coverage-toggle)
augroup END

" ==================== FZF ====================
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'down': '~20%' }

" search across files in the current directory
nmap <C-e> :FzfFiles<cr>
imap <C-e> <esc>:<C-u>FzfFiles<cr>

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" ==================== airline ====================
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline_section_b = ''

" ==================== NerdTree ====================
let NERDTreeShowHidden=1
noremap <Leader>n :NERDTreeToggle<cr>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" ==================== delimitMate ====================
let g:delimitMate_expand_cr = 1		
let g:delimitMate_expand_space = 1		
let g:delimitMate_smart_quotes = 1		
let g:delimitMate_expand_inside_quotes = 0		
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'		
