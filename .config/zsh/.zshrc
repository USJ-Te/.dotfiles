#!/bin/zsh
zmodload zsh/zprof 
typeset -F4 SECONDS=0

ZINIT_HOME="${ZINIT_HOME:-${ZPLG_HOME:-${ZDOTDIR:-${HOME}}/zinit}}"
ZINIT_BIN_DIR_NAME="${${ZINIT_BIN_DIR_NAME:-${ZPLG_BIN_DIR_NAME}}:-bin}"
### Added by Zinit's installer
if [[ ! -f "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}/zinit.zsh" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma/zinit "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

# A binary Zsh module which transparently and automatically compiles sourced scripts
module_path+=( "/home/fewcm/.config/zsh/zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin &>/dev/null

# Might be assigned by [[file:~/.profile][profile]].
if [ -z "$shell" ]; then
  case "$(ps -p $$ | awk 'END { print($NF) }')" in
    *bash) shell="bash"   ;;
    *zsh)  shell="zshell" ;;
    *)     shell=         ;;
  esac
fi

# Source autoloads
[                   -f "$XDG_CONFIG_HOME/zsh/auto/global"    ] && . "$XDG_CONFIG_HOME/zsh/auto/global"
[ -n "$shell"    -a -f "$XDG_CONFIG_HOME/zsh/auto/$shell"    ] && . "$XDG_CONFIG_HOME/zsh/auto/$shell"

#zinit ice multisrc"base16-gruvbox-material-dark-hard.sh" lucid
#zinit light $ZDOTDIR/termcolors

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-submods 
    
### End of Zinit's installer chunk

_zpcompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZPLGM[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}

#zinit lucid reset \
# atclone"[[ -z ${commands[dircolors]} ]] && local P=g
#    \${P}dircolors -b LS_COLORS > clrs.zsh" \
#  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
#  atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
#    trapd00r/LS_COLORS
eval $( dircolors -b $HOME/LS_COLORS)

# colors {{{
#export BASE16_THEME='gruvbox-material-mix'
#export BASE16_THEME_FZF='gruvbox-dark-medium'
zinit light 'chrissicool/zsh-256color'
#zinit ice pick"scripts/base16-${BASE16_THEME}.sh"; zinit light fnune/base16-shell
#zinit ice lucid wait'0' src"bash/base16-${BASE16_THEME_FZF}.config" nocompile'!'; zinit light fnune/base16-fzf
# }}}

#d=.dircolors
#test -r $d && eval "$(dircolors $d)"
    
# prompt
#setopt prompt_subst

zinit light mafredri/zsh-async
#zinit light laggardkernel/spacezsh-prompt

zinit light spaceship-prompt/spaceship-prompt
SPACESHIP_PROMPT_ORDER=(
  #ssh                # SSH connection indicator
  vi_mode
  user               # Username section
  #host               # Hostname section
  dir                # Current directory section
  git
  line_sep           # Line break
  char               # Prompt character, with vi-mode indicator integrated
)

SPACESHIP_RPROMPT_ORDER=(
  exit_code # Exit code section
  exec_time # Execution time
  jobs      # Background jobs indicator
  time      # Time stampts section
)
SPACESHIP_CHAR_COLOR_SUCCESS=003
SPACESHIP_CHAR_SYMBOL='λ '
SPACESHIP_CHAR_SYMBOL_ROOT=' λ ' 

SPACESHIP_VI_MODE_INSERT='>' 
SPACESHIP_VI_MODE_NORMAL='<'
SPACESHIP_VI_MODE_COLOR=red


SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT='󱕅 %t'
#SPACESHIP_TIME_12HR=true

zinit ice depth'1' lucid wait'0' atinit"_zpcompinit_custom; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

_zsh_autosuggest_setting() {
	# Remove forward-char widgets from ACCEPT
	ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=("${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#forward-char}")
	
	# Add forward-char widgets to PARTIAL_ACCEPT
	ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char)

	#bindkey '^ ' autosuggest-accept
	#bindkey '^[[C' forward-word
	#bindkey "${terminfo[kcuf1]}" forward-word
	ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
	ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=orange"
}
zinit ice wait atload'!_zsh_autosuggest_start; _zsh_autosuggest_setting' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait blockf lucid
zinit light zsh-users/zsh-completions

# FD
zinit ice wait'0b' as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd" lucid
zinit light sharkdp/fd

# RIPGREP
zinit ice wait'0c' from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg" lucid
zinit light BurntSushi/ripgrep

zinit ice wait'0d' atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' lucid     
zinit light hlissner/zsh-autopair 

# FZF
zinit ice wait'0e' lucid from"gh-r" as"command"
zinit light junegunn/fzf

# BIND MULTIPLE WIDGETS USING FZF
zinit ice wait'0e' lucid multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

zinit ice wait"0f" as"command" from"gh-r" lucid \
  mv"zoxide*/zoxide -> zoxide" \
  atclone"./zoxide init zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!' 
zinit light ajeetdsouza/zoxide

_ZVM-setting() {
  export ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
  export ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BEAM
  export ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
 }  
zinit ice depth=1 atload"_ZVM-setting" lucid
zinit light jeffreytse/zsh-vi-mode

# Always starting with insert mode for each command line
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT


_zsh-history-substring-search-setting() {
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  bindkey "$terminfo[kcuu1]" history-substring-search-up
  bindkey "$terminfo[kcud1]" history-substring-search-down
  HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
}
zinit ice wait'0b' lucid atload "_zsh-history-substring-search-setting" 
zinit light zsh-users/zsh-history-substring-search

_alias-tip-setting() {
  export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
  export ZSH_PLUGINS_ALIAS_TIPS_FORCE=0
  export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=0
}
zinit ice wait multisrc"functions.zsh shelloptions.zsh fzf-set.zsh interactive-cd.zsh completion.zsh alias_reveal.zsh keymappings.zsh bash.command-not-found " atload"_alias-tip-setting" lucid
zinit light $ZDOTDIR/lib

chpwd() exa --icons --color=always 
#source /usr/share/doc/pkgfile/command-not-found.zsh


print "[zshrc] ZSH took ${(M)$(( SECONDS * 1000 ))#*.?} ms"

