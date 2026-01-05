# Atuin for Fish
if test "$TERM_PROGRAM" != "vscode"
    if command -v atuin > /dev/null 2>&1
        atuin init fish --disable-up-arrow | source
    end
end
