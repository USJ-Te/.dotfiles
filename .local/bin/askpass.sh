#!/usr/bin/env bash
rofi -dmenu\
     -password\
     -i\
     -no-fixed-num-lines\
     -p "Root Password: "\
     -theme ~/.config/rofi/themes/askpass.rasi &
