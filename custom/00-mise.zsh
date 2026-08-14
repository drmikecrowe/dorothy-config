# Mise runtime manager for Zsh
if command -v mise > /dev/null 2>&1; then
    eval "$(mise activate zsh)"
    # Write completion to fpath so it survives compinit resets (e.g. from carapace)
    local _mise_comp_dir="${ZSH_CACHE_DIR:-$HOME/.cache/zsh}/completions"
    local _mise_comp_stamp="$_mise_comp_dir/.mise-version"
    local _mise_version="${${(z)$(mise --version)}[1]}"
    mkdir -p "$_mise_comp_dir"
    # Regenerate when mise is upgraded, else a stale _mise breaks `mise run <tab>`
    if [[ ! -f "$_mise_comp_dir/_mise" || "$(cat "$_mise_comp_stamp" 2>/dev/null)" != "$_mise_version" ]]; then
        mise completion zsh > "$_mise_comp_dir/_mise" && print -r -- "$_mise_version" > "$_mise_comp_stamp"
    fi
    fpath=("$_mise_comp_dir" $fpath)
    compdef _mise mise 2>/dev/null || true
fi