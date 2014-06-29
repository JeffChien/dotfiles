#!/usr/bin/env bash
source ./lib/function.sh

toclipboard() {
    if (( ! exist 'xsel' )); then
        echo $?
        tmux display-message "[Error] 'xsel' required, but not found"
        exit 1
    fi
    tmux choose-buffer 'run "tmux save-buffer -b '%%' - | xsel -i -b"'
}

totmux() {
    if (( ! exist 'xsel' )); then
        tmux display-message "[Error] 'xsel' required, but not found"
        exit 1
    fi
    xsel -o -b | tmux load-buffer - && tmux paste-buffer
}

main() {
    local argument=$1
    case "$argument" in
        to-clipboard)
            toclipboard
            ;;
        to-tmux)
            totmux
            ;;
    esac
    exit 0
}

main $@
