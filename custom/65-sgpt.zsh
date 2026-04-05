# Shell-GPT integration ZSH v0.2
[[ -o interactive ]] || return

_sgpt_zsh() {
    local _sgpt_prev_cmd=""
    # Strip leading spaces and # from command line
    local _sgpt_cmd="${BUFFER##[[:space:]#]#}"

    if [[ -n "$_sgpt_cmd" ]]; then
        _sgpt_prev_cmd="$_sgpt_cmd"
        BUFFER+="⌛"
    elif [[ -n "$(command -v gum)" ]]; then
        _sgpt_prev_cmd=$(gum input --placeholder="What can I help you with" --prompt="sgpt> ")
    else
        echo -n "sgpt> "
        read -r _sgpt_prev_cmd
    fi

    # Return if still no prompt
    [[ -z "$_sgpt_prev_cmd" ]] && return

    zle -I && zle redisplay

    local _sgpt_result
    if _sgpt_result=$(sgpt --shell <<< "$_sgpt_prev_cmd" --no-interaction); then
        # Trim whitespace and append original as comment
        BUFFER="${${_sgpt_result## #}%% #}  # $_sgpt_prev_cmd"
    else
        BUFFER="${BUFFER%⌛}  # ERROR: sgpt command failed"
    fi
    zle end-of-line
}
zle -N _sgpt_zsh
bindkey ^o _sgpt_zsh
