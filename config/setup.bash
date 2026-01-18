#!/usr/bin/env bash
# Dorothy setup.bash configuration
# Cross-platform tools that work on both Linux (Arch/Manjaro) and macOS
# This is your source of truth for cross-platform CLI tools.
#
# Location: Copy to ~/.local/config/dorothy/config/setup.bash
# Usage: setup-system or individual setup-util-<name> commands

# =============================================================================
# SETUP_UTILS - Cross-platform CLI tools installed via setup-util-*
# =============================================================================
# These tools have Dorothy setup-util commands and work on both Linux and macOS

SETUP_UTILS=(
    # Modern CLI replacements
    bat     # cat replacement
    eza     # ls replacement
    fd      # find replacement
    ripgrep # grep replacement
    sd      # sed replacement
    procs   # ps replacement
    bottom  # htop replacement (btm)
    dust    # du replacement
    delta   # diff replacement

    # Shell enhancements
    starship # prompt
    # carapace    # completions - AUR, managed via pyinfra
    nu     # nushell
    zoxide # cd replacement
    fzf    # fuzzy finder

    # Data tools
    jq # JSON processor

    # Utilities
    tealdeer  # tldr - simplified man pages
    httpie    # curl alternative
    gum       # shell scripting UI
    moreutils # extra unix utils
    mediainfo # media info
    curl      # http client
    wget      # downloader
    aria2     # download accelerator
    rsync     # sync tool

    # Git tools
    gh         # GitHub CLI
    glab       # GitLab CLI
    git        # git itself
    git-lfs    # large file storage
    difftastic # structural diff

    # Development - Languages/Runtimes
    deno   # Deno runtime
    node   # Node.js (via mise or native)
    python # Python (via mise or native)
    go     # Go
    rust   # Rust
    uv     # Fast Python package manager

    # Editors (CLI)
    # neovim      # neovim - managed via pyinfra
    vim # vim

    # Shell
    bash # bash updates
    zsh  # zsh
    fish # fish shell

    # Terminals
    # wezterm     # wezterm terminal - managed via pyinfra

    # Apps (cross-platform)
    obs # OBS Studio

    # Security
    1password     # 1Password
    1password-cli # 1Password CLI (op)
    gpg           # GPG

    # Node global package manager
    pnpm

    # Containers
    docker # Docker

    # Package managers
    flatpak # Flatpak (Linux)

    # Misc
    prettier   # code formatter
    shfmt      # shell formatter
    shellcheck # shell linter
    tree       # directory tree
    trash      # safe rm
    tokei      # code statistics
    vhs        # terminal recorder
    asciinema  # terminal recording
    yt-dlp     # video downloader
)

SETUP_GLOBAL_PNPM_PACKAGES=(
    quicktype
    prettier
    markdownlint-cli2
    json2yaml
    @google/gemini-cli
    @himorishige/hatago-mcp-hub
    json-sort-cli
    opencode-ai
    @vtsls/language-server
    typescript
)

# =============================================================================
# FONTS - Installed via Homebrew fonts (macOS) or setup-util-* (cross-platform)
# =============================================================================
# HOMEBREW_FONTS=(
#     font-fira-code
#     font-fira-code-nerd-font
#     font-inconsolata
#     font-inconsolata-nerd-font
#     font-source-code-pro
#     font-ibm-plex
#     font-ibm-plex-mono
#     font-inter
#     font-roboto
#     font-roboto-mono
# )

# For non-Homebrew systems, add font names to SETUP_UTILS above or run manually:
# setup-util-fira-code
# setup-util-ibm-plex
# setup-util-source-code-pro
# setup-util-nerd-fonts
# setup-util-noto-emoji

# =============================================================================
# FLATPAK apps (Linux only, but defining here for reference)
# =============================================================================
# These are handled by: flatpak install flathub <app-id>
#
FLATPAK_APPS=(
    #     com.jetbrains.IntelliJ-IDEA-Ultimate
    us.zoom.Zoom
    #     com.spotify.Client
    #     io.dbeaver.DBeaverCommunity
    com.getpostman.Postman
    #     com.discordapp.Discord
    #     org.signal.Signal
)

# =============================================================================
# MAS apps (macOS App Store only)
# =============================================================================
# MAS_APPS=(
#     # Add macOS App Store apps here when you get your Mac
# )

# =============================================================================
# HOMEBREW_INSTALL - Additional Homebrew-only packages (primarily macOS)
# =============================================================================
# HOMEBREW_INSTALL=(
#     # macOS-specific tools go here
# )

# =============================================================================
# CARGO_INSTALL - Rust/Cargo packages (cross-platform)
# =============================================================================
# NOTE: These are all available via pacman on Arch, managed in pyinfra instead
# CARGO_INSTALL=(
#     atuin           # shell history sync
#     yazi-fm         # file manager
#     broot           # file browser
#     hexyl           # hex viewer
#     ouch            # compression
#     onefetch        # git repo info
#     stylua          # lua formatter
#     trippy          # traceroute TUI
#     ast-grep        # AST-based search
# )

# =============================================================================
# GO_INSTALL - Go packages (cross-platform)
# =============================================================================
# NOTE: lazygit, glow, rclone available via pacman, managed in pyinfra
# eget not in pacman/AUR - install manually if needed: go install github.com/zyedidia/eget@latest
# GO_INSTALL=(
# )

# =============================================================================
# UV_INSTALL - Python tools via uv (cross-platform)
# =============================================================================
UV_INSTALL=(
    ruff # Python linter/formatter
)

# =============================================================================
# AUR_INSTALL - Arch Linux specific packages
# =============================================================================
# Only used on Arch/Manjaro, ignored on macOS
AUR_INSTALL=(
    # Data tools
    jless # JSON viewer
    go-yq # YAML processor
    xq    # XML processor
    htmlq # HTML processor

    # CLI tools
    gping      # ping with graph
    prettyping # prettier ping
    bmon       # bandwidth monitor
    dua-cli    # disk usage

    # Utilities
    rich-cli # rich text CLI
    neofetch # system info
    inxi     # system info
    sysz     # systemctl TUI
    rnr      # bulk rename
    jwt-cli  # JWT tool
    toml-cli # TOML processor

    # File tools
    mc     # midnight commander
    fdupes # duplicate finder
    rdfind # duplicate finder
    atool  # archive tool

    # Dev tools
    d2 # diagram tool
    markdownlint-cli2

    # Low-level
    evtest     # input testing
    ydotool    # automation
    ueberzugpp # image preview
)

# =============================================================================
# FLATPAK_INSTALL - Flatpak apps (Linux)
# =============================================================================
FLATPAK_INSTALL=(
    us.zoom.Zoom
    com.getpostman.Postman
    # com.jetbrains.IntelliJ-IDEA-Ultimate
    # com.spotify.Client
    # io.dbeaver.DBeaverCommunity
    # com.discordapp.Discord
)

# =============================================================================
# NODE/PYTHON default packages (handled by mise, but listing for reference)
# =============================================================================
# See: ~/.default-node-packages and ~/.default-python-packages
# Or configure via mise's tool-versions
