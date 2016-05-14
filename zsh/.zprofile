# fix compdef not found
# http://qiita.com/ikeisuke/items/3a010e7922795eb79d76
autoload -Uz compinit
compinit

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
