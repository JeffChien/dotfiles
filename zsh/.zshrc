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
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git debian dircycle vimpager fasd autols)
plugins=(
    git
    debian
    vimpager
    fasd
    autols
    pip
    npm
    tmuxinator
    vagrant
    zsh-syntax-highlighting
    scala
    docker
    zsh_reload
    web-search
    zsh-history-substring-search
    #autosuggestions
)

if [[ -n "$TMUX" ]]; then
    export TERM=screen-256color
else
    case "$TERM" in
        xterm) export TERM=xterm-256color;;
        linux)
            if [[ -n $FBTERM ]]; then
                export TERM=fbterm
            fi
        ;;
    esac
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export USE_CCACHE=1
export EDITOR=vim
export BROWSER=firefox

for conf in `ls "$HOME/.shellconf/conf.d"`; do
    source "$HOME/.shellconf/conf.d/$conf"
done

# disable ctrl-s stop terminal feature {{{
stty stop undef
stty -ixon
# }}}

#source ~/zsh-history-subs/zsh-history-substring-search.zsh

## bind UP and DOWN arrow keys
#zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down

## bind P and N for EMACS mode
#bindkey -M emacs '^P' history-substring-search-up
#bindkey -M emacs '^N' history-substring-search-down

## bind k and j for VI mode
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

## Setup zsh-autosuggestions
#source ~/.zsh-autosuggestions/autosuggestions.zsh

## Enable autosuggestions automatically
#zle-line-init() {
    #zle autosuggest-start
#}
#zle -N zle-line-init

## use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
## zsh-autosuggestions is designed to be unobtrusive)
#bindkey '^T' autosuggest-toggle
