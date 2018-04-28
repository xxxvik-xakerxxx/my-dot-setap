#!/usr/bin/python
import argparse, os

start = """
pkill .lemon.py; pkill lemonbar;
for window in $(bspc query -W); do
  bspc window $window_id -c
done
bspc quit; 
"""

shutdown = "systemctl poweroff"
reboot   = "systemctl reboot"

parser = argparse.ArgumentParser()
parser.add_argument("action")
args = parser.parse_args()
if   args.action == "reboot": os.system(start + reboot)
elif args.action == "shutdown": os.system(start + shutdown)