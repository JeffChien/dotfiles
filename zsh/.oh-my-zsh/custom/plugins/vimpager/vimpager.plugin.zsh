#!/usr/bin/zsh

vman(){
    /usr/bin/man $* | col -b | vim -R -c 'set ft=man nomod nolist' -c 'nmap q :q<CR>' -;
}

alias man='vman'
