# Atuin command history for Zsh
if command -v atuin > /dev/null 2>&1; then
    if [[ $options[zle] = on ]]; then
        eval "$(atuin init zsh --disable-up-arrow)"
    fi
fi