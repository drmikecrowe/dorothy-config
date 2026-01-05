#!/usr/bin/env fish

#
# CONFIG: INTERACTIVE FISH
#
# Note: Fish cannot source .sh files - this duplicates interactive.sh config in fish syntax

# Load Dorothy's default fish config
source "$DOROTHY/config/interactive.fish"

# Function to load env files
function load_env_file
    set -l env_file $argv[1]
    if test -f "$env_file"
        for line in (cat "$env_file")
            # Skip empty lines and comments
            if test -n "$line" -a (string sub -l 1 -- "$line") != "#"
                set -l parts (string split -m 1 "=" -- "$line")
                if test (count $parts) -eq 2
                    # Remove surrounding quotes and expand $HOME
                    set -l value (string trim -c '"' -- $parts[2])
                    set -l value (string replace '$HOME' $HOME -- $value)
                    set -gx $parts[1] $value
                end
            end
        end
    end
end

# Load shared environment variables
load_env_file "$DOROTHY/user/config/environment.env"

# Load API keys from 1password.env
load_env_file "$DOROTHY/user/config/1password.env"

# Directory navigation aliases
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# Conditional eza/ls aliases
if command -q eza
    alias l 'eza -l --classify'
    alias ll 'eza --long --header'
    alias l. 'eza --classify -ld .[a-zA-Z]*'
    alias ll. 'eza --classify -ld .[a-zA-Z]*'
else
    alias l 'ls -lF'
    alias ll 'ls -lh'
    alias l. 'ls -d .[a-zA-Z]*'
    alias ll. 'ls -d .[a-zA-Z]*'
end

alias lg lazygit
alias cp cp

# Shell-specific settings (can't be in env file)
set -gx GPG_TTY (tty)

# PATH modifications
fish_add_path --prepend /opt/cuda/bin
fish_add_path --prepend $PNPM_HOME
set -gx LD_LIBRARY_PATH /opt/cuda/lib64 $LD_LIBRARY_PATH

# Source fish-specific integration files
for file in $DOROTHY/user/custom/*.fish
    if test -f "$file"
        source "$file"
    end
end
