#!/bin/sh
#make the actual installer executable
chmod +x ./files/script.sh
#check which terminal is installed and start the script.sh file in it
if hash konsole 2>/dev/null; then
        konsole -e sudo ./files/script.sh
    elif hash gnome-terminal 2>/dev/null; then
        gnome-terminal -e sudo ./files/script.sh
    elif hash xfce4-terminal 2>/dev/null; then
        xfce4-terminal -e sudo ./files/script.sh
    elif hash qterminal 2>/dev/null; then
        qterminal -e sudo ./files/script.sh
    elif hash deepin-terminal 2>/dev/null; then
        deepin-terminal -e sudo ./files/script.sh
    fi

