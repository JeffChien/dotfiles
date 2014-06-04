#check if specific plugin is enabled by checking the $plugins array index(1 base)

# history-substring-search: provide fish like history search feature.
# https://github.com/zsh-users/zsh-history-substring-search
if (( ${plugins[(i)history-substring-search]} <= ${#plugins} )); then
     # bind UP and DOWN arrow keys
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    # bind P and N for EMACS mode
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down

    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

# zsh-autosuggestions provide fish feature to zsh
# https://github.com/tarruda/zsh-autosuggestions
if (( ${plugins[(i)autosuggestions]} <= ${#plugins} )); then
    # Setup zsh-autosuggestions

    # Enable autosuggestions automatically
    zle-line-init() {
        zle autosuggest-start
    }
    zle -N zle-line-init

    # use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
    # zsh-autosuggestions is designed to be unobtrusive)
    bindkey '^T' autosuggest-toggle

    # Accept suggestions without leaving insert mode
    bindkey '^f' vi-forward-word
    # or
    #bindkey '^f' vi-forward-blank-word
fi
