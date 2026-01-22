# Keybindings (brief):
#
# | Key/Binding         | Description                                         | Notes/Function                      |
# |---------------------|-----------------------------------------------------|-------------------------------------|
# | ^T (Ctrl-T)         | File picker / file menu                            | _ctrl_t_file → fzf preview          |
# | ^R (Ctrl-R)         | History menu (fzf-based)                           |                                     |
# | \ec (Alt-c)         | Directory menu                                     | _alt_c_dir                          |
# | \e\\ (Alt-\)        | Send message to aichat                             | _aichat_zsh                         |
# | vv                  | Edit current command in $EDITOR                    | via vi-mode                         |
# | Alt+BackTab         | Backward-kill-word in vi-insert mode               | mapped in zvm                       |
#
# See shell/key-bindings.zsh and lib/ for more bindings and helper functions.

# Helper commands
# to remove dangling plugins / snippets
# $ zinit delete --clean
#
# to remove a plugin / snippet
# $ zinit delete <name>
#
# to upgrade bump zinit
# $ zinit self-update
#
# Plugin parallel update
# $ zinit update --parallel
#


fpath=(
    "$HOME/dotfiles/zsh/nix/autoload"
    "$HOME/dotfiles/zsh/nix/completions"
    "$XDG_DATA_HOME/zsh/completions"
    /opt/homebrew/share/zsh/site-functionqs
    /usr/local/share/zsh/site-functions
    $fpath
)

# path=(
#     $path
# )

typeset -Ux path_mid
path_mid=(
    "$HOME/.lmstudio/bin"
    "$HOME/.cache/.bun/bin"
    "$HOME"/.nix-profile/bin
)

typeset -Ux path_top
path_top=(
    "$HOME/bin"
    "$HOME/.local/bin"
)

HISTFILE="$XDG_DATA_HOME/zsh/.zhistory"       # The path to the history file.
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
export ZSH_SESSIONS_DIR="$XDG_DATA_HOME/zsh/sessions"
export NVIM_APPNAME="nvim-lazy"

typeset -A ZINIT
ZINIT[ZCOMPDUMP_PATH]="$ZSH_COMPDUMP"
ZINIT[NO_ALIASES]=1

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice depth"1"
zinit light romkatv/zsh-defer

zle_highlight=(paste:none) # because it make cursor invisible

# ignore expansion of these regular/global aliases
export ZPWR_EXPAND_BLACKLIST=(cd ls ll rtrim)
# aliases expand in first position
export ZPWR_EXPAND=true
# aliases expand in second position after sudo
export ZPWR_EXPAND_SECOND_POSITION=true
# expand globs, history etc with zle expand-word
export ZPWR_EXPAND_NATIVE=true
# spelling correction in zsh-expand plugin
export ZPWR_CORRECT=true
# aliases expand after spelling correction
export ZPWR_CORRECT_EXPAND=true
# expand inside "
export ZPWR_EXPAND_QUOTE_DOUBLE=true
# expand inside '
export ZPWR_EXPAND_QUOTE_SINGLE=false
# expand into history any unexpanded
export ZPWR_EXPAND_TO_HISTORY=false

zinit ice lucid depth"1" nocompile
zinit load MenkeTechnologies/zsh-expand

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
typeset -g POWERLEVEL9K_TERM_SHELL_INTEGRATION=true

# auto suggestion conflicts with history-search-multi-word
zinit ice wait'2' lucid depth"1"; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'2' lucid depth"1"; zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait'2' lucid depth"1" blockf; zinit light zsh-users/zsh-completions

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
# ctrl + t, file menu
# ctrl + r, history menu
# [alt/escape] + c, directory menu

zinit ice lucid wait'1' depth"1"
zinit light joshskidmore/zsh-fzf-history-search

zinit ice wait'1' lucid depth"1"
zinit light Aloxaf/fzf-tab

export FZF_DEFAULT_OPTS="--ansi --multi --height=40%"
export FZF_CTRL_T_OPTS="--preview 'bat {} -r 1:32 --color=always'"

export FZF_DEFAULT_OPTS="--ansi --multi --height=40%"
export FZF_CTRL_T_COMMAND='' # don't use fzf's keybinding
export FZF_ALT_C_COMMAND='' # don't use fzf's keybinding

zinit ice wait'0' lucid id-as"snippect-local-fuzzy-select"
zinit snippet "$HOME/dotfiles/zsh/nix/lib/fuzzy-select.zsh"

autoload -Uz aicmd
autoload -Uz fuzzy_man
autoload -Uz bd
autoload -Uz fff

zinit ice wait'0' lucid id-as"snippect-local-utils"
zinit snippet "$HOME/dotfiles/zsh/nix/lib/utils.zsh"

## Quick cd solution
# Be nice to the disk, just don't use babarot/enhancd, it rewrite entire large log directory log every time
# we use it.
if (( $+commands[zoxide] )); then
    zsh-defer eval "$(zoxide init zsh)"
fi

# script generated by `broot --install`, needed for interactive cd
zinit ice wait'0' lucid if'[[ -e $XDG_CONFIG_HOME/broot/launcher/bash/br ]]'
zinit snippet "$XDG_CONFIG_HOME/broot/launcher/bash/br"

function after_aichat() {
    # alt + \ , send messsage to aichat -e "<message>"
    bindkey -M main '\e\\' _aichat_zsh
    bindkey -M vicmd '\e\\' _aichat_zsh
    bindkey -M viins '\e\\' _aichat_zsh
}
zinit ice wait'2' lucid if'[[ -n "$commands[aichat]" ]]' id-as'snippet-aichat-zsh' atload'after_aichat'
zinit snippet "https://raw.githubusercontent.com/sigoden/aichat/refs/heads/main/scripts/shell-integration/integration.zsh"


function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSER
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
  ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE

  bindkey -M viins '^[^?' backward-kill-word # alt + backtab
  # use my implementations of fzf ctrl-t and alt-c functions.
  for keymap in emacs viins vicmd; do
      bindkey -M $keymap '^T' _ctrl_t_file
      bindkey -M $keymap '\ec' _alt_c_dir
  done
}
zinit ice wait'0' lucid depth=1
zinit light jeffreytse/zsh-vi-mode
# vv to edit current command in $EDITOR

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux-3rd-plugins"
[[ ! -d "$TMUX_PLUGIN_MANAGER_PATH" ]] && mkdir -p "$TMUX_PLUGIN_MANAGER_PATH"
zinit ice wait'2' lucid atclone'./bin/install_plugins'
zinit light tmux-plugins/tpm

ASDF_DATA_DIR="$HOME/.asdf"
if [[ -d $ASDF_DATA_DIR ]]; then
    export ASDF_DATA_DIR
    path_mid=("$ASDF_DATA_DIR/shims" $path_mid)
fi
asdf_update_java_home() {
  JAVA_HOME=$(realpath $(dirname $(readlink -f $(asdf which java)))/../)
  export JAVA_HOME;
}

# autolight -U add-zsh-hook
# add-zsh-hook precmd asdf_update_java_home
typeset -Ux kubeconfig=( "$HOME/.kube/config" )
if [[ -d "$HOME/.kube/config.d" ]]; then
    other_confs=($(find "$HOME/.kube/config.d" -type f -exec readlink -f {} \+ | paste -s -d ':' -))
    kubeconfig=($other_confs $kubeconfig)
    path_mid=("$HOME/.krew/bin" $path_mid)
fi

SPARK_HOME="/opt/homebrew/opt/apache-spark/libexec"
if [[ -d "$SPARK_HOME" ]]; then
    export SPARK_HOME
fi

NPM_PACKAGES="${HOME}/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/node_modules:$NODE_PATH"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
path_mid=(
    "$PNPM_HOME"
    "$NPM_PACKAGES/bin"
    $path_mid)

export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
path=("$CARGO_HOME/bin" $path)

if (( $+commands[direnv] )); then
    zsh-defer -t2 eval "$(direnv hook zsh)"
fi

export OPENCODE_CONFIG_DIR="${HOME}/workspace/llmcli/opencode"
export OPENCODE_CONFIG="${OPENCODE_CONFIG_DIR}/opencode.jsonc"

# OS related
case "$OS_NAME" in
  Darwin)
    export HOMEBREW_NO_AUTO_UPDATE=1
    zinit ice wait'4' lucid depth"1" atclone'ln -s `pwd` "$HOME/iTerm2-Color-Schemes"' atpull'%atclone' if'[[ ! -z $ITERM_SESSION_ID ]]'
    zinit light mbadolato/iTerm2-Color-Schemes

    zinit ice wait lucid if'[[ ! -z $ITERM_SESSION_ID ]]'
    zinit snippet "${HOME}/.iterm2_shell_integration.zsh"

    # ALIAS
    zinit ice wait'2' lucid if'[[ -x "/usr/libexec/java_home" ]]'
    zinit snippet "$HOME/dotfiles/zsh/nix/lib/java.zsh"

    # vscode os related
    path_mid=(
        "/Applications/Ghostty.app/Contents/MacOS"
        "/Applications/flameshot.app/Contents/MacOS"
        "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/bin"
        "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        $path_mid)
    # if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    #     zsh-defer -t1 source "$(code --locate-shell-integration-path zsh)"
    # fi

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
    for p in "${path_top[@]}" "${path_mid[@]}" "${path[@]}" ; do
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
    alias icat='chafa' # easy to remember
    alias grep='rg --color=auto -S'
    alias egrep='rg --color=auto -e'
    alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'
    alias lspath='print -l $path'
    alias em='emacsclient -t -a ""'                # Opens emacs inside terminal
    alias please='sudo !!' # sudo the last command
    alias mkdir='mkdir -p'
    alias cd='builtin cd'
    alias cdd='br -pf -h --max-depth=3'
    alias bdd='cdd ../../../'
    alias ezo='edit_with_zoxide'
    alias fman='fuzzy_man'
    alias aff='_aerospace_find_window'
    alias pvcp='_pv_as_cp'
    # rtrim, remove the trailing spaces and newline.
    alias rtrim="perl -pe 's/\s+$//' | perl -0777 -pe 's/\n\z//'"
    alias -g ,r='| rtrim'
    alias -g ,rc='| rtrim | pbcopy'
    alias -g ,g='| grep'
    alias -g ,p='| less -R'
    alias -g ,c='| pbcopy'
    alias -g ,pp='<(pbpaste)'
    alias -g p,='pbpaste | '
    alias -g ,='| '
    alias -g .x='> /dev/null'
    alias -g .xx='> /dev/null 2>&1'
    alias -g .2x='2> /dev/null'
    alias -g .21='2>&1'

    # replace core commands with GNU version provided by coreutils
    if [[ $OS_NAME == "Darwin" ]]; then
        local cmds=(cp mp cat tac head tail date df du sort realpath find sed awk)
        for cmd in ${cmds}; do
            (( $+commands[$cmd] )) && alias $cmd="g$cmd"
        done
    fi
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
}; zsh-defer -t0 zsh_style_setup

function final() {
    zpcompinit
    zpcdreplay

}; zsh-defer -t 1 final
