" -----------------------------------------------------------------------------
" Basics
" -----------------------------------------------------------------------------
" Be IMproved
set nocompatible
" Leader key
let mapleader = ","
" Enable pathogen bundle loader
call pathogen#infect()
" Recognize file types / set indent mode
filetype plugin indent on
"filetype plugin on
" Share OS clipboard
set clipboard=unnamed
" Allow mouse usage in terminal vim
set hlsearch
" Invisible characters
set mouse=a
" Always show status line
set laststatus=2
" Source vimrc files after editing
"autocmd bufwritepost .vimrc source <afile>
" Indention
set autoindent
"change terminal's title and revert it on exit
set title
let &titleold=""
" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :20  :  up to 20 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
" remember cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ignore case in searches ... (\c\C override)
set ignorecase
" ... unless there are caps in the search
set smartcase
set incsearch

" Automatically safe files when switchin between them / leaving vim
"set autowriteall
"autocmd FocusLost * silent! :wa
"autocmd TabLeave * silent! :wa
" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile
" Enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif
set completeopt=menuone,longest
" Ignore certain things
"set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

"get rid of the default mode indicator because we use airline
set noshowmode
"enable airline's smarter tab line extension
let g:airline#extensions#tabline#enabled = 1
"enable symbols of patched font
let g:airline_powerline_fonts = 1

"shorten pause when leaving insert mode
set ttimeoutlen=50

" -----------------------------------------------------------------------------
" Styling
" -----------------------------------------------------------------------------
" Syntax highlighting
syntax on
" Color Scheme
colorscheme summerfruit256
" Show Line numbers
set number
" Visual line marking 80 characters (vim 7.3)
if v:version >= 703
  set colorcolumn=80
endif
set list
" Highlight active line
set cursorline
hi CursorLine cterm=none
" Highlight search results
"set hlsearch
" Invisible characters
autocmd BufEnter * set listchars=tab:▸\ ,eol:¬

" -----------------------------------------------------------------------------
" Tabs vs. Spaces
" -----------------------------------------------------------------------------
" Spaces instead of tabs
set expandtab
" 2 spaces for each tab
set tabstop=2
" 2 spaces for indention
set shiftwidth=2

" -----------------------------------------------------------------------------
" snipmate
" -----------------------------------------------------------------------------
" Configure snipmate dir
let g:snippets_dir="~/.vim/snippets"


" -----------------------------------------------------------------------------
" Key bindings
" -----------------------------------------------------------------------------
" NERDCommenter
map <Leader>c <plug>NERDCommenterToggle

" Edit user .vimrc
nmap <Leader>v :e ~/.vimrc<CR>
" Source the vimrc file after saving it
"if has("autocmd")
  "autocmd bufwritepost .vimrc source ~/.vimrc
"endif

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" In addition to <esc>, jj will exit to normal mode.
inoremap jj <ESC>

" vim-unimpared
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Switch between buffers
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

" Clear search results when hitting space
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Show current file as HTML
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>

" -----------------------------------------------------------------------------
" File type specifics *
" -----------------------------------------------------------------------------
" Execute current file with node.js
autocmd BufEnter *.js nmap <Leader><Leader> :w<CR>:!node %:p<CR>

" Recognise file by extension
autocmd BufEnter *.json set filetype=javascript
autocmd BufEnter *.dust set filetype=html

