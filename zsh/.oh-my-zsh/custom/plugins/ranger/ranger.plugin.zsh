#!/usr/bin/env zsh

ranger-cd () {
    tempfile='/tmp/choosedir'
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

bindkey -s "^o" 'ranger-cd^M'
