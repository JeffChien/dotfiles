"Author: JeffChien
"Last modified date: 2012/9/28
"Version: 1.1
"
"_vimrc in windows, .vimrc in unix based system.



if has("win32")
    let $VIMFILES = $VIM . '/vimfiles'
else
    let $VIMFILES = $HOME . '/.vim'
endif

let $MYCONFIG = $VIMFILES . '/configurations/general.vim'

source $MYCONFIG
