export ZSH_CACHE_DIR="$HOME/.cache/zsh"
if [[ ! -d "$ZSH_CACHE_DIR" ]]; then
    mkdir -p "$ZSH_CACHE_DIR"
fi

source $ZPLUG_HOME/init.zsh

# commands {{{
zplug "clvv/fasd", as:command, use:fasd
zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq, \
    use:"jq-osx-amd64", \
    if:"[[ $OSTYPE == *darwin* ]]"

zplug "stedolan/jq", \
    from:gh-r, \
    as:command, \
    rename-to:jq, \
    use:"jq-linux64", \
    if:"[[ $OSTYPE == *linux* ]]"

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

zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'

zplug "yyuu/pyenv", \
    as:command, \
    use:'bin/pyenv', \
    hook-load:"export PYENV_ROOT=$ZPLUG_ROOT/repos/yyuu/pyenv"

zplug "yyuu/pyenv-virtualenv", \
    on:'yyuu/pyenv', \
    hook-build:"ln -s $ZPLUG_ROOT/repos/yyuu/pyenv-virtualenv $ZPLUG_ROOT/repos/yyuu/pyenv/plugins/pyenv-virtualenv", \
    if:"[[ -d  $ZPLUG_ROOT/repos/yyuu/pyenv ]]"
# }}}


# plugins
#zplug "zsh-users/zsh-syntax-highlighting", nice:10
#zplug "zsh-users/zsh-history-substring-search"  #if not enable highlighting, need this config: nice:10
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zaw"
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/fasd", from:oh-my-zsh, if:"(( $+commands[fasd] ))", on:"clvv/fasd"
zplug "plugins/ssh", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/key-bindings", from:oh-my-zsh
zplug "mafredri/zsh-async"

# local
zplug "~/dotfiles/zsh/configs", from:local, use:"*.zsh"
zplug "~/", from:local, use:".zshrc.local",if:"[[ -e ~/.zshrc.local ]]"

# theme
#zplug "dracula/zsh", as:theme
zplug "sindresorhus/pure", as:theme, use:pure.zsh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

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

[ -d "$HOME/.shellconf/rc.d" ] && {
    pushd "$HOME/.shellconf/rc.d" >/dev/null
        for conf in $(ls .); do
            source "$conf"
        done
    popd >/dev/null
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/credentials/homebrew ] && source ~/credentials/homebrew

alias nvim='exec_scmb_expand_args /usr/local/bin/nvim'
