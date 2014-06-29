#!/usr/bin/env bash
source ./lib/function.sh

readonly CANDIDATE=(urlview urlscan)
readonly TMPFILE=/tmp/tmux-buffer

main() {
    local p
    local program
    # check if available url parser exist
    for p in "${CANDIDATE[@]}"; do
        if (( exist "$p" )); then
            program="$p"
            break
        fi
    done
    if [[ -z "$program" ]]; then
        tmux display-message "[Error] no available url parser found"
        exit 1
    else
        tmux capture-pane -p > "$TMPFILE"
        tmux new-window -n "$program" "$SHELL -c $program < $TMPFILE"
        sleep 0.1
        rm "$TMPFILE"
    fi

    exit 0
}

main $@
