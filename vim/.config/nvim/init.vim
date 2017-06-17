set runtimepath=~/.vim,$VIMRUNTIME
source ~/.vimrc

let g:python_host_prog=!empty($PYTHON2_BIN) ? $PYTHON2_BIN : '/usr/local/bin/python2'
let g:python3_host_prog=!empty($PYTHON3_BIN) ? $PYTHON3_BIN : '/usr/local/bin/python3'

"let g:python_host_prog='/usr/local/bin/python2'
"let g:python_host_prog='/Users/jchien/.zplug/repos/pyenv/pyenv/shims/python'
"let g:python3_host_prog='/usr/local/bin/python3'
"let g:python_host_prog='/usr/local/bin/python2'
"let g:python3_host_prog='/Users/jchien/.zplug/repos/pyenv/pyenv/versions/3.6.1/bin/python'
let g:UltiSnipsUsePythonVersion=2
"let g:loaded_python3_provider = 1

call plug#begin('~/.local/share/nvim/plugged')
if has('nvim')
	Plug 'kassio/neoterm'
endif

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' " binary is installed by zplug
Plug 'junegunn/vim-easy-align'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'Lokaltog/vim-easymotion'
Plug 'benmills/vimux'
"Plug 'kien/ctrlp.vim'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'fatih/vim-go', { 'for': 'go' , 'do': ':GoInstallBinaries' }
Plug 'corntrace/bufexplorer'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips', {'on': [] } | Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', {'on': [], 'do': './install.py --clang-completer --gocode-completer --tern-completer' }
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'tmhedberg/matchit', { 'on': [] }
Plug 'jiangmiao/auto-pairs'
Plug 'alfredodeza/pytest.vim', { 'for': 'python' }
Plug 'w0rp/ale', { 'for': 'python' }
Plug 'google/yapf', { 'for': 'python', 'rtp': 'plugins' }
Plug 'zhaocai/GoldenView.Vim'
Plug 'wesQ3/vim-windowswap'
Plug 'chrisbra/csv.vim'
" syntax
Plug 'digitaltoad/vim-jade'
Plug 'wavded/vim-stylus'
Plug 'ekalinin/Dockerfile.vim'
Plug 'groenewege/vim-less'
Plug 'juvenn/mustache.vim'
Plug 'leafgarland/typescript-vim'
Plug 'rodjek/vim-puppet'
Plug 'kchmck/vim-coffee-script'
Plug 'sophacles/vim-bundle-mako'
Plug 'bfredl/nvim-ipy'
Plug 'airblade/vim-gitgutter'
Plug 'dhruvasagar/vim-table-mode'

" Plug 'godlygeek/tabular'
" Plug 'Shougo/vimproc.vim'
" Plug 'Shougo/neocomplcache'
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/vimfiler'
" Plug 'Shougo/vimshell'
" 
" Plug 'vim-scripts/FuzzyFinder'
" Plug 'vim-scripts/L9'
" Plug 'vim-scripts/cscope.vim'
" Plug 'vim-scripts/taglist.vim'
" Plug 'vim-scripts/YankRing.vim'
" 
" Plug 'tomtom/tlib_vim'
" Plug 'tomtom/tselectfiles_vim'
" Plug 'Rip-Rip/clang_complete'
" Plug 'mileszs/ack.vim'
" Plug 'Lokaltog/powerline'
" Plug 'sayuan/vimwiki'
" Plug 'gmarik/vundle'
" Plug 'kshenoy/vim-signature'
" Plug 'sjbach/lusty'
" Plug 'klen/python-mode'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'AndrewRadev/switch.vim'
" Plug 'lambdalisue/shareboard.vim'
" Plug 'gkz/vim-ls'
" Plug 'spolu/dwm.vim'
" Plug 'scrooloose/syntastic'
" Plug 'Raimondi/delimitMate'
" Plug 'mattn/emmet-vim'
" Plug 'alexanderak/supertab'
" Plug 'ervandew/eclim'
" Plug 'JeffChien/vim-markdown'
" Plug 'nsf/gocode'
" Plug 'marijnh/tern_for_vim'
" Plug 'davidhalter/jedi-vim'
" Plug 'jeetsukumaran/vim-buffergator'
" Plug 'sjl/gundo.vim/'
" Plug 'rking/ag.vim'
" Plug 'Quramy/tsuquyomi'
" Plug 'osyo-manga/vim-over'
" Plug 'nathanaelkane/vim-indent-guides'
" Plug 'Yggdroot/indentLine'
call plug#end()

augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe', 'matchit')
                     \| autocmd! load_us_ycm
augroup END
