" Basics {{{
set nocompatible

set hidden " Switch between buffers without saving
set clipboard^=unnamedplus,unnamed " Share OS/XServer clipboard
set backspace=indent,eol,start " make backspace work like most other apps
set mouse=a " Allow mouse usage in terminal vim
set ttymouse=sgr " Allow mouse usage in tmux and ssh sessions
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
augroup CursorPosition
  autocmd!
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

set hlsearch " highlight search results
set ignorecase " ignore case in searches ... (\c\C override)
set smartcase " ... unless there are caps in the search
set incsearch " show where the pattern, as it was typed so far, matches

set lazyredraw " redraw only when we need to

" Store temporary files in a central spot
set directory=~/.vim/.vim-tmp/swap//,/var/tmp//,/tmp//,.
set undodir=~/.vim/.vim-tmp/undo//,/var/tmp//,/tmp//,.

set undofile " Enable vim to remember undo chains between sessions

" Ignore certain things
set wildignore+=.git,*/node_modules/*,*/deps/build/*,*/stack/*,*/deps/go/*,*/deps/node/*,*/_site/*

set noshowmode "get rid of the default mode indicator because we use airline

let g:mapleader = ',' " Leader key

set ttimeoutlen=50 "shorten pause when leaving insert mode

" Open help pages in new tab
cabbrev help tab help
" }}}
" Plugins {{{
" Install vim-plug if not available
augroup InstallPlug
  autocmd!
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
      endif
augroup END

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline' " lean & mean status/tabline for vim that's light as air
Plug 'jacoborus/tender' " colorscheme
Plug 'airblade/vim-gitgutter' " shows a git diff in the gutter (sign column)
Plug 'SirVer/ultisnips' " implements some of TextMate's snippets features
Plug 'sjl/gundo.vim' " undo tree
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder.
if executable('cmake')
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer',
                               \ 'for': [ 'cpp', 'c' ] }
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
endif
Plug 'mileszs/ack.vim' " Vim plugin for the Perl module / CLI script 'ack'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat' " enable repeating supported plugin maps with .
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple
Plug 'tpope/vim-unimpaired' " pairs of handy bracket mappings
Plug 'wellle/targets.vim'
Plug 'ap/vim-css-color'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'

call plug#end()

" Better % command
runtime macros/matchit.vim
" }}}
" UI and colors {{{
if (has('termguicolors'))
 set termguicolors
endif

" Color Scheme
set background=dark
if !empty(glob('~/.vim/plugged/tender'))
  colorscheme tender
  let g:airline_theme = 'tender'
  hi SignColumn guifg=#282828 ctermfg=235 guibg=#282828 ctermbg=235 gui=NONE cterm=NONE
  hi VertSplit guifg=#808080 guibg=#282828
  hi Visual term=reverse cterm=reverse
  hi Search guifg=#eeeeee ctermfg=255 guibg=#f43753 ctermbg=203 gui=NONE cterm=NONE

  highlight Comment cterm=italic " Italic comments.
  highlight Comment gui=italic " Italic comments in gui.
  highlight Todo cterm=italic " Italic comments.
  highlight Todo gui=italic " Italic comments in gui.
  " highlight xmlAttrib cterm=italic
  " highlight xmlAttrib gui=italic
endif

if &term =~# '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" activate jsx syntax highlighting for .js files
let g:jsx_ext_required = 0

" Highlight active line
" set cursorline

" Show Line numbers
set number

" Visual line marking 80 characters
set colorcolumn=80

" Invisible characters
augroup InvisibleCharacters
  autocmd!
  set list
  autocmd BufEnter * set list listchars=tab:▸\ ,trail:≈,eol:¬
augroup END

highlight SpecialKey ctermfg=88 guifg=#870000

" c++11 syntax
let g:c_no_curly_error = 1

" }}}
" tabs vs. spaces, line breaks {{{
set expandtab " Spaces instead of tabs
set tabstop=2 " 2 spaces for each tab
set shiftwidth=2 " 2 spaces for indention

if has('linebreak')
  set breakindent
endif

" }}}
" Plugin configuration and mappings {{{

let g:ycm_confirm_extra_conf = 0
" YouCompleteMe
let g:ycm_error_symbol = '✗✗'
let g:ycm_warning_symbol = '∆∆'

" ale
let g:ale_linters = {
\  'javascript': ['eslint', 'flow'],
\  'tex': ['chktex'],
\  'c': [],
\  'cpp': [],
\  'python': ['flake8'],
\  'java': [],
\}
let g:ale_fixers = {
\  'javascript': ['prettier'],
\  'json': ['prettier'],
\  'cpp': ['clang-format'],
\  'python': ['autopep8'],
\}
let g:ale_javascript_prettier_options = '--trailing-comma es5 --single-quote'
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: llvm, IndentWidth: 2, ColumnLimit: 100, AllowShortFunctionsOnASingleLine: None, KeepEmptyLinesAtTheStartOfBlocks: false}"'
nnoremap gp :ALEFix<CR>

let g:ale_sign_error = '✗✗'
let g:ale_sign_warning = '∆∆'
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']

" Airline

let g:airline_extensions = ['tabline', 'ycm', 'ale']

let g:airline#extensions#ycm#enabled = 1
let g:airline#extensions#ycm#error_symbol = '⨉ '
let g:airline#extensions#ycm#warning_symbol = '⚠ '

let g:airline#extensions#ale = 1
let g:airline#extensions#ale#error_symbol = '⨉ '
let g:airline#extensions#ale#warning_symbol = '⚠ '

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_buffers = 1
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

" clang-rename
let g:clang_rename_path = '/usr/local/opt/llvm/bin/clang-rename'
noremap <leader>ref :pyf ~/.vim/scripts/clang-rename.py<cr>


" CtrlP
let g:ctrlp_working_path_mode = 'r' " Use the nearest .git directory as the cwd

" Use The Silver Searcher for :ack if available
if executable('ag')
  " Use ag in ack.vim
  let g:ackprg = 'ag --nogroup --nocolor --column'
  " Use ag in CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g "" --ignore .git'
  " Skip caching since ag is so fast
  let g:ctrlp_use_caching = 0
endif


" UltiSnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/snips']
let g:UltiSnipsExpandTrigger='<c-j>'

" vim-unimpaired vimcasts.org/episodes/bubbling-text/
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" comment line
map <Leader>c gcc<ESC>

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" vim-markdown-preview
let g:vim_markdown_preview_hotkey='<C-m>'

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 2

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
inoremap jk <ESC>

" highlight last inserted text
nnoremap gV `[v`]

" Get off my lawn
noremap <Left> <nop>
noremap <Right> <nop>
noremap <Up> <nop>
noremap <Down> <nop>


" Edit user .vimrc
nmap <Leader>v :e $MYVIMRC<CR>

" Source the vimrc file after saving it
augroup ReloadVimrc
  autocmd!
  autocmd bufwritepost *vimrc source $MYVIMRC |
        \ AirlineRefresh |
        \ redraw |
        \ echo '~/.vimrc reloaded!'
augroup END

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Clear search results and quicklist when hitting control-space
inoremap <C-@> <c-x><c-o>
nnoremap <silent> <C-@> :nohlsearch<Bar>:echo<CR>:ccl<CR>

" Show current file as HTML
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>

augroup qf
    autocmd!
    " automatically close corresponding loclist when quitting a window
    autocmd QuitPre * if &filetype != 'qf' | silent! lclose | endif
augroup END

" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" }}}
" File type specific autocmds {{{

let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {'callback' : 0}
nnoremap <F5> :call <SID>compile_and_run()<CR>
nnoremap <F6> :AsyncStop<CR>:call asyncrun#quickfix_toggle(10, 0)<CR>

augroup ASYNCRUN
    autocmd!
    " Automatically open the quickfix window
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(10, 1)
augroup END

function! s:compile_and_run()
  exec 'w'
  if &filetype ==# 'c'
    call MakeAndRun()
  elseif &filetype ==# 'cpp'
    call MakeAndRun()
  elseif &filetype ==# 'javascript.jsx'
    call RunWithNode()
  elseif &filetype ==# 'tex'
    exec 'AsyncRun latexmk % -pdf'
  elseif &filetype ==# 'python'
    exec 'AsyncRun python3 %'
  endif
endfunction

function! RunWithNode()
  let l:prefix = join(split(system('npm prefix'), '\n'), '')
  let l:pkgpath = l:prefix.'/package.json'
  " if there is a package.json file
  if !empty(glob(l:pkgpath))
    let l:pkg = json_decode(join(readfile(l:pkgpath), "\n"))
    if (index(keys(l:pkg), 'main') >= 0) " if there is a key 'main'
      exec 'AsyncRun time node ' . l:prefix . '/' . l:pkg.main
      return
    endif
  endif
  " else fallback to currently opened file
  exec 'AsyncRun time node %<'
endfunction

function! MakeAndRun()
  if !empty(glob('Makefile')) " if a Makefile exists use it
    exec 'AsyncRun make && time make run'
  else
    exec 'AsyncRun make %< && time ./%<'
  endif
endfunction

" File type specific autocommands
augroup Filetypes
    autocmd!
    autocmd BufEnter *.hbt set filetype=html.handlebars syntax=mustache
    " in makefiles, don't expand tabs to spaces
    autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0
    " vim-commentary
    autocmd FileType c set commentstring=//\ %s
    autocmd FileType cpp set commentstring=//\ %s
    " turn on concealing for markdonw and latex
    autocmd FileType markdown set conceallevel=2
    autocmd FileType tex set conceallevel=2
augroup END
" }}}
" vim:foldmethod=marker:foldlevel=0
