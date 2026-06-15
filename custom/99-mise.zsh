# Mise runtime manager for Zsh
if command -v mise > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
    # Write completion to fpath so it survives compinit resets (e.g. from carapace)
    local _mise_comp_dir="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/completions"
    mkdir -p "$_mise_comp_dir"
    if [[ ! -f "$_mise_comp_dir/_mise" ]]; then
        mise completion zsh > "$_mise_comp_dir/_mise"
    fi
    fpath=("$_mise_comp_dir" $fpath)
    compdef _mise mise 2>/dev/null || true
fi