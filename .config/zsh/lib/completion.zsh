#
# Initialization
#

# Defaults.
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

zstyle ':completion:*' file-patterns '%p(D):globbed-files *(D-/):directories' '*(D):all-files'

# Use caching to make completion for commands such as dpkg and apt usable.
zstyle ':completion::complete:*' use-cache on

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
#zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
#zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
#zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
#zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word. But make
# sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
#zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes


# give a preview of commandline arguments when completing `kill`
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
#zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
#  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
#zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:complete:cd:*' fzf-preview ' 
	exa --oneline --long --header --color=always --icons --group-directories-first $realpath 
'

zstyle ':fzf-tab:complete:(nvim|vim|micro|nano):*' fzf-preview '

	bat --style=numbers --color=always --line-range :250 $realpath 2>/dev/null
'
#
# Styles
#
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' list-dirs-first true
zstyle :compinstall filename '$HOME/.config/zsh/.zshrc'

#zcachedir="$HOME/.zcache"
#[[ -d "$zcachedir" ]] || mkdir -p "$zcachedir"

######< sorting
zstyle ':completion:*:*:(gd):*' file-sort time
zstyle ':completion:*:*:(mplayer|m|ms|vim|feh|ls|du|file|cd):*' file-sort time
zstyle ':completion:*:*:(mplayer|vim|feh|ls|du|file|cd):*' file-sort time
zstyle ':completion:*:*:(mplayer|vim|feh|cd|ls|du|file):*' file-sort name
#zstyle ':completion:*:*:cd:*' file-sort name
zstyle ':completion:*:*:cd:*' file-sort time
######>

######< cd
zstyle ':completion:*:*:(cd):*' accept-exact-dirs false
zstyle ':completion:*:*:(cd):*' add-space         true
zstyle ':completion:*:*:(cd):*' ambiguous         true
zstyle ':completion:*:*:(cd):*' extra-verbose     false
zstyle ':completion:*:*:(cd):*' extra-verbose     true
zstyle ':completion:*:*:(cd):*' force-list
zstyle ':completion:*:*:(cd):*' format            ''
zstyle ':completion:*:*:(cd):*' group-order       paths path-directories  directories  directory-stack bookmarks
zstyle ':completion:*:*:(cd):*' completer         _list _complete _expand _match
zstyle ':completion::complete:cd:*' tag-order \
named-directories:-mine:extra\ directories
#named-directories:-normal:named\ directories *'
#zstyle ':completion::complete:cd:*:named-directories-mine' \
#####  ignored-patterns '*'

#_update_zcomp() {
#    setopt local_options
#    setopt extendedglob
#    autoload -Uz compinit
#    local zcompf="$1/zcompdump"
    # use a separate file to determine when to regenerate, as compinit doesn't
    # always need to modify the compdump##
    #local zcompf_a="${zcompf}.augur"

    #if [[ -e "$zcompf_a" && -f "$zcom#pf_a"(#qN.md-1) ]]; then
    #    compinit -C -d "$zcompf"
    #else
    #    compinit -d "$zcompf"
    #    touch "$zcompf_a"
    #fi
    # if zcompdump exists (and is non-zero), and is older than the .zwc file,
    # then regenerate
    #if [[ -s "$zcompf" && (! -s "${zcompf}.zwc" || "$zcompf" -nt "${zcompf}.zwc") ]]; then
        # since file is mapped, it might be mapped right now (current shells), so
        # rename it then make a new one
    #    [[ -e "$zcompf.zwc" ]] && mv -f "$zcompf.zwc" "$zcompf.zwc.old"
        # compile it mapped, so multiple shells can share it (total mem reduction)
        # run in background
    #    zcompile -M "$zcompf" &!
    #fi
#}
#_update_zcomp "$zcachedir"
#unfunction _update_zcomp
