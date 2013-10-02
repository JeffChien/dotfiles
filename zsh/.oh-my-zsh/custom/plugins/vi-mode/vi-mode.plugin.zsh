# Ensures that $terminfo values are valid and updates editor information when
# the keymap changes.
function zle-keymap-select zle-line-init zle-line-finish {
  # The terminal must be in application mode when ZLE is active for $terminfo
  # values to be valid.
  if (( $+terminfo[smkx] && $+terminfo[rmkx] )); then
    case "$0" in
      (zle-line-init)
        # Enable terminal application mode.
        echoti smkx
      ;;
      (zle-line-finish)
        # Disable terminal application mode.
        echoti rmkx
      ;;
    esac
  fi
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

bindkey -v

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR_INSERT" == "" ]]; then
  MODE_INDICATOR_INSERT=INSERT
fi

if [[ "$MODE_INDICATOR_NORMAL" == "" ]]; then
  MODE_INDICATOR_NORMAL=NORMAL
fi

vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR_NORMAL}/(main|viins)/$MODE_INDICATOR_INSERT}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$VIMODE_PROMPT" == "" ]]; then
  VIMODE_PROMPT='$(vi_mode_prompt_info)'
fi
