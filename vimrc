scriptencoding utf-8
" -----------------------------------------------------------------------------
" Basics
" -----------------------------------------------------------------------------
" Be IMproved
if &compatible | set nocompatible | endif

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
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
" Plug 'Lokaltog/vim-distinguished' " Color scheme
Plug 'chriskempson/base16-vim'
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
set scrolloff=5
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
set dir=~/.vim/.vim-tmp/swap//,/var/tmp//,/tmp//,.
set undodir=~/.vim/.vim-tmp/undo//,/var/tmp//,/tmp//,.
" Enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif
" Ignore certain things
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

"get rid of the default mode indicator because we use airline
set noshowmode

" Leader key
let mapleader = ","

" let g:airline_extensions = []
" enable airline's smarter tab line extension
"
let g:airline#extensions#tabline#enabled = 1
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

"shorten pause when leaving insert mode
set ttimeoutlen=50
" Open help pages in new tab
cabbrev help tab help

" -----------------------------------------------------------------------------
" Styling
" -----------------------------------------------------------------------------

" Syntax highlighting
syntax on

" enable 24 bit color support
if has("termguicolors")
  set termguicolors
endif

" Color Scheme
" set t_Co=256
set background=dark
" if !empty(glob("~/.vim/plugged/vim-distinguished/colors/distinguished.vim"))
  " colorscheme distinguished
" endif
if !empty(glob("~/.vim/plugged/base16-vim/colors/base16-chalk.vim"))
  let base16colorspace = 256
  colorscheme base16-chalk
endif

" activate jsx syntax highlighting for .js files
let g:jsx_ext_required = 0

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
highlight SpecialKey ctermfg=88 guifg=#870000

" c++11 lambda
let c_no_curly_error = 1

" Syntastic coderwall.com/p/zneomg
let g:syntastic_error_symbol = '✗✗'
let g:syntastic_style_error_symbol = '✠✠'
let g:syntastic_warning_symbol = '∆∆'
let g:syntastic_style_warning_symbol = '≈≈'
" Don't lint on :wq
let g:syntastic_check_on_wq = 0

" Use eslint
let g:syntastic_javascript_checkers = ['eslint']
" Use npm-exec-eslint
let $PATH .= ':' . $HOME . '/.vim/scripts'
let g:syntastic_javascript_eslint_exec = 'npm-exec-eslint'
" prefer eslint_d if available
if executable('eslint_d')
  let g:syntastic_javascript_eslint_exec = 'eslint_d'
endif

" Disable YouCompleteMe preview window
set completeopt-=preview


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
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

" Use The Silver Searcher if available
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

" -----------------------------------------------------------------------------
" Key bindings
" -----------------------------------------------------------------------------

" Saves time; maps the spacebar to colon
nmap <space> :

" Toggle paste mode
set pastetoggle=<leader>p

" Keep curson in place when using J to join two lines
nnoremap J mzJ`z

" change rows not lines which is useful on wrapped lines
nnoremap j gj
nnoremap k gk

" In addition to <esc>, jj will exit to normal mode.
inoremap jj <ESC>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-commentary
map <Leader>c gcc<ESC>

" Edit user .vimrc
nmap <Leader>v :e $MYVIMRC<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost vimrc source $MYVIMRC | AirlineRefresh | echo "~/.vimrc reloaded!"
endif

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" vim-unimpared vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Clear search results when hitting tab
nnoremap <silent> <Tab> :nohlsearch<Bar>:echo<CR>

" Show current file as HTML
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>

" -----------------------------------------------------------------------------
" File type specifics
" -----------------------------------------------------------------------------
" Execute current file with node.js
autocmd BufEnter *.js nmap <Leader><Leader> :w<CR>:!node %:p<CR>
" Autofix current file with eslint
autocmd BufEnter *.js nmap <Leader>e :w<CR>:silent exec "!npm-exec-eslint % --fix"<CR>:redraw!<CR>:e<CR>:w<CR>
" Compile c++14 files and execute
autocmd BufEnter *.cpp nmap <Leader><Leader> :w<CR>:! c++ -std=c++14 -O2 -Wall -pedantic -pthread %:p -o main && ./main <CR>
autocmd BufEnter *.c nmap <Leader><Leader> :w<CR>:! make %< && ./%< <CR>

" Recognise file by extension
autocmd BufEnter *.hbt set filetype=mustache
