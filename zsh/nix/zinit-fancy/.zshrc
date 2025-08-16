fpath=(
    "$XDG_DATA_HOME/zsh/completions"
    /usr/local/share/zsh/site-functions
    "${fpath[@]}"
)

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth"1"
zinit light romkatv/zsh-defer

# light powerlevel10k theme
zinit ice depth"1"
zinit light romkatv/Powerlevel10k

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
zinit ice if'[[ -f "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]'
zinit snippet "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"

zinit ice if'[[ -f "$ZDOTDIR/.p10k.zsh" ]]'
zinit snippet "$ZDOTDIR/.p10k.zsh"

# auto suggestion conflicts with history-search-multi-word
zinit ice wait'2' lucid depth"1"; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'2' lucid depth"1"; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait'2' lucid depth"1" blockf; zinit light zsh-users/zsh-completions

HISTFILE="$HOME/.local/share/zsh/.zhistory"       # The path to the history file.
HISTSIZE=20000
SAVEHIST=20000
## History options
# https://zsh.sourceforge.io/Doc/Release/Options.html
# setopt APPENDHISTORY # fix multiple zsh sessions override history file
setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exits.
setopt SHAREHISTORY  # share history file across all sessions
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS  # Don\'t record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete old recorded entry if new entry is a duplicate, even if it is not the previous event.
setopt HIST_FIND_NO_DUPS  # Do not display a line previously found, even if the duplicates are not contiguous.
setopt HIST_IGNORE_SPACE  # Don\'t record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS  # Don\'t write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS  # Remove superfluous blanks before recording entry.

export ZCOMPCACHE="$XDG_CACHE_HOME/zsh/compcache"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"
ZINIT[ZCOMPDUMP_PATH]="$ZSH_COMPDUMP"
export ZSH_SESSIONS_DIR="$XDG_DATA_HOME/zsh/sessions"

## terminal colormap
# https://github.com/sharkdp/vivid
function update_ls_color() {
    export LS_COLORS="$(vivid generate molokai)"
};
zsh-defer -t3 update_ls_color

# Remove '/' allows me to manipulate path string easier.
## '//' means global subsitution.
WORDCHARS=${WORDCHARS//[\/]}

zinit ice wait'0' lucid depth"1" atload"source shell/key-bindings.zsh; source shell/completion.zsh"
zinit light junegunn/fzf
# [ctrl/cmd] + t, file menu
# [ctrl/cmd] + r, history menu
# [alt/escape] + c, directory menu

zinit ice lucid wait'1' depth"1"
zinit light joshskidmore/zsh-fzf-history-search

zinit ice wait'1' lucid depth"1"
zinit light Aloxaf/fzf-tab

export FZF_DEFAULT_OPTS="--ansi --multi --height=40%"
export FZF_CTRL_T_OPTS="--preview 'bat {} -r 1:32 --color=always'"
export FZF_ALT_C_OPTS="--preview 'ls -F --color=always {}'"
if (( $+commands[fd] )); then
    export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git --color=always --maxdepth=3'
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color=always --maxdepth=3'
fi

zinit ice wait'1' lucid
zinit snippet "$HOME/dotfiles/zsh/nix/lib/fzf.zsh"

export export ENHANCD_COMMAND=cdd
zinit ice wait'0' lucid depth=1
zinit light babarot/enhancd

function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSER
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
}
zinit ice wait'0' lucid depth=1
zinit light jeffreytse/zsh-vi-mode
# vv to edit current command in $EDITOR

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux-3rd-plugins"
[[ ! -d "$TMUX_PLUGIN_MANAGER_PATH" ]] && mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"
zinit ice wait'2' lucid atclone'./bin/install_plugins'
zinit light tmux-plugins/tpm

export ASDF_DATA_DIR="$HOME/.asdf"
path=("$ASDF_DATA_DIR/shims" $path)
asdf_update_java_home() {
  JAVA_HOME=$(realpath $(dirname $(readlink -f $(asdf which java)))/../)
  export JAVA_HOME;
}

# autolight -U add-zsh-hook
# add-zsh-hook precmd asdf_update_java_home

if (( $+commands[kubectl] )); then
    other_confs=$(find "$HOME/.kube/config.d" -type f -exec readlink -f {} \+ | paste -s -d ':' -)
    if [[ ! -z "$other_confs" ]]; then
        export KUBECONFIG="$HOME/.kube/config:${other_confs}"
    fi

    path=("$HOME/.krew/bin" $path)
fi

if (( $+commands[spark-submit] )); then
    SPARK_HOME="/opt/homebrew/opt/apache-spark/libexec"
    [[ -d "$SPARK_HOME" ]] && export SPARK_HOME
fi

if (( $+commands[node] )); then
    # npm pachage
    export NPM_PACKAGES="${HOME}/.npm-packages"
    export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
    path=("$NPM_PACKAGES/bin" $path)

    if (( $+commands[pnpm] )); then
        export PNPM_HOME="$XDG_DATA_HOME/pnpm"
        [[ -d "$PNPM_HOME" ]] || mkdir -p "$PNPM_HOME"
        path=("$PNPM_HOME" $path)
    fi
fi

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
path=("$CARGO_HOME/bin" $path)
if (( ! $+commands[rustup] )); then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if (( $+commands[direnv] )); then
    zsh-defer -t2 eval "$(direnv hook zsh)"
fi

# OS related
case "$OS_NAME" in
  Darwin)
    export HOMEBREW_NO_AUTO_UPDATE=1
    zinit ice wait'4' lucid depth"1" atclone'ln -s `pwd` "$HOME/iTerm2-Color-Schemes"' atpull'%atclone'
    zinit light mbadolato/iTerm2-Color-Schemes

    zinit ice wait lucid if'[[ -n "$ITERM_SESSION_ID" ]]'
    zinit snippet "${HOME}/.iterm2_shell_integration.zsh"

    # ALIAS
    zinit ice wait'2' lucid if'[[ -x "/usr/libexec/java_home" ]]'
    zinit snippet "$HOME/.config/zsh/lib/java.zsh"
  ;;
  Linux)
    # disable ctrl-s stop terminal feature {{{
    stty stop undef
    stty -ixon
    # }}}
  ;;
esac

zinit ice if'[[ -e $HOME/.localrc.zsh ]]'
zinit snippet "$HOME/.localrc.zsh"

# cleanup path
function finalize_path() {
    temp_path=()
    for p in "${path[@]}"; do
        [[ -d "$p" ]] && temp_path+=($p)
    done
    path=($temp_path)
}; finalize_path

function make_alias() {
    if (( $+commands[eza] )); then
        alias ls='eza -A -F --icons --color=auto --group-directories-first'
        alias ll='ls -A -l --time-style iso'
        alias tree='eza -T --icons --color=auto --group-directories-first'
        alias tree2='tree -L2'
        alias tree4='tree -L4'
        alias tree8='tree -L8'
    fi
    alias grep='rg --color=auto -S'
    alias egrep='rg --color=auto -e'
    alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'
    alias lspath='print -l $path'
    alias em='emacsclient -t -a ""'                # Opens emacs inside terminal
    alias please='sudo $(fc -ln -1)' # sudo the last command
    alias mkdir='mkdir -p'
    alias cd='builtin cd'
    alias ..='cd ..'
    alias cd-='cdd ..'
    (( $+commands[bat] )) && alias cat='bat --paging=never --theme="ansi" --style=numbers,changes'
    if (( $+commands[coreutils] )); then
        alias cp='coreutils cp'
        alias mv='coreutils mv'
        alias tac='coreutils tac'
        alias head='coreutils head'
        alias tail='coreutils tail'
        alias date='coreutils date'
        alias df='coreutils df'
        alias du='coreutils du'
        alias sort='coreutils sort'
    fi
    (( $+commands[gfind] )) && alias find='gfind'
    (( $+commands[gsed] )) && alias sed='gsed'
}; make_alias

function zsh_style_setup() {
    # case-insensitive completion
    zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
    # disable sort when completing `git checkout`
    zstyle ':completion:*:git-checkout:*' sort false
    # set descriptions format to enable group support
    zstyle ':completion:*:descriptions' format '[%d]'
    # set list-colors to enable filename colorizing
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    # preview directory's content with eza completing cd
    zstyle ':fzf-tab:complete:(cd):*' fzf-preview 'eza -1 --color=always $realpath'
    # switch group using `,` and `.`
    zstyle ':fzf-tab:*' switch-group ',' '.'
    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu select
    zstyle ':completion:*:default' list-dirs-first true
    zstyle ':completion:*' completer _extensions _complete _approximate

    # Use cache for commands using cache
    zstyle ':completion:*' use-cache on
    zstyle ':completion:*' cache-path "$ZCOMPCACHE"

    # Autocomplete options for cd instead of directory stack
    zstyle ':completion:*' complete-options true

    zstyle ':completion:*' file-sort modification
}; zsh-defer -t1 zsh_style_setup

zpcompinit
zpcdreplay