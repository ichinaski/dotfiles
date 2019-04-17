call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'
Plug 'Raimondi/delimitMate'
"Plug 'w0rp/ale'
Plug 'elzr/vim-json', {'for' : 'json'}
Plug 'ekalinin/Dockerfile.vim', {'for' : 'Dockerfile'}
Plug 'pangloss/vim-javascript', {'for' : 'javascript'}
Plug 'vim-scripts/Visual-Mark'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on     " required

"=====================================================
"===================== SETTINGS ======================
"=====================================================
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
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype sh setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype html setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Color
syntax enable
colorscheme jellybeans

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

" Common typo
nnoremap :Q :q

" Edit .vimrc
nnoremap <Leader>ve :vsplit ~/.vimrc<CR>
" Reload .vimrc
nnoremap <Leader>vr :source ~/.vimrc<CR>

"=====================================================
"====================== PLUGINS ======================
"=====================================================

" =================== ale ==========================
let g:ale_linters = {
\    'go': ['go build'],
\    'python': ['flake8'],
\}

" ==================== vim-go ====================
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_def_mode = "gopls"
let g:go_rename_command = 'gopls'
let g:go_test_show_name = 1
let g:go_auto_sameids = 0
"let g:go_auto_type_info = 1

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_highlight_functions = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1

let g:go_addtags_transform = 'camelcase'
"
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

au FileType go nmap <silent> <leader>b <Plug>(go-build) " go build the current file
au FileType go nmap <silent> <leader>t <Plug>(go-test)  " go test the current file
au FileType go nmap <silent> <Leader>i <Plug>(go-info)
au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
au FileType go nmap <silent> <leader>r :GoReferrers<cr>     " Find references to the current symbol
nmap <C-g> :GoDecls<cr>
imap <C-g> <esc>:<C-u>GoDecls<cr>

" Disable these functions, I use CoC for GoTo
" au FileType go nmap <silent> <leader>g <Plug>(go-doc)   " Open the relevant Godoc for the word under the cursor

" au FileType go nmap <silent> <Leader>v <Plug>(go-def-vertical) "go-def, vertival split pane
" au FileType go nmap <silent> <Leader>s <Plug>(go-def-split)    "go-def, horizontal split pane

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
" For toggling
noremap <Leader>n :NERDTreeToggle<cr>
" noremap <Leader>f :NERDTreeFind<cr>

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

" ==================== coc ====================
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
"set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
