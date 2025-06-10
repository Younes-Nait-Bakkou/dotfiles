#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers"

if [ -z "$1" ]; then
    echo "Usage: $0 <wallpaper-file>"
    exit 1
fi

WALLPAPER_FILE="$WALLPAPER_DIR/$1"

if [ ! -f "$WALLPAPER_FILE" ]; then
    echo "Error: Wallpaper file not found: $WALLPAPER_FILE"
    exit 1
fi

# Kill existing wallpaper processes
pkill xwinwrap
pkill feh

if [[ "$1" == *.gif ]]; then
    # Start xwinwrap and mark the window as a desktop background
    xwinwrap -g 1920x1080+0+0 -ni -ov -fs -- mpv -wid WID --loop --no-audio "$WALLPAPER_FILE" &
    sleep 1 # Wait for the window to spawn

    # Use xprop to set the window type to "desktop"
    WINDOW_ID=$(xdotool search --class "mpv" | tail -1)
    if [ ! -z "$WINDOW_ID" ]; then
        xprop -id "$WINDOW_ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DESKTOP
    fi
else
    feh --bg-fill "$WALLPAPER_FILE"
fi

# Update i3 config variable (optional)
sed -i "s|set \$background_wallpaper_image .*|set \$background_wallpaper_image $WALLPAPER_FILE|" ~/.config/i3/config

echo "Wallpaper changed to: $WALLPAPER_FILE"
