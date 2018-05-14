# Load configs
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
xbindkeys
udiskie &
exec setxkbmap -option grp:caps_toggle -option lv3:ralt_switch -option grp_led:caps -layout us+typo,ru:2+typo &


xset +fp /home/vh/.fonts
xset fp rehash

# Background image
feh --bg-fill "$HOME/.wallpaper.jpg"

# Statusbar
bar | lemonbar -a 5 -b -d -p -f "scientifica:size=11" -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' -B "#00000000" -F "#EEFFFF" -g 1000x40+15+15 &

# Compton
compton &

# Editor 

emacs --daemon &

2bwm&
exec st
