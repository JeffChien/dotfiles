#!/usr/bin/env bash

[ -d "$HOME/.shellconf/rc.d" ] && {
    pushd "$HOME/.shellconf/rc.d" >/dev/null
        for conf in $(ls .); do
            source "$conf"
        done
    popd >/dev/null
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/credentials/homebrew ] && source ~/credentials/homebrew
# vim: fdm=marker
