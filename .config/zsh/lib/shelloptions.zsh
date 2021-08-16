#!/bin/zsh

                              # General
setopt CORRECT                # Corrent command

                              # History
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

setopt prompt_subst

 # Completions
setopt COMPLETE_IN_WORD       # Complete from both ends of a word.
setopt ALWAYS_TO_END          # Move cursor to the end of a completed word.
setopt PATH_DIRS              # Perform path search even on command names with slashes.
setopt AUTO_MENU              # Show completion menu on a successive tab press.
setopt AUTO_LIST              # Automatically list choices on ambiguous completion.
setopt AUTO_PARAM_SLASH       # If completed parameter is a directory, add a trailing slash.
setopt EXTENDED_GLOB          # Needed for file modification glob modifiers with compinit
unsetopt MENU_COMPLETE        # Do not autoselect the first completion entry.
unsetopt FLOW_CONTROL         # Disable start/stop characters in shell editor.

setopt AUTO_CD 
# Include filenames beginning with a `.` in the results of pathname expansion.
setopt dotglob
