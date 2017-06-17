#zmodload zsh/zprof
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
    mkdir -p "$ZSH_CACHE_DIR"
fi

source $ZPLUG_HOME/init.zsh

# commands {{{
zplug "clvv/fasd", \
    as:command, \
    use:"fasd"

zplug "stedolan/jq", \
    as:command, \
    from:gh-r, \
    rename-to:jq

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*darwin*amd64*", \
    if:"[[ $OSTYPE == *darwin* ]]"

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*", \
    if:"[[ $OSTYPE == *linux* ]]"

zplug "junegunn/fzf", \
    use:"shell/*.zsh", \
    defer:2

zplug "Tarrasch/zsh-bd", \
    use:"bd.zsh", \
    defer:2

zplug "creationix/nvm"
zplug "pyenv/pyenv", as:command, use:"bin/pyenv"
zplug "moovweb/gvm"

#}}}


# plugins
#zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "zsh-users/zsh-history-substring-search"  #if not enable highlighting, need this config: defer:2
#zplug "zsh-users/zsh-autosuggestions"
#zplug "zsh-users/zaw"

zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/fasd", from:oh-my-zsh, if:"(( $+commands[fasd] ))", on:"clvv/fasd"
zplug "lib/history", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/key-bindings", from:oh-my-zsh
#zplug "mafredri/zsh-async"

# local
zplug "~/dotfiles/zsh/configs", from:local, use:"*.zsh"
zplug "~/", from:local, use:".zshrc.local", if:"[[ -e $HOME/.zshrc.local ]]"
zplug "~/.config/yarn/global/node_modules/.bin", from:local, use:"*", as:command

# theme
zplug "dracula/zsh", as:theme
#zplug "sindresorhus/pure", as:theme, use:pure.zsh

#if ! zplug check --verbose; then
    #printf "Install? [y/N]: "
    #if read -q; then
        #echo; zplug install
    #fi
#fi

zplug "~/.shellconf/rc.d", from:local, use:"*"
zplug "~/credentials", from:local, use:"homebrew"

zplug load

# config
if zplug check 'zsh-users/zsh-history-substring-search'; then
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
fi

if zplug check 'zsh-users/zsh-autosuggestions'; then
    bindkey '^ ' autosuggest-accept
fi

if zplug check '~/dotfiles/zsh/configs'; then
    bindkey '^o' widget-ranger-cd
fi

if zplug check 'pyenv/pyenv'; then
    function vm_py() {
        export PYENV_ROOT="$ZPLUG_REPOS/pyenv/pyenv"
        eval "$(pyenv init -)"
    }
    autoload -Uz vm_py
    vm_py
fi

if zplug check 'creationix/nvm'; then
    function vm_node() {
        export NVM_DIR=$ZPLUG_REPOS/creationix/nvm
        source "$NVM_DIR/nvm.sh"
    }
    autoload -Uz vm_node
fi

if zplug check 'moovweb/gvm'; then
    function vm_go() {
        export GVM_ROOT="$ZPLUG_REPOS/moovweb/gvm"
        source "$GVM_ROOT/scripts/gvm-default"
    }
    autoload -Uz vm_go
fi

if (( $+commands[direnv] )); then
    eval "$(direnv hook zsh)"
fi

show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
PS1='$(show_virtual_env)'$PS1
