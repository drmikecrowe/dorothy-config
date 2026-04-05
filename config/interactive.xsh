#!/usr/bin/env xonsh
# Xonsh interactive configuration

from xonsh.platform import ON_LINUX, ON_DARWIN
from pathlib import Path
import os
import glob

# Shell settings
$XONSH_SHOW_TRACEBACK = False
$AUTO_CD = True
$PUSHD_SILENT = True
$DIRENV_HIDE_DIFF = 1
$SHELL = "xonsh"
$STARSHIP_SHELL = "xonsh"
$STARSHIP_CONFIG = '~/.config/starship_xonsh.toml'
${...}['zoxide_pick_dir'] = 'c-g'
$COMPLETIONS_DISPLAY = "multi"
$COMPLETION_MODE = "menu-complete"

$EDITOR = 'nvim'
$MANPAGER = "nvim +Man!"

# xontrib configuration
$XONTRIB_CLP_ALIAS = 'shutil'

# Load xontribs
_xontribs = [
    "1password",
    "autovox",
    "autoxsh",
    "chatgpt",
    "clp",
    "coreutils",
    "dir-picker",
    "dotdot",
    "gitinfo",
    "pipeliner",
    "pm",
    "prompt_starship",
    "sh",
    "term_integration",
    "vox",
    "zoxide",
]
xontrib load @(_xontribs)

# 1Password setup - Convert sourced env vars to OnePass objects
for key, value in ${...}.items():
    if isinstance(value, str) and value.startswith('op://'):
        ${...}[key] = OnePass(value)

# Source xsh-specific integration files from custom/
custom_dir = os.path.join($DOROTHY, 'user', 'custom')
for file in sorted(glob.glob(os.path.join(custom_dir, '*.xsh'))):
    source @(file)
