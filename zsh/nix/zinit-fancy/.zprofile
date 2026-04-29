
for mod in "$ZDOTDIR/mods/"*(/); do
    modfile="$mod/zprofile"
    if [[ -s "$modfile" ]]; then
        source "$modfile"
    fi
done
