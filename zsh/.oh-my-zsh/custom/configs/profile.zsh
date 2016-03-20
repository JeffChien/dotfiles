# fix paste will quote with extra charaters
# https://github.com/tmux/tmux/issues/223
if [ ${TMUX} ]; then
    unset zle_bracketed_paste
fi
