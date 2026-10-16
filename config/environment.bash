#!/usr/bin/env bash
# shellcheck disable=SC2034
# Used by `setup-environment-commands`

# To enable caching (10 minutes validity):
# `$DOROTHY/state` is a symlink to this directory, and `__cache` fails if it is missing
mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/dorothy"
__cache --validity-seconds=1800 || exit

# Add your custom environment variable exports here:
# export MY_VAR="value"
