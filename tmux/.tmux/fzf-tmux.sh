#!/usr/bin/env bash

#{{{ https://github.com/junegunn/fzf/wiki/Examples#tmux
fs() {
  local session
  local currentSession
  currentSession=$(tmux display -p '#{client_session}')
  session=$(tmux list-sessions -F "#{session_attached}:#{session_name}" | \
      fzf --query="$1" --select-1 --exit-0 --prompt="($currentSession) >" --header='tmux sessions' | cut -d':' -f2) &&
  tmux switch-client -t "$session"
}

# ftpane - switch pane
ftpane () {
  local panes current_window target target_window target_pane current_pane
  current_window=$(tmux display-message  -p '#I')
  if (( $IGNORE_SPLIT )); then
      current_pane=$(tmux display-message  -p '#P')
      panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}' | \
          grep -vE "^($current_window:$current_pane)")
  else
      panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command} #{pane_pid}')
  fi

  target=$(echo "$panes" | fzf) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}
#}}}

subcommand="$1"; shift
case "$subcommand" in
    panel)
		ftpane
        ;;
    session)
		fs
        ;;
    *)
        cat <<-EOF
			usage: fzf-tmux.sh <panel|session>
		EOF
        ;;
esac
