# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# The first argument to the function ($1) is the base path to start traversal
# See the source code (completion.{bash,zsh}) for the details.

export FZF_DEFAULT_COMMAND='fd . --hidden --follow --exclude ".git" -E "**cache/**" -E "**/node_modules/**" --ignore-file "$HOME/.gitignore"' 
#export FZF_DEFAULT_COMMAND="fd -t f -i -E '**/.git/**' -E '**cache/**' -E '**/node_modules/**'"

local color00='#282828'
local color01='#3c3836'
local color02='#504945'
local color03='#665c54'
local color04='#bdae93'
local color05='#d5c4a1'
local color06='#ebdbb2'
local color07='#fbf1c7'
local color08='#fb4934'
local color09='#fe8019'
local color0A='#fabd2f'
local color0B='#b8bb26'
local color0C='#8ec07c'
local color0D='#83a598'
local color0E='#d3869b'
local color0F='#d65d0e'

export FZF_DEFAULT_OPTS="
--color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
--color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
--color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
--prompt 'λ All-> '
--bind 'ctrl-d:change-prompt(Directories> )+reload(fd . --type d --hidden --follow --ignore-file "$HOME/.gitignore" --exclude ".git")'
--bind 'ctrl-f:change-prompt(Files> )+reload(fd . --type f --hidden --follow --ignore-file "$HOME/.gitignore" --exclude ".git")'
--bind 'ctrl-v:execute(geany {+})'
--bind '?:toggle-preview'
--header 'CTRL-D: Directories / CTRL-F: Files ' 
--height=60%
--min-height=60
--layout=default
--border
--info=inline
--multi
--cycle
--pointer='|>'
--marker='✓'
--preview-window right:60%:hidden  
--preview '($FZF_PREVIEW_COMMAND)'
"
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap character --color always {} || cat {} || exa --oneline --long --header --color=always --icons --group-directories-first {} || tree -C {}"


#--preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) || ([[ -d {} ]] && (exa --oneline --long --header --color=always --icons --group-directories-first {}')) || echo {} 2> /dev/null | head -200'
#--preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) || ([[ -d {} ]] && (ls -1 -l  --color=always  --group-directories-first {}')) || echo {} 2> /dev/null | head -200'
#--color=bg+:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934

#--preview '([[ -f {} ]] && (bat --style=numbers --color=always --theme=gruvbox-dark --line-range :500 {} || cat {})) || ([[ -d {} ]] && (exa --oneline --long --header --color=always --icons --group-directories-first {}')) || echo {} 2> /dev/null | head -200'

#--preview-window=right:50%
#--preview-window=wrap:right:40%

#--preview='bat --style=numbers --color=always --line-range :250 {} 2>/dev/null ||
#	exa --oneline --long --header --color=always --icons --sort=Filename --group-directories-first {}'
#--color=bg+:#32302f,spinner:#fb4934,hl:#928374,fg:#ebdbb2,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,fg+:#ebdbb2,prompt:#fb4934,hl+:#fb4934
#/ CTRL-F: Files / CTRL-E: Open file with $EDITOR / CTRL-V: Open file with Geany'
#--header 'CTRL-E: Open file with $EDITOR' --header-lines=2 \
#--header 'CTRL-V: Open file with Geany' --header-lines=3

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_CTRL_T_OPTS="--min-height 30 --preview-window right:50%:hidden  --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"

export FZF_ALT_C_COMMAND='fd . --hidden --follow --ignore-file "$HOME/.gitignore" --exclude ".git"' 
export FZF_ALT_C_OPTS="--preview 'exa --tree --icons {} | head -500'"

export FZF_CTRL_R_OPTS="
--preview-window hidden
--exact
--prompt='> ' --pointer='▶' --marker='✓'
--ansi
--height 80% 
--layout=reverse 
--inline-info 
--border
--bind 'ctrl-y:execute-silent(echo -n {2..} | $COPY_CMD)+abort,tab:accept'
--bind 'ctrl-p:toggle-preview'
--header 'C-y=yank, C-p=preview'
"
# Uses darcula theme from fzf color schemes wiki.
#export FZF_DEFAULT_OPTS='
#  --bind ctrl-j:down
#  --bind ctrl-k:up
#  --bind ctrl-u:page-up
# --bind ctrl-d:page-down

#  --bind alt-u:preview-page-up
#  --bind alt-d:preview-page-down
#  --bind ctrl-n:preview-down
#  --bind ctrl-p:preview-up
#  --bind ctrl-i:toggle-preview
#  --bind alt-i:toggle-preview

#  --bind shift-left:backward-word
#  --bind shift-right:forward-word
#  --bind ctrl-b:backward-word
#  --bind ctrl-f:forward-word
#  --bind ctrl-h:backward-char
#  --bind ctrl-l:forward-char

#  --bind alt-return:print-query
#  --bind alt-bspace:clear-query

#  --bind alt-j:accept
#  --bind alt-k:accept-non-empty
#  --bind alt-q:jump
#  --bind ctrl-q:jump-accept

#  --bind alt-a:select-all
#  --bind alt-x:deselect-all

#  --bind "ctrl-y:execute-silent(echo {} | clip)"

#  --bind ctrl-s:toggle-search

#  --bind ctrl-space:toggle+down
#  --bind ctrl-o:top

#  --history '"$XDG_STATE_HOME"'/fzf/history/default
#  --history-size 1000000
#  --bind alt-j:next-history
#  --bind alt-k:previous-history

#  --color dark
#  --color fg:-1,bg:-1,fg+:-1,bg+:-1,hl+:#e93c58,hl:#df5273
#  --color info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7

 # --cycle
#'
