export ZDOTDIR=${ZDOTDIR:=-$HOME/.config/zsh}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

export VISUAL="nvim"
export EDITOR="$VISUAL"
export MANPAGER='nvim +Man!'
export OS_NAME=`uname`


path=(
  "/usr/local/sbin"
  "/usr/local/bin"
  "/usr/sbin"
  "/usr/bin"
  "/sbin"
  "/bin"
)


for mod in "$ZDOTDIR/mods/"*(/); do
    modfile="$mod/zshenv"
    if [[ -s "$modfile" ]]; then
        source "$modfile"
    fi
done

# 3. Ensure uniqueness (removes duplicates) and export
typeset -U path

# workaround, due to system zsh config may override or reorder items in path.
# create this variable to restore my preference path in zshrc
backup_path=($path)