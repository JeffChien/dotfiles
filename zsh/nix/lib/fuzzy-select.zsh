# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#### git + fzf
# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local _gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
  local _viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
  local commit
  commit=$(git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@" | \
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview $_viewGitLogLine ) && \
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# backward cd
bd() {
  candidates=()
  pdir="$(pwd)"
  while [[ "$pdir" != "/" ]]; do
	  pdir=$(dirname "$pdir")
	  candidates+=("$pdir")
  done
  choice=$(printf "%s\n" "${candidates[@]}" | 
    fzf --height 40% --reverse --preview 'ls --color=always {}'
  )
  [[ -n "$choice" ]] && builtin cd "$choice"
}

# edit_with_zoxide - Easy file finder and opener
#
# A smart file finder that combines fd (fast find), fzf (fuzzy finder), and zoxide (directory jumper)
# to provide quick file navigation and editing capabilities.
#
# Usage:
#   edit_with_zoxide                    # Interactive file selection from current directory tree
#   edit_with_zoxide <context>          # Search for files within directories matching context (via zoxide)
#   edit_with_zoxide <context> <query>  # Search for files matching query within context directories
#
# Features:
#   - Uses fd for fast file discovery with smart ignore patterns
#   - Provides fzf interface with bat syntax highlighting for file previews
#   - Integrates with zoxide for context-aware directory searching
#   - Automatically opens selected file in $EDITOR
#   - Ignores common non-source files (.git, .cache, .vscode, etc.)
#
# Examples:
#   edit_with_zoxide                    # Browse and open any file in current project
#   edit_with_zoxide nvim               # Find files within directories containing "nvim"
#   edit_with_zoxide work .py           # Find Python files within "work" context directories
#   edit_with_zoxide config yaml        # Find YAML files in "config" related directories
#
# Dependencies:
#   - fd: Fast file finder (https://github.com/sharkdp/fd)
#   - fzf: Fuzzy finder (https://github.com/junegunn/fzf)
#   - bat: Syntax highlighting (https://github.com/sharkdp/bat)
#   - zoxide: Directory jumper (https://github.com/ajeetdsouza/zoxide)
#
edit_with_zoxide() {
    local context="$1"
    local query="$2"
    local fd_ignores=(-E .git -E .git-crypt -E .cache -E .backup -E .vscode -E .DS_Store -E '*.lock')
    local fd_opts=(--type f -I -H ${fd_ignores} -d 4)
    local fzf_opts=(--height=70% --preview='bat -n --color=always --line-range :500 {}')

    if [ -z "$context" ]; then
        # use fd with fzf to select & open a file when no arg are provided

        file="$(fd ${fd_opts} | fzf ${fzf_opts})"
        if [ -n "$file" ]; then
            $EDITOR "$file"
        fi
    else
        # Handle when an context is provided
        lines=($(zoxide query -l "$context" | xargs -I {} fd ${fd_opts} ${query:-.} {} | fzf ${fzf_opts} -0 -1))
        line_count="${#lines[@]}"

        if [ -n "$lines" ] && [ "$line_count" -eq 1 ]; then
            # looks for the exact ones and opens it
            file="$lines"
            $EDITOR "$file"
        else
            echo "No matches found." >&2
            return 1
        fi
    fi
}


# Interactive man page search and viewer using fzf
#
# Usage: fuzzy_man [query...]
#
# Features:
# - Caches man page listings for faster access
# - Automatically regenerates cache after 10 days
# - Searches man pages from sections 1, 5, and 8
# - Opens selected man page in the system man viewer
#
# Examples:
#   fuzzy_man ls        # Search for man pages containing "ls"
#   fuzzy_man git       # Search for git-related man pages
#   fuzzy_man           # Browse all avaie man pages
function fuzzy_man() {
    local queries=${@}
    local cache_file=${XDG_CACHE_HOME}/manlist.dump
    # s,m,h,d
    local update_day_gt="90d"

    local man_file=""
    local section="1"

    # check if update is needed
    local fd_pattern=$(basename "$cache_file")
    local fd_working_dir=$(dirname "$cache_file")
    res=$(fd "${fd_pattern}" "${fd_working_dir}" --newer ${update_day_gt})
    if [[ -z $res ]]; then
        print "cached list too old or missing, regenerating..."
        apropos -s 1:5:8 . | sort | uniq >! ${cache_file} # check man man(1) for section definition
    fi
    # limit the fuzzy query to first field of a line
    raw_candidate=$(fzf -q "${queries}" -d '(\) )' --nth 1 -0 -1 < ${cache_file})
    if [[ "$raw_candidate" =~ '^([a-zA-Z_\-]+)\(([0-9]+)\)[[:space:],]+.*' ]]; then
        man_file=${match[1]}
        section=${match[2]}
        man "$section" "$man_file"
    fi
}

# Fuzzy path finder for zsh line editing
#
# Provides interactive file and directory selection using fd and fzf.
# Integrates with zsh's line editor to insert selected paths into the current command line.
#
# Usage:
#   _my_fuzzy_path_finder [filetype] [depth]
#
# Arguments:
#   filetype - Type of items to find: 'f' for files (default), 'd' for directories
#   depth    - Maximum directory depth to search (default: 3)
#
# Features:
#   - Uses fd for fast file discovery with .git exclusion
#   - Provides fzf interface with syntax highlighting via bat
#   - Automatically detects if user typed a directory path
#   - Supports fuzzy searching across directory structures
#   - Integrates seamlessly with zsh line buffer
#
# Key behavior:
#   - If last argument ends with '/', treats it as directory to search in
#   - Otherwise uses argument as fuzzy search query
#   - Replaces last argument with selected path(s)
#
# Dependencies:
#   - fd: Fast file finder (https://github.com/sharkdp/fd)
#   - fzf: Fuzzy finder (https://github.com/junegunn/fzf)
#   - bat: Syntax highlighter (https://github.com/sharkdp/bat)
#
function _my_fuzzy_path_finder() {
    local filetype="${1:-f}"
    local depth="${2:-3}"
    local last_args=${LBUFFER##* }
    local dir=''
    local query=''
    local fzf_preview_cmd='bat -n --color=always --line-range :500 {}'
    if [[ "$filetype" == "d" ]]; then
      fzf_preview_cmd='ls -F --color=always {}'
    fi
    local fzf_opts=(--height=70% --preview="$fzf_preview_cmd" -1 -0 -m)
    if [[ ${last_args[-1]} == '/' ]]; then
        dir=${last_args/\~/${HOME}}
    else
        query=${last_args}
    fi
    candidates=`fd --type ${filetype} --hidden --follow --exclude .git --color=always --maxdepth=${depth} "" $dir | fzf -q "$query" ${fzf_opts} | xargs`
    if [[ -n "$candidates" ]]; then
        LBUFFER="${LBUFFER% *} $candidates"
    fi
}
zle -N _my_fuzzy_path_finder

# Ctrl-T file finder widget for zsh
#
# Interactive file selection widget triggered by Ctrl-T key binding.
# Opens fuzzy file finder and prepends $EDITOR to selected file for editing.
#
# Usage:
#   Press Ctrl-T in zsh prompt to activate
#
# Behavior:
#   - Opens interactive file finder in current directory tree
#   - If command line is empty, prepends $EDITOR to selected file
#   - If command line has content, just inserts the selected file path
#   - Uses _my_fuzzy_path_finder with file type 'f' and depth 3
#
# Key binding:
#   Ctrl-T (configurable via zsh key bindings)
#
# Integration:
#   - Works with zsh line editor (zle)
#   - Resets prompt after selection
#
function _ctrl_t_file() {
    local cmd=${BUFFER# *}
    zle _my_fuzzy_path_finder -- f 3
    if [[ -z $cmd ]]; then
        LBUFFER="${EDITOR} ${LBUFFER# }"
    fi
    zle reset-prompt
}
zle -N _ctrl_t_file

# Alt-C directory changer widget for zsh
#
# Interactive directory selection widget triggered by Alt-C key binding.
# Opens fuzzy directory finder and changes to selected directory.
#
# Usage:
#   Press Alt-C in zsh prompt to activate
#
# Behavior:
#   - Opens interactive directory finder in current directory tree
#   - If command line is empty, creates 'cd' command with selected directory
#   - If command line has content, just inserts the selected directory path
#   - Uses _my_fuzzy_path_finder with directory type 'd' and depth 3
#
# Key binding:
#   Alt-C (configurable via zsh key bindings)
#
# Integration:
#   - Works with zsh line editor (zle)
#   - Resets prompt after selection
#   - Changes working directory when used with empty command line
#
function _alt_c_dir() {
    local cmd=${BUFFER# *}
    zle _my_fuzzy_path_finder -- d 3
    if [[ -z $cmd ]]; then
        LBUFFER="cd ${LBUFFER# }"
    fi
    zle reset-prompt
}
zle -N _alt_c_dir