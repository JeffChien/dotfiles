for mod in "$ZDOTDIR/mods/"*(/); do
    modfile="$mod/zlogout"
    if [[ -s "$modfile" ]]; then
        source "$modfile"
    fi
done