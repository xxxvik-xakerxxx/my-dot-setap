#!/usr/bin/python
import os, subprocess

def run(arg):
  return subprocess.Popen(arg, stdout=subprocess.PIPE).stdout.read().decode(encoding="UTF-8")

def getlayout():
  return run(["setxkbmap", "-print"]).splitlines()[4][29:31]

def setlayout(lang):
  start = 'setxkbmap -layout "'
  os.system(start + lang)


if getlayout() == "us": setlayout('ru"')
else: setlayout('us"')