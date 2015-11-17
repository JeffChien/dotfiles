#!/usr/bin/env zsh

function percol_select_history()
{
    local tac='tac'
    if ! hash tac > /dev/null; then
        tac='tail -r'
    fi
    history | sed 's/^[ ]*[0-9*]\+[ ]*//' | eval $tac | percol --query "$LBUFFER" > /tmp/choice.tmp
    #BUFFER=$(history | sed 's/^[ ]*[0-9*]\+[ ]*//' | eval $tac | percol --query "$LBUFFER")
    BUFFER=$(cat /tmp/choice.tmp)
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N percol_select_history
bindkey '^r' percol_select_history
