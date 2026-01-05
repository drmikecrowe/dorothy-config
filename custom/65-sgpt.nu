# Shell-GPT integration Nushell v0.1
# Add this to your config.nu

# Define the sgpt command handler
def --env shell-gpt [] {
    # Get current command line, strip leading spaces and #
    let current = (commandline | str trim --left --char ' ' | str trim --left --char '#')

    let prompt = if ($current | is-not-empty) {
        # Show loading indicator
        commandline edit --append "⌛"
        $current
    } else if (which gum | is-not-empty) {
        # Use gum for interactive input if available
        ^gum input --placeholder="What can I help you with" --prompt="sgpt> "
    } else {
        # Fall back to basic input
        input "sgpt> "
    }

    # Return if still no prompt
    if ($prompt | is-empty) {
        commandline edit --replace ""
        return
    }

    # Call sgpt and handle result
    let result = try {
        $prompt | ^sgpt --role nushell_generator --shell --no-interaction | str trim
    } catch {
        null
    }

    if ($result != null) {
        commandline edit --replace $"($result)  # ($prompt)"
    } else {
        let cleaned = (commandline | str replace "⌛" "")
        commandline edit --replace $"($cleaned)  # ERROR: sgpt command failed"
    }
}

# Add keybinding for Ctrl+O
# Merge this into your existing $env.config.keybindings
$env.config.keybindings = ($env.config.keybindings | append {
    name: sgpt_shell
    modifier: control
    keycode: char_o
    mode: [emacs vi_normal vi_insert]
    event: {
        send: executehostcommand
        cmd: "shell-gpt"
    }
})
