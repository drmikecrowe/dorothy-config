#!/usr/bin/env bash
set -e
set -x

if [ "$1" == "" ]; then
    echo "Usage: $0 appname (no .desktop)"
    exit 1
fi
desktop-file-install --dir=$HOME/.local/share/applications $HOME/.local/share/applications/$1.desktop

update-desktop-database ~/.local/share/applications
