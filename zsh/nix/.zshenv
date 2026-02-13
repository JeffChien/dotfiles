
[[ -f ${HOME}/.osenv ]] && source ${HOME}/.osenv

if [ -n "$ZSH_ENV_NAME" ]; then
  export ZDOTDIR="$HOME/.config/zsh/$ZSH_ENV_NAME"
else
  export ZDOTDIR="$HOME/.config/zsh"
fi

# agent detector, agent don't need fancy zsh environment like human
# this is a workaround, most agent app don't have a way to configure shell command.
AGENT_PROCESS=(
  "opencode"
  "opencode-cli"
  "claude"
  "codex"
)

AGENT_VARS=(
  "VSCODE_PREVENT_SHELL_HISTORY"
  "OPENCODE"
  "AGENT"
)

PARENT_NAME=$(ps -o comm= -p $PPID)

agent_detected=false
# (ie) performs exact match in array and returns index if found
if [[ ${AGENT_PROCESS[(ie)$PARENT_NAME]} -le ${#AGENT_PROCESS} ]]; then
  agent_detected=true
else
  for var in "${AGENT_VARS[@]}"; do
    # ${(P)var} performs indirect parameter expansion
    if [[ -n "${(P)var}" ]]; then
      agent_detected=true
      break
    fi
  done
fi

if $agent_detected; then
  export ZDOTDIR="$HOME/dotfiles/zsh/nix/agent"
fi

[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv