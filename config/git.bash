#!/usr/bin/env bash
# do not use `export` keyword in this file:
# shellcheck disable=SC2034

# Used by `setup-git`.
#
# Without this file `setup-git` re-prompted for every field on every
# `setup-system install`. It only skips the prompts when GIT_NAME, GIT_EMAIL and
# GIT_DEFAULT_BRANCH are all set, GIT_PROTOCOL is one of ssh/https, and
# MERGE_TOOL is one of the merge tools it detects as installed (meld, delta,
# opendiff, diff). Every value below was already present in `git config
# --global`; it was only Dorothy's copy of them that was missing.
#
# `setup-git --reconfigure` writes its answers to `config.local/git.bash`, which
# takes precedence over this file. That path is run through the strongbox clean
# filter, so prefer editing this file for anything that is not a credential.

GIT_NAME='Mike Crowe'
GIT_EMAIL='drmikecrowe@gmail.com'
GIT_DEFAULT_BRANCH='main'
GIT_PROTOCOL='https'
GITHUB_USERNAME='drmikecrowe'
GITLAB_USERNAME='drmikecrowe'
MERGE_TOOL='delta'

# no commit signing is configured on this machine; leave empty so `setup-git`
# does not try to wire up an agent
GPG_SIGNING_KEY=''
GPG_SIGNING_AGENT=''
