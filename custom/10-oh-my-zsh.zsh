if [[ -d "$HOME/.oh-my-zsh" ]]; then
    _dorothy_custom_dir="$HOME/.config/dorothy"
    if [[ -z "$(ls -A "$_dorothy_custom_dir/oh-my-zsh-custom/plugins/synu" 2>/dev/null)" ]]; then
        git -C "$_dorothy_custom_dir" submodule update --init --recursive
    fi
    unset _dorothy_custom_dir

    export ZSH="$HOME/.oh-my-zsh"
    export DISABLE_UPDATE_PROMPT=false
    # Removed: autoenv (calls brew), aws/azure (may call brew)
    export plugins=(1password aliases docker docker-compose extract gh git-auto-fetch git poetry sudo autoenv zsh-autosuggestions)
    export ZSH_CUSTOM="$HOME/.config/dorothy/oh-my-zsh-custom"

    source "$ZSH/oh-my-zsh.sh"
    unalias gsd
fi
