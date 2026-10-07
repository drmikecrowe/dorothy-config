# Atuin command history for Zsh
# Dorothy's interactive loader already guarantees an interactive shell before
# sourcing this, so the ZLE option check is redundant and would skip Atuin in
# contexts (SSH/tmux init) where ZLE reports off too early.
#
# Atuin owns the up-arrow deliberately. It used to be initialised with
# --disable-up-arrow so up-arrow stayed native zsh prefix search, but native
# search only sees ~/.zsh_history while the real history -- years of it, synced
# across machines -- lives in Atuin's database. That left up-arrow searching a
# nearly empty file while Ctrl-R found everything. Up-arrow is scoped to prefix
# matching via search_mode_shell_up_key_binding in ~/.config/atuin/config.toml,
# so typing a prefix and pressing up filters to commands starting with it, while
# Ctrl-R stays fuzzy over the same database.
if command -v atuin > /dev/null 2>&1; then
    eval "$(atuin init zsh)"
fi