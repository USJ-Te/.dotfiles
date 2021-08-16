#!/bin/zsh

function rgb_to_hex() {
    # Usage: rgb_to_hex "r" "g" "b"
    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

function hex_to_rgb() {
    # Usage: hex_to_rgb "#FFFFFF"
    #        hex_to_rgb "000000"
    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

# Easy way to extract archives
function ex () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1     ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}


function pacsize() {
pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}

# Usage: palette
function palette() {
    local -a colors
    for i in {000..255}; do
        colors+=("%F{$i}$i%f")
    done
    print -cP $colors
}

# Usage: printc COLOR_CODE
#function printc() {
#    local color="%F{$1}"
#    echo -E ${(qqqq)${(%)color}}
#}

function escape_color() {
  for code in {0..255}
    do echo -e "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m"
  done
}

function 16_escape_color() {
  for code in {30..37}; do \
	echo -en "\e[${code}m"'\\e['"$code"'m'"\e[0m"; \
	echo -en "  \e[$code;1m"'\\e['"$code"';1m'"\e[0m"; \
	echo -en "  \e[$code;3m"'\\e['"$code"';3m'"\e[0m"; \
	echo -en "  \e[$code;4m"'\\e['"$code"';4m'"\e[0m"; \
	echo -e "  \e[$((code+60))m"'\\e['"$((code+60))"'m'"\e[0m"; \
done
}

#
# Functions
#
# Runs bindkey but for all of the keymaps. Running it with no arguments will
# print out the mappings for all of the keymaps.
function bindkey-all {
  local keymap=''
  for keymap in $(bindkey -l); do
    [[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
    bindkey -M "${keymap}" "$@"
  done
}


#####################
# FANCY-CTRL-Z      #
#####################
function fg-fzf() {
	job="$(jobs | fzf -0 -1 | sed -E 's/\[(.+)\].*/\1/')" && echo '' && fg %$job
}

function fancy-ctrl-z () {
	if [[ $#BUFFER -eq 0 ]]; then
		BUFFER=" fg-fzf"
		zle accept-line -w
	else
		zle push-input -w
		zle clear-screen -w
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

function pacsize() {
	pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}

#function rm() {
#	rm -I -v "${@}"
#}


# copy directory and cd to it
cpcd() {
  if [ -d "$2" ];then
    cp "$1" "$2" && (cd "$2" || exit)
  else
    cp "$1" "$2"
  fi
}

# move directory and cd to it
mvcd() {
  if [ -d "$2" ];then
    mv "$1" "$2" && (cd "$2" || exit)
  else
    mv "$1" "$2"
  fi
}

# Determine size of a file or total size of a directory
fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh
	else
		local arg=-sh
	fi
	# shellcheck disable=SC2199
	if [[ -n "$@" ]]; then
		du $arg -- "$@"
	else
		du $arg -- .[^.]* *
	fi
}



function list() {
  fzf -m --preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || bat --style=numbers --color=always {}' | xargs ls -lha
}

function disappointed() { 
	echo -n " ಠ_ಠ " |tee /dev/tty| xclip -selection clipboard; 
}

function flip() { 
	echo -n "（╯°□°）╯ ┻━┻" |tee /dev/tty| xclip -selection clipboard; 
}

function shrug() { 
	echo -n "¯\_(ツ)_/¯" |tee /dev/tty| xclip -selection clipboard; 
}

function matrix() { 
	echo -e "\e[1;40m" ; clear ; while :; do echo $LINES $COLUMNS $(( $RANDOM % $COLUMNS)) $(( $RANDOM % 72 )) ;sleep 0.05; done|awk '{ letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"; c=$4;        letter=substr(letters,c,1);a[$3]=0;for (x in a) {o=a[x];a[x]=a[x]+1; printf "\033[%s;%sH\033[2;32m%s",o,x,letter; printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,letter;if (a[x] >= $1) { a[x]=0; } }}' 
}

function fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

function in() {
    yay -Slq | fzf -q "$1" -m --preview 'yay -Si {1}'| xargs -ro yay -S
}

function re() {
    yay -Qq | fzf -q "$1" -m --preview 'yay -Qil {1}' | xargs -ro yay -Rnsc
}

promptspeed() {
    for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
}

#runs which, and prints the contents of the function/script
function which-cat() {
	local COMMAND_OUTPUT USER_INPUT
	USER_INPUT="${1:?Must provide a command to lookup}"
	if COMMAND_OUTPUT="$(which "${USER_INPUT}")"; then
		# if the file is readable
		if [[ -r "${COMMAND_OUTPUT}" ]]; then
			if iconv --from-code="utf-8" --to-code="utf-8" "${COMMAND_OUTPUT}" >/dev/null 2>&1; then
				command cat "${COMMAND_OUTPUT}"
			else
				file "${COMMAND_OUTPUT}"
			fi
		else
			# error finding command, or its an alias/function
			printf '%s\n' "${COMMAND_OUTPUT}"
		fi
	else
		printf '%s\n' "${COMMAND_OUTPUT}" >&2
	fi
}

function zsh_stats() {
  fc -l 1 \
    | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' \
    | grep -v "./" | sort -nr | head -20 | column -c3 -s " " -t | nl
}


sfont() {
	fc-cache
	fc-list		|
	cut -f2,3 -d:	|
	grep -i "$1" |
	sort
}

# Colors
bonsai() {
	printf "              \e[32m&&\n"
	printf "             \e[32m&&&&&\n"
	printf "           \e[32m&&&\/& &&&\n"
	printf "          \e[32m&&\e[33m|,/  |/\e[32m& &&\n"
	printf "           \e[32m&&\e[33m/   /  /_\e[32m&  &&\n"
	printf "             \e[33m\  {  |_____/_\e[32m&\n"
	printf "             \e[33m{  / /          \e[32m&&&\n"
	printf "             \e[33m.\`. \\{___\________\/_\}\n"
	printf "              \e[33m\} \}\{       \\ \n"
	printf "              \e[33m}\{\{         \\____\e[32m&\n"
	printf "             \e[33m\{\}\{           \`\e[32m&\e[33m\\e[32m&&\n"
	printf "             \e[33m{{}             \e[32m&&\n"
	printf "       \e[33m, -=-~{ .-^- _\n"
	printf "             \`}\n"
	printf "              {\n"
}

blocks() {
	echo; echo; for i in 0 1 2 3 4 5 6 7; do
		printf '\033[10%bm	 \033[s\033[1A\033[3D\033[4%bm	 \033[u' "$i" "$i"
	done; printf '\n\033[0m'
}

256col() {
	for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

xrescol() {
	read -r -d '' -A colors \
			< <( xrdb -query | sed -n 's/st.color\([0-9]\)/\1/p' | sort -nu | cut -f2)
	printf '\e[1;37m\nBlack		Red	Green	Yellow	Blue	Magenta	Cyan	White\n───────────────────────────────────────────────────────────────────────────────────────\e[0m\n'
	for color in {0..7}; do printf "\e[$((30+color))m █ %s \e[0m" "${colors[color+1]}"; done
	printf '\n'
	for color in {8..15}; do printf "\e[1;$((22+color))m █ %s \e[0m" "${colors[color+1]}"; done
	printf '\n'
}
