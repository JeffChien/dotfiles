# aicmd - Interactive AI command composition with model selection
#
# Opens your preferred editor ($EDITOR) to compose a natural language request,
# then sends it to aichat for AI-assisted command generation. Supports interactive
# model selection via fzf for choosing alternative AI models on-the-fly.
#
# Usage:
#   aicmd
#
# Workflow:
#   1. Creates secure temporary file in $XDG_CACHE_HOME (or /tmp) with 'aichat' prefix
#   2. Interactively selects AI model via fzf from available aichat models (optional)
#   3. Opens $EDITOR with the temporary file for composing your request
#   4. On successful editor exit with non-empty content:
#      - Sends content to aichat with execution mode (-e) and file input (-f)
#      - Uses selected model if chosen, otherwise uses default
#   5. Automatically cleans up temporary file via trap mechanism
#
# Exit Codes:
#   0 - Success (AI command generated and displayed)
#   1 - Failed to create temporary file
#   Editor exit code - Propagated if editor exits with error
#   aichat exit code - Propagated if AI processing fails
#
# Environment Variables:
#   $EDITOR - Editor command to use (required, falls back to system default)
#   $XDG_CACHE_HOME - Base directory for temporary files (fallback: /tmp)
#
# Dependencies:
#   - aichat: AI CLI tool for command generation
#   - fzf: Fuzzy finder for model selection (optional but recommended)
#
# Examples:
#   $ aicmd
#   # Opens editor, type: "find large files over 100MB"
#   # AI suggests: find / -type f -size +100M -exec ls -lh {} \;
#
#   $ aicmd
#   # Select 'gpt-4' from fzf menu when prompted
#   # Type: "create tar archive of current directory"
#   # AI suggests: tar -czf archive.tar.gz .
#
# Notes:
#   - Empty files (user saves without content) gracefully abort without processing
#   - Model selection is optional; press ESC or Ctrl-C to skip and use default
#   - All temporary files are securely cleaned up even on interrupt/termination
#   - Requires both 'aichat' and 'fzf' commands to be installed and in PATH
function aicmd() {
    local exit_code=0
    if ! temp_file=$(mktemp -p $XDG_CACHE_HOME -t aichat); then
        echo "Failed to create temp file" >&2
        return 1
    fi

    local aichat_opts=(-e -f "$temp_file")
    local model=$(aichat --list-models | fzf -1 -0)
    if [[ -n "$model" ]]; then
        echo "using alternative model: $model"
        aichat_opts+=(-m "$model")
    fi

    cleanup() {
        # echo "delete temp file $temp_file"
        rm -f -- "$temp_file"
    }

    trap 'cleanup' EXIT INT TERM

    ${EDITOR} "$temp_file"
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        return $exit_code
    fi

    if [[ ! -s $temp_file ]]; then
        # user abort
        return $exit_code
    fi

    aichat ${aichat_opts}
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "cmd fail" >&2
        return $exit_code
    fi
    return $exit_code
}