# zplugin config
# https://github.com/zdharma/zplugin/blob/ec79623684944b813cbd8fa3faee484c486d1f68/README.md#customizing-paths--other

# typeset -TUx PATH path : # T: define, U: unique, x: auto export, ':' is the same as default value, can be remove here.
typeset -Ux path
path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /run/current-system/sw/bin
    /snap/bin
    /usr/local/cuda/bin
    /usr/local/sbin
    /usr/local/bin
    /usr/sbin
    /usr/bin
    /sbin
    /bin)

VISUAL=vi
MANPAGER=less

# Default derminal editor, EDITOR is a fallback option.
if (( $+commands[nvim] )); then
    VISUAL='nvim'
    MANPAGER='nvim +Man!'
elif (( $+commands[vim] )); then
    VISUAL='vim'
fi

export VISUAL
export EDITOR="$VISUAL"
export MANPAGER
export OS_NAME=`uname`