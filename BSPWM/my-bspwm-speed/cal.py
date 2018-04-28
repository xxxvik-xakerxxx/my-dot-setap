#!/usr/bin/python3

import os
import subprocess
import sys

# Colors
blue  = "4"
green = "2" 

def run(arg):
  return subprocess.Popen(arg, stdout=subprocess.PIPE, stderr=subprocess.PIPE).stdout.read().decode(encoding="UTF-8")

def clearcolor():
  echo("\033[0m")

def echo(text):
  print(text, end='')

def color(text, clr):
  echo("\033[1;3" + clr + "m")
  echo(text)
  clearcolor()

def main(format):
  dayow       = run(["date", "+%a"])[:2]
  current_day = "none"
  
  if len(format) == 3:
    cal   = run(["cal", format[1], format[2]]).splitlines()
  elif len(format) == 2:
    current_year = run(["date", "+%Y"])[:4]
    cal   = run(["cal", format[1], current_year]).splitlines()
  else:
    current_day = run("date").split(" ")[3]
    cal   = run(["cal"]).splitlines()

  month, year = list(filter(None, cal[0].split(" ")))

  print()
  echo(" " * (10 - len(month)//2 - 2))
  color(month, green)
  echo(" ")
  color(year, blue)
  print()

  if current_day != "none":
    before, after = cal[1].split(dayow)
    color(before, blue)
    color(dayow,  green)
    color(after,  blue)
  else:
    color(cal[1], blue)
  print()

  flag = False
  for e in cal[2:]:
    if flag or current_day not in e: print(e)
    elif not flag:
      flag = True
      days_before, days_after = e.split(current_day)
      echo(days_before)
      color(current_day,  green)
      echo(days_after)
      print()

if __name__ == '__main__':
  main(sys.argv)
