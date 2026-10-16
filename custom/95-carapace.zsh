# Carapace completions for Zsh
if command -v carapace > /dev/null 2>&1; then
    export CARAPACE_EXCLUDES=mise
    if is-system --macos; then
        # Exclude commands with better native zsh completions so carapace doesn't stomp them
        export CARAPACE_EXCLUDES="brew git npm yarn pnpm docker kubectl helm aws gcloud az cargo rustup go python pip uv ssh scp curl wget tar zip unzip mise"
    fi
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace zsh)
fi
