#!/usr/bin/env bash
PKGNAME='powerline-status'
SEARCH_PATHS=(
    $(pip show "$PKGNAME" | awk '/Location/ {print $2}')/powerline
)
ROOT=x
for p in ${SEARCH_PATHS[@]}; do [ -d "$p" ] && {
    ROOT="$p"
    break
}
done
if [ "$ROOT" = "x" ]; then
    >&2 echo "can find powerline in search path"
    exit 1
fi
# powerline settings
tmux set -g status on
tmux set -g status-interval 10
tmux set -g status-utf8 on
tmux set -g status-justify "left"
tmux set -g status-left-length 100
tmux set -g status-right-length 100
tmux run-shell "powerline-daemon -q"
tmux source-file "$ROOT/bindings/tmux/powerline.conf"
