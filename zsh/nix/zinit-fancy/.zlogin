for mod in "$ZDOTDIR/mods/"*(/); do
    modfile="$mod/zlogin"
    if [[ -s "$modfile" ]]; then
        source "$modfile"
    fi
done