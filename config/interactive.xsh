#!/usr/bin/env xonsh
# Xonsh interactive configuration

# Source xonsh-specific integration files
import os
import glob

sources_dir = os.path.join($DOROTHY, 'user', 'sources')
for file in glob.glob(os.path.join(sources_dir, '*.xsh')):
    source @(file)
