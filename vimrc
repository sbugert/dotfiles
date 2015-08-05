scriptencoding utf-8
" -----------------------------------------------------------------------------
" Basics
" -----------------------------------------------------------------------------
" Be IMproved
if &compatible | set nocompatible | endif

" Vundle setup
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'bling/vim-airline' " lean & mean status/tabline for vim that's light as air
Plugin 'airblade/vim-gitgutter' " shows a git diff in the gutter (sign column) and stages/reverts hunks
Plugin 'tpope/vim-fugitive' " a Git wrapper so awesome, it should be illegal
Plugin 'garbas/vim-snipmate' " implements some of TextMate's snippets features
  Plugin 'tomtom/tlib_vim'
  Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'kien/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
Plugin 'Lokaltog/vim-distinguished' " Color scheme
Plugin 'Valloric/YouCompleteMe' " A code-completion engine for Vim
Plugin 'marijnh/tern_for_vim' " provides Tern-based JavaScript editing support.
Plugin 'pangloss/vim-javascript' " Vastly improved Javascript indentation and syntax support in Vim
Plugin 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plugin 'scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/syntastic' " Syntax checking hacks for vim
Plugin 'tpope/vim-repeat' " enable repeating supported plugin maps with .
Plugin 'tpope/vim-surround' " quoting/parenthesizing made simple
Plugin 'tpope/vim-unimpaired' " pairs of handy bracket mappings

call vundle#end()

" Better % command
runtime macros/matchit.vim

" Recognize file types / set indent mode
filetype plugin indent on
filetype plugin on
" Switch between buffers without saving
set hidden
" Share OS clipboard
set clipboard=unnamed
" make backspace work like most other apps
set backspace=indent,eol,start
" Allow mouse usage in terminal vim
set mouse=a
" Always show status line
set laststatus=2
" Indention
set autoindent
" make auto completion on command line work like in shell
set wildmode=longest,list
" Scroll cursor offset
set scrolloff=3
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

" highlight search results
set hlsearch
" ignore case in searches ... (\c\C override)
set ignorecase
" ... unless there are caps in the search
set smartcase
set incsearch

" Store temporary files in a central spot
set undodir=~/.vim/.vim-tmp//,/var/tmp//,/tmp//,.
" Do not create swap files, we're using git after all
set nobackup
set nowritebackup
set noswapfile
" Enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif
" Ignore certain things
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

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
set t_Co=256
"if match($TERM, "screen")!=-1
  "set term=xterm
"endif
colorscheme distinguished

"set relativenumber
if exists('+relativenumber')
  set relativenumber
end
" Show Line numbers
set number
" Visual line marking 80 characters (vim 7.3)
if v:version >= 703
  set colorcolumn=80
endif
" Highlight active line
set cursorline
" Invisible characters
set list
autocmd BufEnter * set list listchars=tab:▸\ ,trail:≈,eol:¬
highlight SpecialKey ctermfg=88 guifg=88

" Syntastic coderwall.com/p/zneomg
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'
" Don't lint on :wq
let g:syntastic_check_on_wq = 0

" Add npm-exec-eslint script to PATH
let $PATH .= ':' . $HOME . '/.vim/scripts'
" Use eslint
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'npm-exec-eslint'

autocmd FileType javascript setlocal omnifunc=tern#Complete


" -----------------------------------------------------------------------------
" Tabs vs. Spaces
" -----------------------------------------------------------------------------
" Spaces instead of tabs
set expandtab
" 2 spaces for each tab
set tabstop=2
" 2 spaces for indention
set shiftwidth=2

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Use The Silver Searcher if available
if executable('ag')
  " Use ag in ack.vim
  "
  let g:ackprg = 'ag --nogroup --nocolor --column'
  " Use ag in CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " Skip caching since ag is so fast
  let g:ctrlp_use_caching = 0
endif

" -----------------------------------------------------------------------------
" snipmate
" -----------------------------------------------------------------------------
" Configure snipmate dir
let g:snippets_dir="~/.vim/snippets"
" Remap key
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" -----------------------------------------------------------------------------
" Key bindings
" -----------------------------------------------------------------------------

" Leader key
let mapleader = ","

" Saves time; maps the spacebar to colon
nmap <space> :

" Keep curson in place when using J to join two lines
nnoremap J mzJ`z

" change rows not lines which is useful on wrapped lines
nnoremap j gj
nnoremap k gk

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" NERDCommenter
map <Leader>c <plug>NERDCommenterToggle
" unmap all other bindings
let g:NERDCreateDefaultMappings=0

" Edit user .vimrc
nmap <Leader>v :e ~/.vimrc<CR>
" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source ~/.vimrc
endif

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" In addition to <esc>, jj will exit to normal mode.
inoremap jj <ESC>
"
" vim-unimpared vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Switch between buffers
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

" Navigate between windows
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" https://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
" split window
nmap <leader>swh :topleft  vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk :topleft  new<CR>
nmap <leader>swj :botright new<CR>
" split buffer
nmap <leader>sh :leftabove  vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove  new<CR>
nmap <leader>sj :rightbelow new<CR>

" Clear search results when hitting tab
nnoremap <silent> <Tab> :nohlsearch<Bar>:echo<CR>

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
