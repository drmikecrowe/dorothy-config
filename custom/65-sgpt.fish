# Shell-GPT integration Fish v0.2
status is-interactive || exit

function _sgpt_fish
    set -l prev_cmd ""
    # Get current command line, stripping leading spaces and #
    set -l cmd (commandline | string replace -r '^[ #]+' '')

    if test -n "$cmd"
        set prev_cmd $cmd
        commandline -a "⌛"
        commandline -f end-of-line
    else if command -q gum
        set prev_cmd (gum input --placeholder="What can I help you with" --prompt="sgpt> ")
    else
        read -P "sgpt> " prev_cmd
    end

    # Return if still no prompt
    if test -z "$prev_cmd"
        return
    end

    set -l result (echo "$prev_cmd" | sgpt --role fish_generator --shell --no-interaction)

    if test $status -eq 0
        commandline -r -- (string trim "$result")
        commandline -a "  # $prev_cmd"
    else
        commandline -f backward-delete-char
        commandline -a "  # ERROR: sgpt command failed"
    end
    commandline -f end-of-line
end

bind \co _sgpt_fish
