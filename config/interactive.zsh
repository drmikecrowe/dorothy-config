#!/usr/bin/env zsh
# shellcheck disable=SC2034
# use inline `export VAR=...` statements, for fish compatibility

# Load the default Dorothy zsh configuration
# source "$DOROTHY/config/interactive.zsh"

# Set zsh prompt character for starship
export SHELL_PROMPT_CHAR='z>'

# Load cross-shell `sh` files
source "$DOROTHY/user/config/interactive.sh"

# typeset -U path cdpath fpath manpath

# Source zsh-specific integration files
for f in "$DOROTHY/user/custom/"*.zsh; do
    if [[ -f "$f" ]]; then
        source "$f"
    fi
done
