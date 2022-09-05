source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light-mode for \
    pick"zsh-lazyload.zsh" \
        qoomon/zsh-lazyload

zinit ice from"gh-r" as"program" mv"docker* -> docker-compose"; zinit light docker/compose
zinit wait lucid svn for \
  atload"zicompinit; zicdreplay" \
  blockf \
  as"completion" OMZP::docker \
  as"completion" OMZP::docker-compose \
  as"completion" id-as"complete-pip" OMZP::pip

zinit ice wait'0' lucid pick"fasd"; zinit light clvv/fasd
zinit ice wait'0' lucid svn silent; zinit snippet PZT::modules/fasd

zinit ice pick"bd.zsh"; zinit light Tarrasch/zsh-bd

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux-3rd-plugins"
[[ ! -d "$TMUX_PLUGIN_MANAGER_PATH" ]] && mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"
zinit ice wait'1' lucid atclone'ln -s `pwd` "$TMUX_PLUGIN_MANAGER_PATH/tpm" && ./bin/install_plugins'; \
    zinit light tmux-plugins/tpm

zinit load asdf-vm/asdf

zinit ice from'gh-r' as'program' mv'*direnv* -> direnv' atclone'./direnv hook zsh >! zhook.zsh' atpull'%atclone' src'zhook.zsh';
zinit load direnv/direnv

zinit ice wait'1' if'[[ -n "$commands[python3]" ]]' depth'1' lucid  as"program" pick"ft/*"; \
    zinit load sharkdp/shell-functools

zplugin ice wait'0' if'[[ -n "$commands[git]" ]]' lucid; zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin ice wait'0' if'[[ -n "$commands[git]" ]]' lucid; zplugin snippet OMZ::lib/git.zsh

zinit ice wait lucid from"gh-r" as"program" pick"*/fd"; \
    zinit load @sharkdp/fd

zinit ice wait lucid from"gh-r" as"program" pick"bin/exa"; \
    zinit load ogham/exa

zinit ice wait lucid from"gh-r" as"program" pick"fzf"; \
    zinit load junegunn/fzf

export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color=always'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git --color=always'
export FZF_DEFAULT_OPTS="--ansi --multi --no-height --extended"
zplugin ice wait'0' lucid multisrc"shell/{completion,key-bindings}.zsh" id-as"fzf-zsh"; \
    zplugin load junegunn/fzf
zplugin ice wait'0' if'[[ -n "$TMUX" ]]' lucid pick"bin/fzf-tmux" as"program" id-as"fzf-tmux"; \
    zplugin load junegunn/fzf
zplugin ice wait'0' lucid; zplugin snippet ~/.config/zsh/lib/fzf.zsh
zplugin ice wait'0' lucid; zinit light Aloxaf/fzf-tab

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

zinit ice wait'1' lucid from"gh-r" as"program"; \
    zinit load BurntSushi/xsv

zinit ice wait'0' lucid; \
    zinit load b4b4r07/enhancd

zinit ice wait'1' lucid from"gh-r" as"program" mv'httpstat* -> httpstat'; \
    zinit load davecheney/httpstat

zinit ice wait'1' lucid from"gh-r" as"program" mv'*bombardier* -> bombardier'; \
    zinit load codesenberg/bombardier

zinit ice wait'1' lucid from"gh-r" as"program"; \
    zinit load tsenart/vegeta

export ZSH_AUTOSUGGEST_USE_ASYNC=1
## zsh syntax highlighting
## autosuggestions
zinit wait lucid for \
  light-mode zdharma-continuum/fast-syntax-highlighting \
  light-mode zsh-users/zsh-autosuggestions

# complete
zinit ice blockf; zinit light zsh-users/zsh-completions

zstyle ':prezto:module:editor' key-bindings 'emacs'

HISTFILE="$HOME/.zhistory"       # The path to the history file.

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh" # pull behavior same as clone, source init.zsh
zinit light starship/starship

# OS related
case "$OS_NAME" in
  Darwin)
    zinit ice lucid atclone'ln -s `pwd` "$HOME/iTerm2-Color-Schemes"' atpull'%atclone'; \
        zinit load mbadolato/iTerm2-Color-Schemes

    #zinit ice wait'1' if'[[ -n "$ITERM_SESSION_ID" ]]' lucid; zinit snippet "${HOME}/.iterm2_shell_integration.zsh"

    # ALIAS
    zinit ice wait'0' if'[[ -x "/usr/libexec/java_home" ]]' lucid; \
        zinit snippet ~/.config/zsh/lib/java.zsh
  ;;
  Linux)
    # disable ctrl-s stop terminal feature {{{
    stty stop undef
    stty -ixon
    # }}}
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

zinit ice if'[[ -e $HOME/.localrc.zsh ]]' lucid; \
    zinit load "$HOME/.localrc.zsh"
lazyload k3d -- 'source <(k3d completion zsh)'
lazyload kind -- 'source <(kind completion zsh)'
lazyload helm -- 'source <(helm completion zsh)'
lazyload zoxide -- 'source <(zoxide init zsh)'

if [[ -n "$commands[kubectl]" ]]; then
  lazyload kubectl -- 'source <(kubectl completion zsh)'
  other_confs=$(find "$HOME/.kube/config.d" -type f -exec readlink -f {} \+ | paste -s -d ':' -)
  if [[ ! -z "$other_confs" ]]; then
    export KUBECONFIG="${KUBECONFIG}:$HOME/.kube/config:${other_confs}"
  fi
fi

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

asdf_update_java_home() {
  JAVA_HOME=$(realpath $(dirname $(readlink -f $(asdf which java)))/../)
  export JAVA_HOME;
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_java_home


autoload -Uz compinit
compinit

zstyle ':completion:*' match-list 'm:{a-z}={A-Za-z}'


zinit cdreplay -q # -q is for quiet; actually run all the `compdef's saved before
                    #`compinit` call (`compinit' declares the `compdef' function, so
                    # it cannot be used until `compinit` is ran; zinit solves this
                    # via intercepting the `compdef'-calls and storing them for later
                    # use with `zinit cdreplay')
