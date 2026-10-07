# Persistent zsh history + prefix matching.
#
# Loaded after 10-oh-my-zsh.zsh on purpose. oh-my-zsh's lib/history.zsh sets
# HISTFILE, but when oh-my-zsh was missing from this machine nothing did, so
# HISTFILE was empty and HISTSIZE was zsh's default 30 -- no history survived a
# shell exit, which is also why prefix matching had nothing to match. Setting it
# here means history does not depend on oh-my-zsh being present.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

setopt INC_APPEND_HISTORY    # write as you go, not just at exit
setopt SHARE_HISTORY         # share between concurrent shells
setopt EXTENDED_HISTORY      # record timestamps
setopt HIST_IGNORE_ALL_DUPS  # keep only the most recent copy of a command
setopt HIST_IGNORE_SPACE     # leading space keeps it out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY           # expand rather than run immediately

# Arrow keys are deliberately NOT bound here. Atuin owns the up-arrow (see
# 90-atuin.zsh, which loads after this file); native zsh prefix search would only
# see this file's ~/.zsh_history, whereas the full synced history is in Atuin's
# database. Keeping HISTFILE set still matters though -- zsh-autosuggestions
# reads zsh's own history for its inline ghost-text suggestions.
