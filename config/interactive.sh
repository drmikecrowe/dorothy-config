#!/usr/bin/env sh
# use inline `export VAR=...` statements, for fish compatibility`:
# shellcheck disable=SC2034

# load the default configuration
. "$DOROTHY/config/interactive.sh"

# Loaded by `interactive.sh`
# Must be compatible with fish, zsh, bash

# Load env file helper
load_env_file() {
  while IFS='=' read -r key value; do
    # Skip empty lines and comments
    [ -z "$key" ] || [ "${key#\#}" != "$key" ] && continue
    # Remove surrounding quotes from value
    value="${value%\"}"
    value="${value#\"}"
    # Expand $HOME
    value="$(echo "$value" | sed "s|\$HOME|$HOME|g")"
    export "$key=$value"
  done < "$1"
}

# Load shared environment variables
load_env_file ~/.config/dorothy/config/environment.env

# 1password variables
load_env_file ~/.config/dorothy/config.local/1password.env

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Conditional eza/ls aliases (bash/zsh only - see interactive.fish for fish)
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  if command -v eza >/dev/null 2>&1; then
    alias l='eza -l --classify'
    alias ll='eza --long --header'
    alias l.='eza --classify -ld .[a-zA-Z]* --color=tty'
    alias ll.='eza --classify -ld .[a-zA-Z]* --color=tty'
  else
    # Fallback to ls if eza is not found
    alias l='ls -lF'
    alias ll='ls -lh'
    alias l.='ls -d .[a-zA-Z]* --color=tty'
    alias ll.='ls -d .[a-zA-Z]* --color=tty'
  fi
fi

alias lg='lazygit'

# Override Manjaro's interactive cp alias
alias cp='cp'

# GPG_TTY and PATH modifications (bash/zsh only - see interactive.fish for fish)
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  GPG_TTY="$(tty)"
  export GPG_TTY
  export PATH=/opt/cuda/bin:$PATH
  export LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
fi

# pnpm PATH
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
