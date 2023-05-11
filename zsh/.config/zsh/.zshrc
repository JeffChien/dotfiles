fpath=(
    "$XDG_DATA_HOME/zsh/completions"
    /usr/local/share/zsh/site-functions
    "${fpath[@]}"
)

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load powerlevel10k theme
zinit ice depth"1" \  # git clone depth
  zinit light romkatv/Powerlevel10k
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
zinit ice if'[[ -r ${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh ]]'; \
  zinit snippet "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
zinit ice if'[[ -f ~/.config/zsh/.p10k.zsh ]]'; \
  zinit snippet ~/.config/zsh/.p10k.zsh

zinit ice depth"1"; zinit light zdharma-continuum/history-search-multi-word
zinit ice depth"1"; zinit light zsh-users/zsh-autosuggestions
zinit ice depth"1"; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice depth"1" blockf; zinit light zsh-users/zsh-completions

HISTFILE="$HOME/.zhistory"       # The path to the history file.

zstyle ':completion:*' match-list 'm:{a-z}={A-Za-z}'

zinit ice from"gh-r" as"program" pick"*/fd"; zinit load @sharkdp/fd

zinit ice from"gh-r" as"program" pick"bin/exa" atclone'cp -vf completions/exa.zsh _exa'; zinit load ogham/exa

zinit ice from"gh-r" as"program" pick"fzf" id-as"fzf-bin"; zinit load junegunn/fzf
zinit ice depth"1" multisrc"shell/{completion,key-bindings}.zsh" pick"bin/*" as"program"; \
    zinit load junegunn/fzf

zinit light Aloxaf/fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

export FZF_DEFAULT_OPTS="--ansi --multi --no-height --extended"
if (( $+commands[fd] )); then
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color=always'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --color=always'
fi

zinit light b4b4r07/enhancd

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux-3rd-plugins"
[[ ! -d "$TMUX_PLUGIN_MANAGER_PATH" ]] && mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"
zinit ice atclone'./bin/install_plugins'; \
    zinit light tmux-plugins/tpm

zinit load asdf-vm/asdf
asdf_update_java_home() {
  JAVA_HOME=$(realpath $(dirname $(readlink -f $(asdf which java)))/../)
  export JAVA_HOME;
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_java_home

if (( $+commands[kubectl] )); then
    other_confs=$(find "$HOME/.kube/config.d" -type f -exec readlink -f {} \+ | paste -s -d ':' -)
    if [[ ! -z "$other_confs" ]]; then
        export KUBECONFIG="${KUBECONFIG}:$HOME/.kube/config:${other_confs}"
    fi
    zinit ice if'(( $+commands[kubectl] ))' depth"1" as"program" pick"kubectx;kubens" atclone'cp completion/*.zsh .'; \
        zinit light ahmetb/kubectx
fi

# OS related
case "$OS_NAME" in
  Darwin)
    zinit ice atclone'ln -s `pwd` "$HOME/iTerm2-Color-Schemes"' atpull'%atclone'; \
        zinit load mbadolato/iTerm2-Color-Schemes

    zinit ice if'[[ -n "$ITERM_SESSION_ID" ]]'; zinit snippet "${HOME}/.iterm2_shell_integration.zsh"

    # ALIAS
    zinit ice if'[[ -x "/usr/libexec/java_home" ]]'; \
        zinit snippet "$HOME/.config/zsh/lib/java.zsh"
  ;;
  Linux)
    # disable ctrl-s stop terminal feature {{{
    stty stop undef
    stty -ixon
    # }}}
  ;;
esac

zinit ice if'[[ -e $HOME/.localrc.zsh ]]'; \
    zinit snippet "$HOME/.localrc.zsh"

alias ls='exa -F --icons --color=auto --group-directories-first'
alias ll='ls -l --time-style long-iso'
alias la='ll -a'
alias tree='exa -T --icons --color=auto --group-directories-first'
alias tree2='tree -L2'
alias tree4='tree -L4'
alias tree8='tree -L8'
alias grep='rg --color=auto -S'
alias egrep='rg --color=auto -e'
alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'
alias lspath='printf "%s\n" $path'
alias ec='emacsclient -t -a "emacs -nw"'                # Opens emacs inside terminal
alias ecw='emacsclient -cn -a "emacs"'                # Opens emacs inside terminal
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias please='sudo $(fc -ln -1)' # sudo the last command

autoload -Uz compinit
compinit

zinit cdreplay -q # -q is for quiet; actually run all the `compdef's saved before
                    #`compinit` call (`compinit' declares the `compdef' function, so
                    # it cannot be used until `compinit` is ran; zinit solves this
                    # via intercepting the `compdef'-calls and storing them for later
                    # use with `zinit cdreplay')
