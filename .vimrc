""""""""""""""""""""""""""""""""""""""""""""""""""
" Sebastian Cieslak Vimrc configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set encoding=utf8

"""" START Vundle Configuration

" Disable file type for vundle
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'              "plugin manager

" Utility
Plugin 'scrooloose/nerdtree'            "tree explorer
Plugin 'majutsushi/tagbar'              "displays tags in window
Plugin 'ervandew/supertab'              "allows you to use <Tab> for insert completion needs
Plugin 'BufOnly.vim'                    "delete all the buffers expect the current one
Plugin 'wesQ3/vim-windowswap'           "swap your windows without ruining your layout
Plugin 'SirVer/ultisnips'               "the ultimate snippet solution
Plugin 'ctrlpvim/ctrlp.vim'             "full path fuzzy file, buffer, mru, tag finder
Plugin 'jeetsukumaran/vim-buffergator'  "list, select, and switch between buffers

" Generic Programming Support
Plugin 'honza/vim-snippets'             "default snippets
Plugin 'Townk/vim-autoclose'            "enable an auto-close chars feature eg. (

" Verilog and SystemVerilog Syntax and Omni-completion
Plugin 'vhda/verilog_systemverilog.vim'

" Git Support
Plugin 'tpope/vim-fugitive'
Plugin 'kablamo/vim-git-log'
Plugin 'gregsexton/gitv'

" Theme / Interface
Plugin 'AnsiEsc.vim'                    "ansi escape sequences concealed, but highlighted as specified
Plugin 'vim-airline/vim-airline'        "lean and mean status/tabline
Plugin 'vim-airline/vim-airline-themes' "extension for vim-airline
Plugin 'tomasr/molokai'                 "scheme
Plugin 'morhetz/gruvbox'                "scheme

call vundle#end()            " required
filetype plugin indent on    " required
"""" END Vundle Configuration

""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration Section
""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax coloring
syntax on

" Disable line wrapping
set nowrap

" Set leader key
let mapleader = ","

" Enable backspace in insert mode
set backspace=2

" Show linenumbers
set number
set ruler

" Set Proper Tabs
set tabstop=2
set shiftwidth=2
set smarttab  "uses shiftwidth instead of tabstop at start of lines
set expandtab "replaces a <tab> with spaces --more portable

" Always display the status line
set laststatus=2

" Enable highlighting of the current line
set cursorline

" Theme and Styling
set t_Co=256
set background=dark
let g:solarized_visibility='low'
let g:solarized_contrast='high'
colorscheme solarized
if (has("termguicolors"))
  set termguicolors
endif

" Case sensitivity and highlighting
set ignorecase
set smartcase
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>
set hlsearch

" Set whitespaces and font
set listchars=eol:¬,trail:~,extends:>,precedes:<,tab:»\ ,space:·
if has('gui_running')
  set guioptions-=T  " no toolbar
  set lines=60 columns=108 linespace=0
  set guifont=Monospace\ 10
  set list
endif

" Vim-Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_theme='solarized'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'

" Vim-UltiSnips Configuration
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical" " If you want :UltiSnipsEdit to split your window.

" Verilog SystemVerilog Tagbar Configuration
let g:tagbar_type_verilog_systemverilog= {
    \ 'ctagstype' : 'verilog_systemverilog',
    \ 'kinds'     : [
        \'c:classes',
        \'t:tasks',
        \'f:functions',
        \'m:modules',
        \'i:interfaces',
        \'v:variables',
        \'d:defines',
        \'e:typedefs',
        \'a:parameters'
  \]
\}

function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

autocmd BufWritePre * call DeleteTrailingWhite()

" Remove trailing whitespaces but save cursor position
function! DeleteTrailingWhite()
  let _save_pos=getpos(".")
  let _s=@/
  %s/\s\+$//e
  nohl
  unlet _s
  call setpos('.', _save_pos)
  unlet _save_pos
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>

" Omnicomplete Better Nav
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>

"Shortcuts
nnoremap <Leader>O :CtrlP<CR>
nnoremap <Leader>w :w<CR>

"Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" Move between buffers with ctrl + arrows
nnoremap <c-left>  :bp<CR>
nnoremap <c-right> :bn<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk
