"set runtimepath=$HOME/.vim,$VIM/ultisnips,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$VIM/ultisnips/after,$HOME/.vim/after

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'nyarly/gundo'
Bundle 'kien/ctrlp.vim'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-fugitive'

Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'IndentAnything'
Bundle 'gnupg'
"Bundle 'SimpleFold'
Bundle 'timcharper/textile.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-surround'
Bundle 'seebi/semweb.vim'
Bundle "pangloss/vim-javascript"
Bundle "vim-scripts/rfc-syntax"
Bundle "closetag.vim"

"fonts weren't immediately working..
"Bundle 'bling/vim-airline'

runtime! ftdetect/UltiSnips.vim
filetype plugin indent on
set laststatus=2
set incsearch
set expandtab
set modeline
set sw=2
set pastetoggle=[24~
set gdefault
set shortmess+=I
set cursorline
set scrolloff=4

let javaScript_fold = 1
let ruby_minlines = 150
let ruby_operators = 'yes'

"let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
"let g:Powerline_loaded='not really but I want it disabled'
set encoding=utf-8

let g:GPGPreferArmor = 1
let g:GPGPreferSign = 1
let g:GPGUsePipes = 1
let g:GPGDefaultRecipients = [ 'judson@lrdesign.com' ]

if &term =~ '^screen'
  set t_ts=]2;
  set t_fs=
endif

set title

set wildmenu
set wildmode=list:longest

set undodir="~/.vim/undo"
set undofile

let s:hour = str2nr(strftime("%H"))
if s:hour > 6 && s:hour < 21
  set background=light
else
  set background=dark
endif

colorscheme solarized

let g:snips_author = "Judson Lester"
let g:my_email_addr = "nyarly@gmail.com"
let g:UltiSnipsListSnippets = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="horizontal"

let g:delimitMate_offByDefault=1 "Just can't stand it anymore
"let g:delimitMate_expand_cr=1
"let g:delimitMate_expand_space=1
"
let g:ctrlp_custom_ignore = { 'dir': '/pkg$\|/gh-pages$\|/yardoc$\|/doc/coverage$\|/corundum/docs$\|/node_modules$\|/bower_components$' }
let g:ctrlp_switch_buffer = 'ETVH'
let g:ctrlp_root_markers = ['.ctrlp-root', '.envrc']
let g:ctrlp_open_new_file = 'v'
let g:ctrlp_open_multiple_files = '5ij'
let g:ctrlp_arg_map = 1
let g:ctrlp_extensions = ['tag', 'quickfix']

set tags+=.git/bundle-tags

if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source " .path
  endfor
endif
