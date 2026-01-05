# Atuin command history for Bash
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    if command -v atuin > /dev/null 2>&1; then
        eval "$(atuin init bash --disable-up-arrow)"
    fi
fi
