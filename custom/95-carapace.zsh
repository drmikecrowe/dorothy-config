# Carapace completions for Zsh
if command -v carapace > /dev/null 2>&1; then
    zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
    source <(carapace _carapace zsh)
fi
