#!/bin/bash

set -e

BASE_DIR="$HOME/browsers-data-dir"
APPS_DIR="$HOME/.local/share/applications"

mkdir -p "$BASE_DIR/brave" "$BASE_DIR/chrome" "$APPS_DIR"

# Define:
# browser;command;icon;default_profile_dir;profiles
BROWSERS=(
    "brave;brave-browser;brave-browser;$HOME/.config/BraveSoftware/Brave-Browser/Default;development research entertainment project-management"
    "chrome;google-chrome;google-chrome;$HOME/.config/google-chrome/Default;dev personal media"
)

copy_default_profile() {
    local src="$1"
    local dst="$2"

    if [ -d "$src" ]; then
        if [ ! -d "$dst" ]; then
            echo "Copying default profile from $src to $dst"
            cp -r "$src" "$dst"
        else
            echo "Profile directory $dst already exists, skipping copy"
        fi
    else
        echo "Warning: Default profile directory $src does not exist. Creating empty profile directory $dst."
        mkdir -p "$dst"
    fi
}

for entry in "${BROWSERS[@]}"; do
    IFS=';' read -r browser cmd icon default_profile_dir profiles <<<"$entry"

    for profile in $profiles; do
        PROFILE_DIR="$BASE_DIR/$browser/$profile"

        # Copy default profile if needed

        copy_default_profile "$default_profile_dir" "$PROFILE_DIR"

        DESKTOP_FILE="$APPS_DIR/${browser}-${profile}.desktop"

        cat >"$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=$(tr '[:lower:]' '[:upper:]' <<<"${browser:0:1}")${browser:1} ${profile^}
Exec=${cmd} --user-data-dir="${PROFILE_DIR}" --class="${profile}"
Icon=${icon}
Terminal=false
StartupWMClass=${profile}
Categories=Network;WebBrowser;
EOF

        echo "Created: $DESKTOP_FILE"
    done
done
