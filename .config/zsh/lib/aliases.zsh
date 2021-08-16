#!/bin/zsh

#Tail all logs in /var/log
alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

alias z='cd'
# Fzf
alias f='fzfx'
alias ff='fzfx full' # full text search
alias fh='fzfx all' # hidden files
alias fcd='cd "$(fzfx cd)"' # directories
alias fcp='fzfx cp' # copy files
alias fmv='fzfx mv' # move files
alias fmd='fzfx md' # markdown files
alias fpdf='fzfx pdf' # pdf and postscript files
alias fav='fzfx media' # audio and videos
alias fpic='fzfx media' # pictures
alias fps='fzfx ps' # processes

#copy/paste all content of /etc/skel over to home folder - backup of config created - beware
#alias skel='cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -rf /etc/skel/* ~'
#backup contents of /etc/skel to hidden backup folder in home/user
#alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

#copy bashrc-latest over on bashrc - cb= copy bashrc
#alias cb='sudo cp /etc/skel/.bashrc ~/.bashrc && source ~/.bashrc'
#copy /etc/skel/.zshrc over on ~/.zshrc - cb= copy zshrc
#alias cz='sudo cp /etc/skel/.zshrc ~/.zshrc && source ~/.zshrc'

##alias
alias rm='rm -I -v '

# Linux specific aliases, work on both MacOS and Linux.
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias sudo='sudo '
alias e='$EDITOR'
alias rrsync='rsyncy -a'
## Disk usage ##
alias dfsys='df -Tha --total'
alias ncdux='ncdu -e -2 --si --confirm-quit --color dark --exclude-caches -x /'
alias ncdu.='ncdu -e -2 --si --confirm-quit --color dark --exclude-caches .'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd .. 2>/dev/null || cd "$(dirname $PWD)"' # Allows leaving from deleted directories
alias ~='cd ~' # `cd` is probably faster to type though

alias pacmaninst='pacman -Qq | fzf --preview "pacman -Qil {}" --layout=reverse --bind "enter:execute(pacman -Qil {} --preview-window=wrap:right:40%  | less)"'                                                                                         
alias yayinst='yay -Slq | fzf -m --preview "yay -Si {1}" | xargs -ro sudo yay -S'
alias yay='yay --sudoloop'
#alias visudo='sudo -E visudo'
#alias find='fd'

#merge new settings
alias merge='xrdb -merge ~/.Xresources'

#youtube-dl
alias yta-mp3='youtube-dl --embed-thumbnail --extract-audio --audio-format mp3 '
alias yta='youtube-dl -f bestaudio --extract-audio --audio-format mp3  --embed-thumbnail  '

#Recent Installed Packages
alias rip='expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
alias riplong='expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -3000 | nl'

## general use
##ls
#alias l='logo-ls -l --time-style=Stamp --almost-all'
alias l='exa --icons'
alias lls='exa --long --header --sort=Filename --group-directories-first --icons --color=always'

alias la='exa --sort=Filename --group-directories-first --all --icons --color=always'
alias lla='exa --long --header --sort=Filename --group-directories-first --all --icons --color=always'
#alias l='ls-icons --sort=size --all --color=always --group-directories-first -C --human-readable'
#
#alias ls='exa --long --header --sort=Filename --group-directories-first --icons --color=always'
#alias la='exa --all --sort=Filesize --group-directories-first --icons --color=always'
##long list                                                         					                            
#alias ll='exa --long --header  --recurse --level=1 --time-style=long-iso --sort=Filename --group-directories-first --icons --color=always'
##ls with hidden files
#alias la='exa --long --header --all --recurse --level=1 --time-style=long-iso --sort=Filename --group-directories-first --icons --color=always'
##ls in tree mode
alias lta='exa --tree --header --level=2 --time-style=long-iso --sort=Filename --group-directories-first --icons --color=always'

alias ltd='exa --tree --header --all --level=2  --list-dirs --sort=Filename --group-directories-first --icons --color=always'

##ls in tree mode with hidden files
alias lxta='exa --tree --header --all --level=2 --time-style=long-iso --sort=Filename --group-directories-first --icons --color=always'

# Reload the shell (i.e. invoke as a login shell)
alias reload='exec "${SHELL}" "$@"'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias fpath='echo -e ${FPATH//:/\\n}'

alias yt='youtube-dl -v'
alias zshrc='micro ~/.config/zsh/.zshrc'
alias sedit='sudo micro'

alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages
alias dd='dd status=progress'
alias diff='diff --color=auto'
#alias config='/usr/bin/git --git-dir=/home/fewcm/.cfg/ --work-tree=/home/fewcm'
alias dotfiles='/usr/bin/git --git-dir=/home/fewcm/.cfg/ --work-tree=/home/fewcm'
