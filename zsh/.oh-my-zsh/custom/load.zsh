files=()
files+=(~/.oh-my-zsh/custom/configs/complete.zsh)
files+=(~/.oh-my-zsh/custom/configs/bindkeys.zsh)
files+=(~/.oh-my-zsh/custom/configs/alias.zsh)
files+=(~/.oh-my-zsh/custom/configs/plugins_config.zsh)

for f in ${files[@]}; do
    if [[ -f "$f" ]]; then
        source "$f"
    fi
done
