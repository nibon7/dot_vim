set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/gobgen'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" customize settings
if has("syntax")
  syntax on
endif

set number
set ignorecase
set showmatch
set hlsearch
set incsearch

" You Complete Me
let g:ycm_warning_symbol = '>'
let g:ycm_error_symbol = '>>'
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_python_binary_path = 'python3'
let g:ycm_server_python_interpreter = 'python2.7'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 0
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" clang-format
map <C-I> :pyf /usr/share/clang/clang-format.py<cr>
imap <C-I> <c-o>:pyf /usr/share/clang/clang-format.py<cr>

" NERD Tree
nnoremap <silent> <F5> :NERDTree<CR>

" Enable folding
set foldmethod=indent
set foldlevel=20

" Color scheme
if has("gui_running")
  set background=light
  colorscheme solarized
else
  colorscheme zenburn
endif
