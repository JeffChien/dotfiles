#!/usr/bin/env bash

[ -d "$HOME/.shellconf/envs.d" ] && {
    pushd "$HOME/.shellconf/envs.d" >/dev/null
        for conf in $(ls .); do
            source "$conf"
        done
    popd >/dev/null
}

[ -d "$HOME/.shellconf/profiles.d" ] && {
    pushd "$HOME/.shellconf/profiles.d" >/dev/null
        for conf in $(ls .); do
            source "$conf"
        done
    popd >/dev/null
}
# vim: fdm=marker
