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
    # carapace    # completions - AUR, managed via setup-arch-packages
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
    # neovim      # neovim - managed via setup-arch-packages
    vim # vim

    # Shell
    bash # bash updates
    zsh  # zsh
    fish # fish shell

    # Terminals
    # wezterm     # wezterm terminal - managed via setup-arch-packages

    # Apps (cross-platform)
    obs # OBS Studio

    # Security
    1password     # 1Password
    1password-cli # 1Password CLI (op)
    gpg           # GPG

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

SETUP_GLOBAL_NPM_PACKAGES=(
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
    playwriter
    csv2json
    git-stack
    context-mode
    @socketsecurity/cli
    snyk
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
# NOTE: These are all available via pacman on Arch, managed in ARCH_* / setup-arch-packages instead
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
# NOTE: lazygit, glow, rclone available via pacman, managed in ARCH_* / setup-arch-packages
# eget not in pacman/AUR - install manually if needed: go install github.com/zyedidia/eget@latest
# GO_INSTALL=(
# )

# =============================================================================
# UV_INSTALL - Python tools via uv (cross-platform)
# =============================================================================
UV_INSTALL=(
    ruff                         # Python linter/formatter
    basedpyright                 # Python type checker
    claude-conversation-extractor
    compact-json                 # JSON formatter
    copier                       # project templating
    shell-gpt                    # ChatGPT/LLM shell assistant
    # serena-agent               # git install: uvx --from git+https://github.com/oraios/serena
    # shell-sage                 # custom install
)

# =============================================================================
# AUR_INSTALL - Arch Linux specific packages
# =============================================================================
# Only used on Arch/Manjaro, ignored on macOS
AUR_INSTALL=(
    # Data tools
    jless  # JSON viewer
    go-yq  # YAML processor
    xq     # XML processor
    htmlq  # HTML processor

    # CLI tools
    gping      # ping with graph
    prettyping # prettier ping
    bmon       # bandwidth monitor
    dua-cli    # disk usage
    duf        # df replacement
    glances    # system monitor (htop alternative)
    trippy     # traceroute TUI

    # Utilities
    rich-cli        # rich text CLI
    neofetch        # system info
    inxi            # system info
    sysz            # systemctl TUI
    jwt-cli         # JWT tool
    taplo-cli       # TOML toolkit (binary: taplo)
    rclone          # cloud sync
    ngrok           # tunnel
    topgrade        # system-wide upgrader
    speedtest-go-bin

    # Shell
    tmux   # terminal multiplexer
    atuin  # shell history sync

    # File tools
    mc         # midnight commander
    fdupes     # duplicate finder
    rdfind     # duplicate finder
    atool      # archive tool
    ouch       # modern archive tool
    hexyl      # hex viewer
    broot      # interactive file browser
    yazi       # terminal file manager

    # Dev tools
    ast-grep               # AST-based search/rewrite
    d2                     # diagram tool
    markdownlint-cli2
    lazygit                # git TUI
    goreleaser             # Go release tool
    rustscan               # fast port scanner
    onefetch               # git repo overview
    stylua                 # lua formatter
    typescript-language-server

    # Dotfiles
    chezmoi # dotfiles manager

    # IaC
    pulumi

    # Low-level
    evtest     # input testing
    ydotool    # automation
    ueberzugpp # image preview

    # Media/misc
    glow # markdown viewer (terminal)
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
# ARCH_* - pacman/AUR packages, consumed by `setup-arch-packages`
# =============================================================================
# Migrated from the pyinfra bootstrap on 2026-09-02. Anything Dorothy already
# installs via SETUP_UTILS or setup-cli-tools was dropped rather than moved --
# a package belongs in exactly one place.
#
# Before adding here, check in order: `mise registry`, SETUP_UTILS,
# commands/setup-cli-tools. This array is the last resort, for things that must
# be a native system package.

# Hardware, filesystems, networking and pacman tooling.
ARCH_SYSTEM=(
    acpi
    cronie
    cpupower
    dmidecode
    fwupd
    hdparm
    hwinfo
    libva-utils
    ntp
    numlockx
    powertop
    smartmontools
    sof-firmware
    solaar
    upower
    btrfs-progs
    cryptsetup
    dosfstools
    exfatprogs
    lvm2
    mdadm
    nfs-utils
    ntfs-3g
    xfsprogs
    bind
    dnsmasq
    ethtool
    inetutils
    net-tools
    networkmanager
    networkmanager-openconnect
    networkmanager-openvpn
    nss-mdns
    openssh
    tailscale
    wireless-regdb
    firewalld
    gnome-keyring
    yubikey-manager
    yubikey-personalization-gui
    downgrade
    pacman-contrib
    pkgfile
    rebuild-detector
    reflector
    libxcrypt-compat
    lib32-libcanberra
    lib32-mesa-utils
)

# Command-line tools that must be system packages.
# wireshark needs the wireshark group and a setuid helper, so it cannot be a mise tool.
ARCH_CLI=(
    bash-completion
    plocate
    unrar
    unzip
    man-db
    man-pages
    zsync
    colorized-logs
    sloccount
    arp-scan
    dsniff
    nmap
    tcpdump
    termshark
    wireshark-cli
    wireshark-qt
    wtype
    nano
)

# Cloud and API tooling. Check `mise registry` before adding here.
ARCH_DEV=(
    python-pip
    python-pipx
    docparser
    playwright
    azure-cli
    azure-functions-core-tools-bin
    google-cloud-cli
    wrangler
    aws-sso-cli-bin
)

# GUI applications. Portable across desktop environments.
ARCH_APPS=(
    zen-browser-bin
    google-chrome
    wezterm
    ghostty
    ghostty-terminfo
    ghostty-shell-integration
    waveterm-bin
    betterbird-bin
    discord
    element-desktop
    wavebox
    whatsapp-linux-desktop-bin
    libreoffice-fresh
    obsidian
    anki
    zathura
    zathura-pdf-mupdf
    wps-office
    wps-office-fonts
    prince-bin
    md-viewer-bin
    qmd
    vlc
    handbrake
    handbrake-cli
    avidemux-qt
    peek
    vokoscreen
    kodi
    gimp
    filebot
    bcompare
    visual-studio-code-bin
    yaak-beta-bin
    zed-preview-bin
    ulauncher
    copyq
    flameshot
    dex
    adobe-source-sans-fonts
    terminus-font
    ttf-firacode-nerd
    ttf-inconsolata
    ttf-indic-otf
    x2goclient
    sqlitebrowser
    archivemount
    claude-desktop-bin
    duplicati-beta-bin
    etckeeper
    dwarfs-bin
    gearlever
    glogg
    onedrive-abraunegg
    gifsicle
    swftools
    trakt-cli-bin
    voxtype-bin
    way-displays
    antigravity
)

# Virtual machines and containers.
# Dorothy's SETUP_UTILS also installs docker, and Omarchy ships it. Pick one.
ARCH_VIRT=(
    virt-manager
    virt-viewer
    guestfs-tools
    fuse-overlayfs
    nvidia-container-toolkit
)

# GTX 1050 Mobile (Pascal, GP107M). Installed by setup-driver-nvidia.
ARCH_GPU_NVIDIA=(
    nvidia-580xx-dkms
    nvidia-580xx-utils
    lib32-nvidia-580xx-utils
)

# Not installed by default. `setup-arch-packages optional` installs these.
ARCH_OPTIONAL=(
    onvif-gui
    onvif-util
)


# =============================================================================
# ARCH_DESKTOP_* - one profile is installed, chosen by DESKTOP_PROFILE
# =============================================================================
# setup-arch-packages auto-detects from $XDG_CURRENT_DESKTOP when unset.

# Omarchy owns Hyprland. These are the gaps it leaves.
ARCH_DESKTOP_HYPRLAND=(
    gtk4-layer-shell
    way-displays
    libinput-tools
    wl-clipboard
)

# COSMIC desktop (EndeavourOS).
ARCH_DESKTOP_COSMIC=(
    cosmic-session
    cosmic-comp
    cosmic-greeter
    cosmic-settings
    cosmic-settings-daemon
    cosmic-panel
    cosmic-applets
    cosmic-app-library
    cosmic-launcher
    cosmic-files
    cosmic-terminal
    cosmic-text-editor
    cosmic-player
    cosmic-screenshot
    cosmic-notifications
    cosmic-osd
    cosmic-bg
    cosmic-idle
    cosmic-randr
    cosmic-monitor
    cosmic-workspaces
    cosmic-store
    cosmic-initial-setup
    cosmic-icon-theme
    cosmic-wallpapers
    xdg-desktop-portal-cosmic
)

# KDE Plasma. Omarchy's installer aborts if plasma-desktop is explicit.
ARCH_DESKTOP_PLASMA=(
    plasma-desktop
    plasma-workspace
    plasma-nm
    plasma-pa
    plasma-systemmonitor
    plasma-disks
    plasma-keyboard
    plasma-browser-integration
    plasma-x11-session
    kdeplasma-addons
    powerdevil
    bluedevil
    kscreen
    kinfocenter
    kgamma
    kwallet-pam
    kwayland-integration
    kde-cli-tools
    kde-gtk-config
    breeze-gtk
    sddm-kcm
    xdg-desktop-portal-kde
    ark
    dolphin
    dolphin-plugins
    kate
    kcalc
    kdeconnect
    kdegraphics-thumbnailers
    kdenetwork-filesharing
    kimageformats
    kio-admin
    kio-extras
    kio-fuse
    konsole
    gwenview
    okular
    haruna
    spectacle
    partitionmanager
    print-manager
    ffmpegthumbs
    qt6-imageformats
)

# =============================================================================
# NODE/PYTHON default packages (handled by mise, but listing for reference)
# =============================================================================
# See: ~/.default-node-packages and ~/.default-python-packages
# Or configure via mise's tool-versions
