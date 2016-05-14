# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="my-steeef"
ZSH_THEME="jc"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git debian dircycle vimpager fasd autols)
plugins=(
    git
    #debian
    vimpager
    fasd
    autols
    pip
    #npm
    #tmuxinator
    #vagrant
    #zsh-syntax-highlighting
    #scala
    docker
    docker-compose
    #zsh_reload
    #web-search
    #zsh-history-substring-search
    #autosuggestions
    ranger
    percol
    git-extras
    httpie
    sudo
)

[ -d "$HOME/.shellconf/rc.d" ] && {
    pushd "$HOME/.shellconf/rc.d" >/dev/null
        for conf in $(ls .); do
            source "$conf"
        done
    popd >/dev/null
}

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/credentials/homebrew ] && source ~/credentials/homebrew
