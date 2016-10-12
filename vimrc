" Basics {{{
if &compatible | set nocompatible | endif " Be IMproved

filetype plugin indent on " Recognize file types / set indent mode

set hidden " Switch between buffers without saving
set clipboard^=unnamedplus,unnamed " Share OS/XServer clipboard
set backspace=indent,eol,start " make backspace work like most other apps
set mouse=a " Allow mouse usage in terminal vim
set laststatus=2 " Always show status line
set autoindent " Copy indent from current line when starting a new line
set wildmode=longest,list " make auto completion on command line work like in shell

" Tell vim to remember certain things when we exit
" "  '10  :  marks will be remembered for up to 10 previously edited files
" "  "100 :  will save up to 100 lines for each register
" "  :50  :  up to 50 lines of command-line history will be remembered
" "  %    :  saves and restores the buffer list
" "  n... :  where to save the viminfo files
set viminfo='10,\"100,:50,%,n~/.viminfo

set scrolloff=5 " Scroll cursor offset

" remember cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set hlsearch " highlight search results
set ignorecase " ignore case in searches ... (\c\C override)
set smartcase " ... unless there are caps in the search
set incsearch " show where the pattern, as it was typed so far, matches

set lazyredraw " redraw only when we need to

" Store temporary files in a central spot
set dir=~/.vim/.vim-tmp/swap//,/var/tmp//,/tmp//,.
set undodir=~/.vim/.vim-tmp/undo//,/var/tmp//,/tmp//,.

set undofile " Enable vim to remember undo chains between sessions

" Ignore certain things
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

set noshowmode "get rid of the default mode indicator because we use airline


let mapleader = "," " Leader key

set ttimeoutlen=50 "shorten pause when leaving insert mode

" Open help pages in new tab
cabbrev help tab help
" }}}
" Plugins {{{
" Install vim-plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter' " shows a git diff in the gutter (sign column)
Plug 'SirVer/ultisnips' " implements some of TextMate's snippets features
Plug 'ervandew/supertab'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'sjl/gundo.vim'
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
" Plug 'Lokaltog/vim-distinguished' " Color scheme
Plug 'chriskempson/base16-vim'
Plug 'jacoborus/tender'
Plug 'pangloss/vim-javascript', { 'branch': 'develop' }
Plug 'mxw/vim-jsx' " React JSX syntax highlighting and indenting
Plug 'b4winckler/vim-objc' " Objective-C config for Vim
Plug 'mustache/vim-mustache-handlebars'
Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/syntastic' " Syntax checking hacks for vim
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with .
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
Plug 'wellle/targets.vim'
Plug 'ap/vim-css-color'
Plug 'wavded/vim-stylus'

call plug#end()

" Better % command
runtime macros/matchit.vim
" }}}
" UI and colors {{{
syntax on " Syntax highlighting

" Color Scheme
" set t_Co=256
set background=dark
if !empty(glob("~/.vim/plugged/base16-vim/colors/base16-chalk.vim"))
  let base16colorspace = 256
  colorscheme base16-chalk
endif

" activate jsx syntax highlighting for .js files
let g:jsx_ext_required = 0

" relativenumber and cursorline slow?
" if exists('+relativenumber')
  " set relativenumber
" end

" Highlight active line
set cursorline

" Show Line numbers
set number

" Visual line marking 80 characters
set colorcolumn=80

" Invisible characters
set list
autocmd BufEnter * set list listchars=tab:▸\ ,trail:≈,eol:¬
highlight SpecialKey ctermfg=88 guifg=#870000

" c++11 lambda
let c_no_curly_error = 1

" }}}
" tabs vs. spaces, line breaks {{{
set expandtab " Spaces instead of tabs
set tabstop=2 " 2 spaces for each tab
set shiftwidth=2 " 2 spaces for indention

if has("linebreak")
  set breakindent
endif

" in makefiles, don't expand tabs to spaces
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" }}}
" Plugin configuration and mappings {{{
" Airline
let g:airline#extensions#tabline#enabled = 1 " enable airline's smarter tab line extension
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>b <Plug>AirlineSelectPrevTab
nmap <leader>f <Plug>AirlineSelectNextTab

" Don't show seperators
let g:airline_left_sep=''
let g:airline_right_sep=''


" Syntastic coderwall.com/p/zneomg
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'
let g:syntastic_check_on_wq = 0 " Don't lint on :wq

let g:syntastic_javascript_checkers = ['eslint'] " Use eslint
let $PATH .= ':' . $HOME . '/.vim/scripts' " Use npm-exec-eslint
let g:syntastic_javascript_eslint_exec = 'npm-exec-eslint'
if executable('eslint_d') " prefer eslint_d if available
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
endif


" Use The Silver Searcher for :ack if available
if executable('ag')
  " Use ag in ack.vim
  let g:ackprg = 'ag --nogroup --nocolor --column'
  " Use ag in CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  " Skip caching since ag is so fast
  let g:ctrlp_use_caching = 0
endif


" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snips']


" Supertab chained completions: file path -> omni completion -> keyword completion
let g:SuperTabDefaultCompletionType = 'context'
autocmd FileType *
      \ if &omnifunc != '' |
      \   call SuperTabChain(&omnifunc, "<c-p>") |
      \ endif


" vim-unimpaired vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv


" vim-commentary
autocmd FileType c set commentstring=//\ %s
map <Leader>c gcc<ESC>


" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" }}}
" General mappings {{{

" Saves time; maps the spacebar to colon
nmap <space> :
set pastetoggle=<leader>p " Toggle paste mode
" Keep curson in place when using J to join two lines
nnoremap J mzJ`z

" make Y consistent with D and C commands
nnoremap Y y$

" change rows not lines which is useful on wrapped lines
nnoremap j gj
nnoremap k gk

" In addition to <esc>, jj will exit to normal mode.
inoremap jj <ESC>

" highlight last inserted text
nnoremap gV `[v`]

" Get off my lawn
" noremap <Left> :echoe "Use h"<CR>
" noremap <Right> :echoe "Use l"<CR>
" noremap <Up> :echoe "Use k"<CR>
" noremap <Down> :echoe "Use j"<CR>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>


" Edit user .vimrc
nmap <Leader>v :e $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost vimrc source $MYVIMRC | AirlineRefresh | echo "~/.vimrc reloaded!"
  autocmd bufwritepost .vimrc source $MYVIMRC | AirlineRefresh | echo "~/.vimrc reloaded!"
endif

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Clear search results when hitting tab
nnoremap <silent> <Tab> :nohlsearch<Bar>:echo<CR>

" Show current file as HTML
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>
" }}}
" File type specific autocmds {{{
" Execute current file with node.js
autocmd BufEnter *.js nmap <Leader><Leader> :w<CR>:!clear; node %:p<CR>
" Autofix current file with eslint on <Leader>e
autocmd BufEnter *.js nmap <Leader>e :w<CR>:silent exec "!clear; npm-exec-eslint % --fix"<CR>:redraw!<CR>:e<CR>:w<CR>
" Compile c++14 files and execute
autocmd BufEnter *.cpp nmap <Leader><Leader> :w<CR>:!clear; c++ -std=c++14 -O2 -Wall -pedantic -pthread %:p -o main && ./main <CR>

function MakeAndRun()
  if !empty(glob("Makefile"))
    " nmap <Leader><Leader> :w<CR>:!clear; make && ./bin/%:t:r <CR>
    nmap <Leader><Leader> :w<CR>:!clear; make && make run <CR>
  else
    nmap <Leader><Leader> :w<CR>:!clear; make %< && ./%< <CR>
  endif
endfunction

autocmd BufEnter *.c :call MakeAndRun()

" Recognise file by extension
autocmd BufEnter *.hbt set filetype=mustache
" }}}

" vim:foldmethod=marker:foldlevel=0
