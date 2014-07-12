#!/usr/bin/env zsh

function percol_select_history()
{
    local tac='tac'
    if ! hash tac > /dev/null; then
        tac='tail -r'
    fi
    BUFFER=$(history | sed 's/^[ ]*[0-9]\+[ ]*//' | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N percol_select_history
bindkey '^r' percol_select_history
