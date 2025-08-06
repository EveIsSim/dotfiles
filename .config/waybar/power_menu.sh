#!/bin/bash

chosen=$(printf "  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n  Lock" | wofi --dmenu --cache-file /dev/null -p "Power")

case "$chosen" in
    "  Shutdown") systemctl poweroff ;;
    "  Reboot") systemctl reboot ;;
    "  Suspend") systemctl suspend ;;
    "  Hibernate") systemctl hibernate ;;
    "  Lock") swaylock ;;
    *) exit 0 ;;
esac

