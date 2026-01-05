#!/usr/bin/env nu

overlay new user-config

use std *
use std/dirs shells-aliases *

source ~/.local/share/dorothy/sources/config.nu
source ~/.local/share/dorothy/state/carapace.nu
source ~/.local/share/dorothy/state/starship.nu


source ../custom/05-shell-prompt.nu
source ../custom/50-yazi.nu
source ../custom/60-zoxide.nu
source ../custom/65-sgpt.nu
source ../custom/90-atuin.nu
source ../custom/95-1password-helper.nu
source ../custom/99-mise.nu


# Config
$env.config.completions.algorithm = 'fuzzy'
$env.config.cursor_shape.emacs = 'line'
$env.config.datetime_format.table = '%F %T %z' # '2024-06-07 18:15:59 -0400'
$env.config.filesize.precision = 4
$env.config.filesize.unit = 'metric'

# Config
$env.config.completions.algorithm = 'fuzzy'
$env.config.cursor_shape.emacs = 'line'
$env.config.datetime_format.table = '%F %T %z' # '2024-06-07 18:15:59 -0400'
$env.config.filesize.precision = 4
$env.config.filesize.unit = 'metric'
$env.config.float_precision = 4
$env.config.footer_mode = 'always'
$env.config.highlight_resolved_externals = true
$env.config.history.file_format = 'sqlite'
$env.config.history.sync_on_enter = false
$env.config.hooks.display_output = { table }
$env.config.rm.always_trash = true
$env.config.show_banner = false
$env.config.table.mode = 'thin'

# Shell-specific environment variables
$env.SHELL_PROMPT_CHAR = 'nu>'

# Paths
$env.PATH = (
    $env.PATH
        | split row :
        | where { path exists }
        | path expand --no-symlink
        | path parse
        | path join
        | uniq # Remove duplicates
)

# Load env files
def parse-dotenv [path: path] {
    open $path
        | lines
        | where { ($in | str trim) != "" }  # Skip empty lines
        | where { not ($in | str starts-with "#") }  # Skip comments
        | split column "=" name value
        | update value { |row| $row.value | str replace '$HOME' $env.HOME }  # Expand $HOME
        | update value { str trim -c '"' }
        | transpose -r -d  # convert table to record
}

# Load shared environment variables
parse-dotenv ~/.config/dorothy/config/environment.env | load-env

# Load 1password variables
parse-dotenv ~/.config/dorothy/config.local/1password.env | load-env

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

# https://github.com/jondpenton/dotfiles/blob/main/commands/clip.nu
# overlay use ../commands as user-commands
overlay new session
