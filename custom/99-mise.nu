# Mise runtime manager for Nushell
if (which mise | is-not-empty) {
    ^mise activate nu | save ~/.config/nushell/mise.nu --force
}
use ~/.config/nushell/mise.nu
