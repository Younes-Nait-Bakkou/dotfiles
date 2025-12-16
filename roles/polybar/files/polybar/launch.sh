#!/usr/bin/env bash

theme="${1:-blocks}" # Default to 'blocks' if no argument
THEME_PATH="$HOME/.config/polybar/themes/$theme/config.ini"
MAIN_CONFIG="$HOME/.config/polybar/main.ini"

# Validate theme config exists
if [ ! -f "$THEME_PATH" ]; then
    echo "❌ Theme '$theme' not found."
    echo -n "Available themes: "
    ls -1 ~/.config/polybar/themes | paste -sd'|' -
    exit 1
fi

# Use a relative path so Polybar resolves includes properly
rel_theme_path="./themes/$theme/config.ini"
sed -i "s|^include-file = .*themes/.*/config.ini|include-file = $rel_theme_path|" "$MAIN_CONFIG"

# Kill existing Polybar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar
polybar -q main -c "$MAIN_CONFIG" &
