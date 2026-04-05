#!/usr/bin/env bash
# shellcheck disable=SC2034,SC1091
# use inline `export VAR=...` statements, for fish compatibility

set -o vi
shopt -s checkwinsize
shopt -s extglob
shopt -s globstar
shopt -s checkjobs

# Load cross-shell `sh` files
source "$DOROTHY/user/config/interactive.sh"

# Source bash-specific integration files
for f in "$DOROTHY/user/custom/"*.bash; do
    if [[ -f "$f" ]]; then
        source "$f"
    fi
done
