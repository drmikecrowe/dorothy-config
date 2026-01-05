#!/usr/bin/env bash
# shellcheck disable=SC2034
# Used by `setup-environment-commands`

# To enable caching (10 minutes validity):
__cache --validity-seconds=600 -- xxhsum || exit

# Add your custom environment variable exports here:
# export MY_VAR="value"
