unbind-key C-b
set -g prefix C-s
bind-key C-s send-prefix

set -g default-terminal 'screen-256color-s'
set-window-option -g mode-keys vi
set-window-option -g automatic-rename off
set-window-option -g allow-rename off

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind-key -t vi-copy 'v' begin-selection
bind-key -t vi-copy 'y' copy-selection

