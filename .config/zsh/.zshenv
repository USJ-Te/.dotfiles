#!/bin/zsh

skip_global_compinit=1

#export LS_COLORS="$(vivid generate lava)"
export EXA_ICON_SPACING=1
#export _JAVA_AWT_WM_NONREPARENTING=1
#dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY

# Don't load default zshrc
setopt no_global_rcs

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# autoload {{{
autoload -Uz is-at-least
autoload -Uz history-search-end
autoload -Uz cdr
autoload -Uz chpwd_recent_dirs
autoload -Uz zed 
autoload -Uz zcalc
autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz modify-current-argument
autoload -Uz smart-insert-last-word
autoload -Uz terminfo
autoload -Uz vcs_info
autoload -Uz run-help-git

# Smart Url
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
# automatically escape pasted URLs
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
# Edit command line with EDITOR
#autoload -Uz edit-command-line
#zle -N edit-command-line

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_DIR="$HOME/.local/bin"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/share:/usr/local/share"
export ZDOTDIR="$HOME/.config/zsh"

export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

# NPM packages in homedir
export NPM_PACKAGES="$HOME/.local/npm-packages"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
# Tell our environment about user-installed node tools
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

export HISTFILE="$HOME/.config/zsh/history"
export HISTSIZE=100000
export SAVEHIST=150000

export PATH="$PATH:${$(find ~/.local/bin ~/.config/rofi/bin ~/.config/polybar/bin -type d -printf %p:)%%:}"

export GOPATH="$HOME/.config/go"
export PATH="$PATH:$GOPATH/bin"

#export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

declare -A ZINIT

export ZINIT[BIN_DIR]="$ZDOTDIR/zinit/bin"
export ZINIT[HOME_DIR]="$ZDOTDIR/zinit"



export COLORTERM=truecolor
#export TERM="xterm-256color"
export QT_STYLE_OVERRIDE="qt5ct-style"
export QT_QPA_PLATFORMTHEME="qt5ct-style"
#export QT_QPA_PLATFORMTHEME=qt5ct
export BAT_THEME="gruvbox-material"

export OPENER='xopen'         
export EDITOR=micro
export VISUAL=micro
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
#export MANPAGER="nvim -c 'set ft=man ts=8 nomod nolist noma'" # slower than bat

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s" # syntax highlight
#export LESSOPEN="| LESSQUIET=1 lesspipe.sh %s"
#export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"

#export LESS="-R " # colorize output
export LESS="-iRX --mouse --wheel-lines 2 --status-column --LONG-PROMPT --quit-on-intr --no-histdups"

export LESSHISTFILE=-

MICRO_TRUECOLOR=1
export RANGER_LOAD_DEFAULT_RC=FALSE


# LESS (and man) colors
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"     
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"   
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"     
export LESS_TERMCAP_so="$(printf '%b' '[01;34;40m')" 
export LESS_TERMCAP_me="$(printf '%b' '[0m')"        
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"        
export LESS_TERMCAP_se="$(printf '%b' '[0m')" 

export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5


# This is the list for lf icons:
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

typeset -U path PATH manpath sudo_path cdpath fpath

. "/home/fewcm/.local/share/cargo/env"

