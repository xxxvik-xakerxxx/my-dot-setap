#!/bin/sh

#        ___                       ___                                   ___           ___     
#       /__/|        ___          /__/\        ___           ___        /  /\         /  /\    
#      |  |:|       /  /\         \  \:\      /  /\         /  /\      /  /::\       /  /:/    
#      |  |:|      /  /:/          \  \:\    /  /:/        /  /:/     /  /:/\:\     /  /:/     
#    __|__|:|     /__/::\      _____\__\:\  /__/::\       /  /:/     /  /:/~/:/    /  /:/  ___ 
#   /__/::::\____ \__\/\:\__  /__/::::::::\ \__\/\:\__   /  /::\    /__/:/ /:/___ /__/:/  /  /\
#      ~\~~\::::/    \  \:\/\ \  \:\~~\~~\/    \  \:\/\ /__/:/\:\   \  \:\/:::::/ \  \:\ /  /:/
#       |~~|:|~~      \__\::/  \  \:\  ~~~      \__\::/ \__\/  \:\   \  \::/~~~~   \  \:\  /:/ 
#       |  |:|        /__/:/    \  \:\          /__/:/       \  \:\   \  \:\        \  \:\/:/  
#       |  |:|        \__\/      \  \:\         \__\/         \__\/    \  \:\        \  \::/   
#       |__|/                     \__\/                                 \__\/         \__\/    

# I don't know what these lines below do
# I just find them in default .xinitrc
# Load configs
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
xbindkeys
exec setxkbmap -option grp:caps_toggle -option lv3:ralt_switch -option grp_led:caps -layout us+typo,ru:2+typo &


xset +fp /home/vh/.fonts
xset fp rehash
#redshift -l 50:30 -t 5500:3700

# Background image
feh --bg-fill "$HOME/.wallpaper.jpg"

# Statusbar
#bar-dwm | lemonbar -a 5 -b -d -p -f "scientifica:size=11" -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' -B "#00000000" -F "#EEFFFF" -g 995x40+15+15 &

# Compton
compton &

dwmstatus &
dunst &

# Then dwm is ready
exec dwm
