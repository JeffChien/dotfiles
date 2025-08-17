#!/usr/bin/env bash

usage() {
    cat << EOF >&2
Usage: ${0##*/} <subcommand>

Available subcommands:
    session    - do the session thing
    window     - do the window thing
    pane       - do the pane thing
    server     - do the server thing

Run "${0##*/} <subcommand> --help" for more details about a subcommand.
EOF

    exit 1
}

# ---- Guard: a sub‑command must be supplied --------------------
[[ $# -eq 0 ]] && usage

action_text=""
action_command=""

# ---- Dispatch based on the first argument ----------------------
case "$1" in
    session)
        # put whatever you need for session here
        action_text="session"
        action_command="kill-session"
        ;;

    window)
        # ---- Code for window ------------------------------------
        # put whatever you need for window here
        action_text="window"
        action_command="kill-window"
        ;;

    pane)
        # ---- Code for pane ------------------------------------
        # put whatever you need for pane here
        action_text="pane"
        action_command="kill-pane"
        ;;
    server)
        # ---- Code for pane ------------------------------------
        # put whatever you need for pane here
        action_text="server"
        action_command="kill-server"
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

confirm_text=$(printf "Do you really want to kill the %s ?" "$action_text")
whiptail --yesno "$confirm_text" 10 60 --defaultno
(( $? == 0 )) && tmux "$action_command"


# ------------------------------------------------------------
# Exit status:
#   0 – successful execution of a known subcommand
#   1 – missing or unknown subcommand (handled by usage)
# ------------------------------------------------------------
exit 0