#!/usr/bin/python
import time, subprocess, os

# COLORS
BG_BLACK = "%{B#C8000000}%{-u}"
SELECTED = "%{B#BE09131A}%{+u}"
INIT     = "%{U#AA0C6FB6}"
WHITE    = "%{F#FFF}"
GRAY     = "%{F#555}"
RED      = "%{F#FF0000}"
CENTER   = "%{c}"
RIGHT    = "%{r}"
END      = u"\u00A0"u"\u00A0"+"\n"

# BATTERIES
B_CRITICAL = ""   #   5%
B_LOW      = ""   #  25%
B_HALF     = ""   #  50%
B_ALMOST   = ""   #  75%
B_FULL     = ""   # 100%
WIRED      = ""

# ICONS
VOLUME    = ""
WIFI      = ""
desknames = ["", "", "", "", "", ""]

def run(arg):
  return subprocess.Popen(arg, stdout=subprocess.PIPE).stdout.read().decode(encoding="UTF-8")

def get_time():
  raw = run("date")[:15]
  return raw[:9] + "," + raw[9:]

def windows():
  deskn  = -1
  status = run(["bspc", "wm", "-g"])
  winds   = [0, 0, 0, 0, 0, 0]
  selec  = 0

  for i, e in enumerate(status.split(":")):
    if e[0] == "O":
      selec = i-1
      winds[i-1] = 1
    if e[0] == "F": selec = i-1
    if e[0] == "o": winds[i-1] = 1
  return selec, winds

def deskbar():
  selected, winds = windows()
  bar = ""
  if selected == 0: bar = SELECTED + bar
  for num, deskname in enumerate(desknames):
    if winds[num] == 1:
      if num == selected: bar += SELECTED + "   " + WHITE + deskname + "   " + BG_BLACK
      else: bar += "   " + WHITE + deskname + "   "
    else:
      if num == selected: bar += SELECTED + "   " + GRAY  + deskname + "   " + BG_BLACK
      else: bar += "   " + GRAY  + deskname + "   "
  bar += WHITE + BG_BLACK
  return bar

def volume():
  raw   = run(["pactl", "list", "sinks"]).splitlines()[9:10][0]
  value = raw[raw.find("/ ")+2:raw.find("%")]
  return VOLUME + value + "%  "

def wifi():
  raw = run(["iwconfig"]).splitlines()[0].split(":")[1][1:]
  if "ff" in raw: return ""
  return WIFI + " " + raw[:len(raw)-3:] + "  "

def battery():
  raw     = run(["acpi"])[11:-1]
  icon    = ""
  time    = ""
  time = raw[raw.find("%,")+4:raw.find("%,")+8]
  if "until" in raw:
    icon = WIRED + " "
    if time == "unti": time = ""
  elif "Full" in raw:
    icon = WIRED
    time = ""
  elif "remaining" in raw:
    percent = int(raw[raw.find(" ")+1:raw.find("%")])
    if   percent <= 5:   icon = B_CRITICAL
    elif percent <= 25:  icon = B_LOW
    elif percent <= 50:  icon = B_HALF
    elif percent <= 75:  icon = B_ALMOST
    elif percent <= 100: icon = B_FULL
    icon += " "
    if icon == B_LOW + " ": return RED + icon + time
  return icon + time
#+ volume()
def sysinfo():
  return getlayout() + "  " + volume() + wifi() + battery()

#def stats():   + stats()
  #f         = open(".toggle", "r")
  #state     = f.read()[0]
  #if state == "1": 
  #  space   = "  "
  #  offset  = " " * 30
  #  rawmem  = run(["free", "-hm"]).splitlines()[1]
  #  mem     = rawmem[26:32]
  #  cpuraw  = run(["top", "-bn2", "u1"]).splitlines()[13:17]
  #  cpu     = 0
  #  for c in cpuraw: cpu += int(c[c.find(":")+1:c.find(".")])
  #  cpu     = cpu // 4
  #  rawtemp = run("sensors").splitlines()[2:3][0]
  #  temp    = rawtemp[rawtemp.find("+")+1:rawtemp.find(".")]
  #  return "     mem:" + space + str(mem) + space + "cpu:" + space + str(cpu) + "%" + space + "t:" + space + temp + "°" + offset
  #else: return ""

def getlayout():
  return run(["setxkbmap", "-print"]).splitlines()[4][29:31]

while 1:
  f = open(".bar", "w")
  f.write(INIT + deskbar() + CENTER + get_time() + RIGHT + sysinfo() + END)
time.sleep(.1)