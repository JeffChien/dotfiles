
source ${HOME}/.osenv

if [ -n "$ZSH_ENV_NAME" ]; then
  export ZDOTDIR="$HOME/.config/zsh/$ZSH_ENV_NAME"
else
  export ZDOTDIR="$HOME/.config/zsh"
fi

[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
