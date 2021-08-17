#!/bin/bash
# save logs here:
LOG="$HOME/.local/share/dwm/dwm_autostart.log"
ERR="$HOME/.local/share/dwm/dwm_autostart.errors.log"
rm -f "$LOG"; touch "$LOG"
rm -f "$ERR"; touch "$ERR"

log(){
    echo "$@" >> "$LOG"
    eval "$@" >> "$LOG" 2>> "$ERR"
}

start(){
    pidof "$1" >/dev/null 2>&1 && return
    log "$@" &
}

export PATH="$PATH:/home/fewcm/.local/bin"
export PATH="$PATH:/home/fewcm/.local/bin/dwm"

start xrdb ~/.Xresources
#getcolors () {
#	FOREGROUND=$(xrdb -query | grep '.foreground:'| awk '{print $NF}')
#	BACKGROUND=$(xrdb -query | grep '.background:'| awk '{print $NF}')
#	BLACK=$(xrdb -query | grep '.color0:'| awk '{print $NF}')
#	RED=$(xrdb -query | grep '.color1:'| awk '{print $NF}')
#	GREEN=$(xrdb -query | grep '.color2:'| awk '{print $NF}')
#	YELLOW=$(xrdb -query | grep '.color3:'| awk '{print $NF}')
#	BLUE=$(xrdb -query | grep '.color4:'| awk '{print $NF}')
#	MAGENTA=$(xrdb -query | grep '.color5:'| awk '{print $NF}')
#	CYAN=$(xrdb -query | grep '.color6:'| awk '{print $NF}')
#	WHITE=$(xrdb -query | grep '.color7:'| awk '{print $NF}')
#}
#getcolors

## Autostart -------------------------------#

# Kill already running process
_ps=(compton blueberry-tray picom dunst xsettingsd xfce4-power-manager polkit-dumb-agent)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

#start pulseaudio-control.bash listen &
pactl set-default-sink alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 &

#start blueberry-tray &
# polkit agent
start polkit-dumb-agent &

# Lauch notification daemon
start dunst -c $HOME/.config/dunst/dunstrc &

#start udiskie -c $HOME/.config/udiskie/config.yml &
# Lauch xsettingsd daemon
start xsettingsd &
#start lxappearance &


# Enable power management
#start xfce4-power-manager &

#start mpd &
start mpDris2 &
start playerctld daemon &

#start xrandr --output HDMI-0 --primary --mode 2560x1080 --pos 0x0 --rotate normal --output DVI-D-0 --mode 1920x1080 --pos 2560x0 --rotate normal &
#start xrandr --output HDMI-1 --primary --mode 2560x1080 --pos 0x0 --rotate normal --output DVI-D-1 --mode 1920x1080 --pos 2560x0 --rotate normal &
start xrandr --output VGA-0 --off --output DVI-D-0 --left-of HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --primary --mode 2560x1080 --pos 1920x0 --rotate normal

# Start dwm scripts
#start dwmweather &
start dwmremaps &

start dwmstatusbar &
start dwmbar &
start dwmcomp &
start indicator-sound-switcher &

# set default font
#xfconf-query --channel xsettings --property /Gtk/FontName --set "JetBrains Mono Regular 11"
# set default monospace font
#xfconf-query --channel xsettings --property /Gtk/MonospaceFontName --set "JetBrains Mono Regular 11"

# Restore wallpaper
$HOME/.fehbg

#while true ; do
#	dwm
#done
