# zplugin config
# https://github.com/zdharma/zplugin/blob/ec79623684944b813cbd8fa3faee484c486d1f68/README.md#customizing-paths--other

# typeset -TUx PATH path : # T: define, U: unique, x: auto export, ':' is the same as default value, can be remove here.
typeset -Ux path
path=(
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/.poetry/bin"
    /snap/bin
    /opt/homebrew/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin)

export OS_NAME=`uname`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Default derminal editor, EDITOR is a fallback option.
if (( $+commands[nvim] )); then
    VISUAL='nvim'
elif (( $+commands[vim] )); then
    VISUAL='vim'
else
    VISUAL='less'
fi

export VISUAL
export EDITOR="$VISUAL"

if (( $+commands[nvim] )); then
    export MANPAGER='nvim +Man!'
else
    export MANPAGER='less'
fi
