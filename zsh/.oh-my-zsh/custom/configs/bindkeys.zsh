# {{{ vi mode
# 'jj' back to normal mode
bindkey -M viins 'jj' vi-cmd-mode
# history
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M viins '^s' history-incremental-search-forward
bindkey -M viins '^n' down-history
bindkey -M viins '^p' up-history
# ctrl-n/ctrl-p jump or back complete candidate
#bindkey -M viins '^n' menu-complete
#bindkey -M viins '^p' reverse-menu-complete
bindkey -M viins '^[[Z' reverse-menu-complete
# gn/gp jump or back complete group
bindkey -M viins ',gn' vi-forward-blank-word
bindkey -M viins ',gp' vi-backward-blank-word
#fix history can't be modify
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^h' backward-delete-char
bindkey -M viins '^w' backward-kill-word
# }}}
