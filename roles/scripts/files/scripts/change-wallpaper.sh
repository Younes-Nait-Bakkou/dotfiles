#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers"

if [ -z "$1" ]; then
    echo "Usage: $0 <wallpaper-file-or-path>"
    exit 1
fi

# Logic: If the argument is an existing file, use it.
# Otherwise, look for it in the WALLPAPER_DIR.
if [ -f "$1" ]; then
    WALLPAPER_FILE=$(realpath "$1")
else
    WALLPAPER_FILE="$WALLPAPER_DIR/$1"
fi

# Verify the file actually exists before proceeding
if [ ! -f "$WALLPAPER_FILE" ]; then
    echo "Error: Wallpaper file not found: $WALLPAPER_FILE"
    exit 1
fi

# Kill existing wallpaper processes
pkill xwinwrap
pkill feh

# Check extension (case-insensitive)
if [[ "${WALLPAPER_FILE,,}" == *.gif ]]; then
    # Start xwinwrap
    xwinwrap -g 1920x1080+0+0 -ni -ov -fs -- mpv -wid WID --loop --no-audio "$WALLPAPER_FILE" &
    sleep 1

    WINDOW_ID=$(xdotool search --class "mpv" | tail -1)
    if [ -n "$WINDOW_ID" ]; then
        xprop -id "$WINDOW_ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DESKTOP
    fi
else
    feh --bg-fill "$WALLPAPER_FILE"
fi

# Update i3 config variable
sed -i "s|set \$background_wallpaper_image .*|set \$background_wallpaper_image \"$WALLPAPER_FILE\"|" ~/.config/i3/config

echo "Wallpaper changed to: $WALLPAPER_FILE"
