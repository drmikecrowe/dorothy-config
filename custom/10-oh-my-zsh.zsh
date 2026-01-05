if [[ -d "$HOME/.oh-my-zsh" ]]; then
    export ZSH="$HOME/.oh-my-zsh"
    export DISABLE_UPDATE_PROMPT=false
    # Removed: autoenv (calls brew), aws/azure (may call brew)
    export plugins=(1password aliases docker docker-compose extract gh git-auto-fetch git poetry sudo autoenv zsh-autosuggestions)
    export ZSH_CUSTOM="$HOME/.config/dorothy/oh-my-zsh-custom"

    source "$ZSH/oh-my-zsh.sh"
fi
