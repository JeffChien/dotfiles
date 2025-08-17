#!/usr/bin/env expect -f
# base on https://askubuntu.com/a/5378

# Get a Bash shell
spawn -noecho zsh

# Wait for a prompt
expect "❯"

# Type something
send "tmux "

# cause fzf is loaded using zinit tubo mode
sleep 1.2

# trigger completion
send "\t"

# Hand over control to the user
interact

exit