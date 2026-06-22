# Atuin command history for Zsh
# Dorothy's interactive loader already guarantees an interactive shell before
# sourcing this, so the ZLE option check is redundant and would skip Atuin in
# contexts (SSH/tmux init) where ZLE reports off too early.
if command -v atuin > /dev/null 2>&1; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi