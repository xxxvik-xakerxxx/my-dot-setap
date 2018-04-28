#! /bin/sh


# Options
width="300"
height="30"
font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-9"
ICON_FONT="FontAwesome:size=11"
resolution="$(xrandr --nograb --current | awk '/\*/ {printf $1; exit}')"
monitor_width="${resolution/x*}"
offset="$((monitor_width / 2 - width / 2))"
geometry="${width}x${height}+${offset:-100}+${height}"

# Icons
ICON_CLOCK='\uf017 '
ICON_DATE='\uf073'
ICON_BATTERY_EMPTY='\uf244'
ICON_BATTERY_QUARTER='\uf243'
ICON_BATTERY_HALF='\uf242'
ICON_BATTERY_THREEQUARTERS='\uf241'
ICON_BATTERY_FULL='\uf240'
ICON_BATTERY_CHARGING='\uf1e6'
ICON_VOLUME_HIGH='\uf028'
ICON_VOLUME_LOW='\uf027'
ICON_VOLUME_MUTE='\uf026'
ICON_CHAT_NONE='\uf0e5'
ICON_CHAT_NEW='\uf0e6'
ICON_EMAIL_NONE='\uf003'
ICON_EMAIL_NEW='\uf0e0'
ICON_NEWS_NONE='\uf1ea'
ICON_NEWS_NEW='\uf1ea'
ICON_WIFI_CONNECTED='\uf1eb'
ICON_WIFI_DISCONNECTED='\uf05e'
ICON_MEDIA_BACK='\uf19c'
ICON_MEDIA_FORWARD='\uf17c'
ICON_MEDIA_PLAY='\uf198'
ICON_RAM='\uf2db'
ICON_CPU='\uf200'
ICON_KEY='\uf11c'

# Kill previous instances.
killall -q lemonbar

clock() {
        local cmd=$(date "+%a %d %b %l:%M %p")
        echo -e "${ICON_DATE}${cmd}"
    }

ram() {
        local cmd=$(free -h | grep Mem | awk '{print $3}')
        cmd+="/"
        local cmd+=$(free -h | grep Mem | awk '{print $4}')
        echo -e "${ICON_RAM}${cmd}"
    }
energy() {
        local ac=/sys/class/power_supply/AC0/online
        local bat=/sys/class/power_supply/BAT0/present
        local icon=""
        local batCap=""
        if [[ -e $bat ]] && [[ $(cat $ac) -lt 1 ]]; then
            batCap="$(cat ${bat%/*}/capacity)"
            [ $batCap -gt 90 ] && icon=$ICON_BATTERY_FULL
            [ $batCap -gt 70 ] && [ $batCap -lt 90 ] && icon=$ICON_BATTERY_THREEQUARTERS
            [ $batCap -gt 50 ] && [ $batCap -lt 70 ] && icon=$ICON_BATTERY_HALF
            [ $batCap -gt 30 ] && [ $batCap -lt 50 ] && icon=$ICON_BATTERY_QUARTER
            [ $batCap -gt 15 ] && [ $batCap -lt 30 ] && icon=$ICON_BATTERY_EMPTY
            [ $batCap -lt 7 ]
        elif [[ -n $(cat $ac) ]]; then
            batCap="AC"
	    icon=$ICON_BATTERY_CHARGING
        else
            batCap="wttf"
        fi
        echo -e "${icon}${batCap}"
    }


net() {
        local _GETIWL=$(/sbin/iwgetid -r)
        local _GETETH=$(ip a | grep "state UP" | awk '{ORS=""}{print $2}' | cut -d ':' -f 1)
        local _status=${_GETIWL:-$_GETETH}
        local _status2=${_status:-Down}
        local cmd=${_status2}

        echo -e "${ICON_WIFI_CONNECTED}${cmd}"
    } 

cpu() {
        
        local cmd=" $(cat /proc/loadavg | awk '{print $1}')"
        local cmd+=" $(cat /proc/loadavg | awk '{print $4}')"
        local cmd+=" $(cat /proc/cpuinfo| grep MHz | awk '{ORS=" "}{print $4}' | sed -e 's/.000//g' | cut -f 1)"

        local clr="${cmd}"
        echo -e "${ICON_CPU}${clr}"
    }
key() {
       local cmd=$(setxkbmap -print | sed -n 's#xkb_symbols[^"]*"\([^"]*\)".*$#\1#p' | awk -F+ '{print $2}'
)
       echo -e "${ICON_KEY}${cmd}"
}

volume() {
        local volume="$(mpc volume | awk '{print $2}')"
        [[ -z ${volume%?} ]] && volume='100%'
        local clr="${volume}"
        local plus=$( "mpc volume +4 &>/dev/null" ${ICON_VOLUME_LOW})
        local minus=$( "mpc volume -3 &>/dev/null" ${ICON_VOLUME_MUTE})

        echo -e "${ICON_VOLUME_HIGH}${clr} ${plus}${minus}"
    }

# Loop and print the info.
while :; do
echo -e "%{c}$(clock) $(ram) $(key)"
    sleep 30s
done |\

# Launch lemonbar.
lemonbar -b -d -g "$geometry" -f "$font" -f "$ICON_FONT" -B "${1:-#263238}" -F "${2:-#FFFFFF}" -n "bar" # &


sleep 1