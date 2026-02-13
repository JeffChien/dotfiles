# typeset -TUx PATH path : # T: define, U: unique, x: auto export, ':' is the same as default value, can be remove here.
typeset -Ux path

path=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/.npm-packages/bin"
    "$HOME/.krew/bin"
    "$HOME/.asdf/shims"
    "$HOME/.cache/.bun/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/run/current-system/sw/bin"
    "/usr/local/sbin"
    "/usr/local/bin"
    "/usr/sbin"
    "/usr/bin"
    "/sbin"
    "/bin"
)

export EDITOR="nvim"

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}