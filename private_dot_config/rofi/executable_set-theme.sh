#!/bin/bash

theme="$1"
config="$HOME/.config/rofi/config.rasi"
theme_path="~/.config/rofi/themes/$theme/launcher.rasi"

# Check if theme launcher exists (expanding ~)
theme_file="$HOME/.config/rofi/themes/$theme/launcher.rasi"
if [ ! -f "$theme_file" ]; then
    echo "Theme '$theme' does not exist."
    echo -n "Available themes: "
    ls -1 "$HOME/.config/rofi/themes" | grep -vE 'config\.rasi|set-theme\.sh' | paste -sd'|' -
    echo
    exit 1
fi

# If config.rasi doesn't exist, create a default with import + overrides
if [ ! -f "$config" ]; then
    cat >"$config" <<EOF
@import "$theme_path"

/* Put your overrides below */
window {
    font: "JetBrains Mono 10";
}
EOF
    echo "Created new config with theme $theme"
    exit 0
fi

# Replace the existing @import line (if any) with the new one, leave other lines intact
# If no @import line found, add it at the top

if grep -q "^@import " "$config"; then
    # Replace existing @import line
    sed -i "s|^@import .*|@import \"$theme_path\"|" "$config"
else
    # Add @import line at the top
    sed -i "1i @import \"$theme_path\"" "$config"
fi

echo "Updated theme import to $theme in $config"
