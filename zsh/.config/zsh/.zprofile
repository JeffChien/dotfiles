source "$XDG_CONFIG_HOME/zsh/lib/utils.zsh"

# Default derminal editor, EDITOR is a fallback option.
export VISUAL='emacsclient -n -a "emacs"'
export EDITOR='emacsclient -n -a "emacs"'

# To speed up c compiling time.
export USE_CCACHE=1

# npm pachage
export NPM_PACKAGES="${HOME}/.npm-packages"

typeset -TUx NODE_PATH fnode_path :
fnode_path=(
  "$NPM_PACKAGES/lib/node_modules"
  "${fnode_path[@]}"
)

# zplugin config
# https://github.com/zdharma/zplugin/blob/ec79623684944b813cbd8fa3faee484c486d1f68/README.md#customizing-paths--other


export OS_NAME=`uname`
export LC_ALL=zh_TW.UTF-8
export LANG=zh_TW.UTF-8

exportIfAny 'PYTHON3_HOST_PROG' "$(get1stExistsPath '/usr/local/bin/python3' '/usr/bin/python3')"

# Language Rust
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# typeset -TUx PATH path : # T: define, U: unique, x: auto export, ':' is the same as default value, can be remove here.
typeset -Ux path

path=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/.poetry/bin"
  "$HOME/.SpaceVim/bin"
  "$CARGO_HOME/bin"
  "$NPM_PACKAGES/bin"
  "$(get1stExistsPath "/snap/bin")"
  "$(get1stExistsPath '/Applications/Visual Studio Code.app/Contents/Resources/app/bin')"
  "$(get1stExistsPath "/opt/homebrew/bin")"
  "$(get1stExistsPath "/opt/homebrew/opt/make/libexec/gnubin")"
  "$(get1stExistsPath "$HOME/.krew/bin")"
  "/opt/X11/bin"
  "${path[@]}"
)

# Apache Spark
exportIfAny 'SPARK_HOME' "$(get1stExistsPath "$(brew --prefix)/opt/apache-spark/libexec")"
path=(
  "$(get1stExistsPath "$SPARK_HOME/bin")"
  "${path[@]}"
)

## terminal colormap
# https://github.com/sharkdp/vivid
export LS_COLORS="$(vivid generate dracula)"
