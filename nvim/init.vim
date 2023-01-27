call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/Visual-Mark'
Plug 'tpope/vim-fugitive'
Plug 'ruanyl/vim-gh-line'

" Color and syntax
Plug 'EdenEast/nightfox.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP and completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'j-hui/fidget.nvim'

" Fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Go autoformatting
Plug 'mattn/vim-goimports'

call plug#end()

filetype plugin indent on

"=====================================================
"===================== SETTINGS ======================
"=====================================================
set autoindent
set number                      " Show line numbers 
set noswapfile                  " Don't use swapfile
set nobackup            	" Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set laststatus=2
set noshowmode                  " Show the mode with airline
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set expandtab                   " No tabs, exacept otherwise noted

set completeopt=menu,menuone,noselect

set diffopt=vertical
set cmdheight=2                 " Better display for messages
set updatetime=300              " Smaller updatetime for CursorHold & CursorHoldI
set shortmess+=c " don't give |ins-completion-menu| messages.

"http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
set clipboard+=unnamed,unnamedplus

colorscheme nightfox

" File Type settings
autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType json setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype javascript setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype sh setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype html setlocal expandtab shiftwidth=2 tabstop=2
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype lua setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

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

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

nnoremap <Leader>ss :setlocal spell! spell?<CR>

" Make space execute the 'q' macro. Press qq to start recording, q to stop, then [space] to execute.
" noremap <Space> @q

" Common typos
nnoremap :Q :q
nnoremap :W :w

" Edit and reload .vimrc
nnoremap <Leader>ve :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <Leader>vr :source ~/.config/nvim/init.vim<CR>

"=====================================================
"====================== PLUGINS ======================
"=====================================================

lua require('treesitter')
lua require('lsp')
lua require('completion')
lua require('fidget').setup{}

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

" ==================== Telescope ====================
nnoremap <leader>e <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>
nnoremap <leader>g <cmd>Telescope live_grep<cr>
nnoremap <leader>m <cmd>Telescope marks<cr>
nnoremap <leader>r <cmd>Telescope lsp_references<cr>
nnoremap <leader>s <cmd>Telescope lsp_document_symbols<cr>
nnoremap <C-g> <cmd>lua require("telescope.builtin").lsp_document_symbols({ symbols = { "struct", "function" } })<cr>
