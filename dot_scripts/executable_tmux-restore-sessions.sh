#!/bin/bash
set -euo pipefail

CONFIG_FILE="$HOME/.scripts/tmux-sessions.json"

if ! command -v jq &>/dev/null; then
    echo "Error: jq is required but not installed. Please install jq."
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file $CONFIG_FILE not found."
    exit 1
fi

# ---- Utility functions ----

session_exists() {
    tmux has-session -t "$1" 2>/dev/null
}

window_exists() {
    local session="$1"
    local window="$2"
    tmux list-windows -t "$session" | grep -qE "^${window}[[:space:]]"
}

run_commands() {
    local session="$1"
    local window="$2"
    local window_path="$3"
    shift 3
    local cmds=("$@")

    for cmd in "${cmds[@]}"; do
        cmd="${cmd//SESSION_NAME/$session}"
        cmd="${cmd//WINDOW_NAME/$window}"
        cmd="${cmd//WINDOW_PROJECT_PATH/$window_path}"

        eval "$cmd"
    done
}

# ---- Display available sessions ----
sessions=($(jq -r '.sessions[].name' "$CONFIG_FILE"))
letters=({A..Z})
declare -A session_map

echo "Available sessions:"
for i in "${!sessions[@]}"; do
    letter="${letters[$i]}"
    echo "  $letter) ${sessions[$i]}"
    session_map["$letter"]=$i
done

echo
read -rp "Enter letters of sessions to create (e.g. ABF): " choices

choices=$(echo "$choices" | tr '[:lower:]' '[:upper:]')

created_sessions=()

# ---- Process chosen sessions ----
for ((i = 0; i < ${#choices}; i++)); do
    letter="${choices:$i:1}"

    if [[ -z "${session_map[$letter]+x}" ]]; then
        echo "Skipping invalid choice: $letter"
        continue
    fi

    idx="${session_map[$letter]}"
    session_name=$(jq -r ".sessions[$idx].name" "$CONFIG_FILE")
    session_path=$(eval echo "$(jq -r ".sessions[$idx].path" "$CONFIG_FILE")")

    if session_exists "$session_name"; then
        echo "Session '$session_name' already exists, skipping."
    else
        echo "Creating session '$session_name'..."
        tmux new-session -d -s "$session_name" -c "$session_path"
    fi

    # Windows
    windows_count=$(jq ".sessions[$idx].windows | length" "$CONFIG_FILE")
    for ((w = 0; w < windows_count; w++)); do
        window_name=$(jq -r ".sessions[$idx].windows[$w].name" "$CONFIG_FILE")
        window_path=$(eval echo "$(jq -r ".sessions[$idx].windows[$w].path" "$CONFIG_FILE")")

        if window_exists "$session_name" "$window_name"; then
            echo "  Window '$window_name' already exists in session '$session_name', skipping."
            continue
        fi

        echo "  Creating window '$window_name'..."
        tmux new-window -t "$session_name" -n "$window_name" -c "$window_path"
        tmux send-keys -t "$session_name:$window_name" "cd $window_path && clear" C-m

        # Commands
        mapfile -t commands < <(jq -r ".sessions[$idx].windows[$w].commands[]" "$CONFIG_FILE")
        if [ "${#commands[@]}" -gt 0 ]; then
            echo "    Running commands for '$window_name'..."
            run_commands "$session_name" "$window_name" "$window_path" "${commands[@]}"
        fi
    done

    created_sessions+=("$session_name")
done

# ---- Ask to attach ----
if [ "${#created_sessions[@]}" -gt 0 ]; then
    echo
    echo "Created sessions:"
    for i in "${!created_sessions[@]}"; do
        echo "  $((i + 1))) ${created_sessions[$i]}"
    done

    read -rp "Attach to a session? (Enter number or N): " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -le "${#created_sessions[@]}" ]; then
        tmux attach -t "${created_sessions[$((choice - 1))]}"
    else
        echo "Not attaching."
    fi
else
    echo "No sessions were created."
fi
