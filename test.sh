#!/bin/sh
osascript -e 'tell application "iTerm" to activate' -e 'tell application "System Events" to tell process "iTerm" to keystroke "n" using command down' -e 'delay 1' -e "tell application \"iTerm\" to tell session -1 of current terminal to write text \"poop\"" -e 'tell application "System Events" to tell process "iTerm" to keystroke return using command down'
