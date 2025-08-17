#!/usr/bin/env bash
# need to swap stdout and stderr because of subshell

usage() {
    cat << EOF >&2
Usage: ${0##*/} <subcommand>

Available subcommands:
    session    - do the session thing
    window     - do the window thing

Run "${0##*/} <subcommand> --help" for more details about a subcommand.
EOF

    exit 1
}

[[ $# -eq 0 ]] && usage

action_text=""
action_command=""
old_name=""


case "$1" in
    session)
        # put whatever you need for session here
        action_text="session"
        action_command="rename-session"
        old_name=$(tmux display-message -p '#S')
        ;;

    window)
        # ---- Code for window ------------------------------------
        # put whatever you need for window here
        action_text="window"
        action_command="rename-window"
        old_name=$(tmux display-message -p '#W')
        ;;

    -h|--help|help)
        usage
        ;;

    *)
        # ---- Unknown subcommand --------------------------------
        echo "Error: unknown subcommand: $1" >&2
        usage
        ;;
esac

name=$(whiptail \
    --title "Rename ${action_text}" \
    --inputbox "Enter new name: " \
    15 60 \
    "$old_name" \
    3>&2 2>&1 1>&3)
(( $? == 0 )) && tmux ${action_command} "${name}"