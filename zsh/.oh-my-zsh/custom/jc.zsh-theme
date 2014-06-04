local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
#local git_branch='$(git_prompt_info)%{$reset_color%}'




#PROMPT="╭─[$VIMODE_PROMPT]${current_dir} ${git_branch}

#PROMPT="[$VIMODE_PROMPT]${current_dir} ${git_branch}
#╰─%B$%b "

PROMPT="[$VIMODE_PROMPT]${current_dir}
╰─%B$%b "

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
#ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

MODE_INDICATOR_INSERT="%{$fg[red]%}INSERT%{$reset_color%}"
MODE_INDICATOR_NORMAL="%{$fg[green]%}NORMAL%{$reset_color%}"
