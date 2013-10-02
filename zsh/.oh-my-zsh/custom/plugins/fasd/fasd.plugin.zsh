#!/usr/bin/zsh

if [ $(command -v 'fasd' 2>/dev/null) ]; then
    eval "$(fasd --init auto)"
fi

bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (fils and directories)
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
