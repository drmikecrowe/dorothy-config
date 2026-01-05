# Shell-GPT integration BASH v0.2
[[ $- == *i* ]] || return

_sgpt_bash() {
    local _sgpt_prev_cmd=""
    # Strip leading spaces and # from command line
    local _sgpt_cmd="${READLINE_LINE#"${READLINE_LINE%%[![:space:]#]*}"}"

    if [[ -n "$_sgpt_cmd" ]]; then
        _sgpt_prev_cmd="$_sgpt_cmd"
        READLINE_LINE+="⌛"
    elif [[ -n "$(command -v gum)" ]]; then
        _sgpt_prev_cmd=$(gum input --placeholder="What can I help you with" --prompt="sgpt> ")
    else
        echo -n "sgpt> "
        read -r _sgpt_prev_cmd
    fi

    # Return if still no prompt
    [[ -z "$_sgpt_prev_cmd" ]] && return

    local _sgpt_result
    if _sgpt_result=$(sgpt --shell --no-interaction <<<"$_sgpt_prev_cmd"); then
        # Trim whitespace and append original as comment
        _sgpt_result="${_sgpt_result#"${_sgpt_result%%[![:space:]]*}"}"
        _sgpt_result="${_sgpt_result%"${_sgpt_result##*[![:space:]]}"}"
        READLINE_LINE="$_sgpt_result  # $_sgpt_prev_cmd"
    else
        READLINE_LINE="${READLINE_LINE%⌛}  # ERROR: sgpt command failed"
    fi
    READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\C-o": _sgpt_bash'
