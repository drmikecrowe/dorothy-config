# IntelliShell initialization for Bash
# Load intelli-shell for interactive bash sessions

# Set hotkey customizations (using bash readline format)
export INTELLI_SEARCH_HOTKEY='\C-g'     # Ctrl+G (avoids conflict with launcher)
export INTELLI_VARIABLE_HOTKEY='\C-l'  # Ctrl+L (WARNING: conflicts with clear screen)
export INTELLI_BOOKMARK_HOTKEY='\C-b'  # Ctrl+B
export INTELLI_FIX_HOTKEY='\C-x'       # Ctrl+X
export INTELLI_SKIP_ESC_BIND=0

if command -v intelli-shell >/dev/null 2>&1; then
    eval "$(intelli-shell init bash)"
fi
