#!/bin/bash

declare -a sessions
declare -A session_project_to_path
declare -a windows
declare -A window_project_to_path
declare -A window_to_commands

sessions=("Delivino" "Email-testing" "Coreedge" "Automize" "VeriFlow" "GasFlow")

session_project_to_path["Delivino"]="$HOME/Desktop/codes/Projects/Delivino"
session_project_to_path["Email-testing"]="$HOME/Desktop/codes/Python/E2E-email-testing"
session_project_to_path["Coreedge"]="$HOME/Desktop/codes/Projects/Coreedge"
session_project_to_path["Automize"]="$HOME/Desktop/codes/Projects/Automize"
session_project_to_path["VeriFlow"]="$HOME/Desktop/codes/Projects/VeriFlow"
session_project_to_path["GasFlow"]="$HOME/Desktop/codes/Projects/GasFlow"

windows=("Delivino:server" "Delivino:web" "Delivino:mobile" "Delivino:business" "Delivino:django-server" "Delivino:web-server" "Delivino:mobile-server" "Delivino:business-server" "Email-testing:scripts" "Email-testing:execution" "Coreedge:server" "Coreedge:django-server" "Automize:server" "Automize:django-server" "VeriFlow:server" "VeriFlow:django-server" "GasFlow:server" "GasFlow:django-server")

window_project_to_path["Delivino:server"]="${session_project_to_path["Delivino"]}/server"
window_project_to_path["Delivino:web"]="${session_project_to_path["Delivino"]}/packages/web"
window_project_to_path["Delivino:mobile"]="${session_project_to_path["Delivino"]}/packages/mobile"
window_project_to_path["Delivino:business"]="${session_project_to_path["Delivino"]}/packages/business"
window_project_to_path["Delivino:django-server"]="${session_project_to_path["Delivino"]}/server"
window_project_to_path["Delivino:web-server"]="${session_project_to_path["Delivino"]}/packages/web"
window_project_to_path["Delivino:mobile-server"]="${session_project_to_path["Delivino"]}/packages/mobile"
window_project_to_path["Delivino:business-server"]="${session_project_to_path["Delivino"]}/packages/business"
window_project_to_path["Delivino:docker"]="${session_project_to_path["Delivino"]}"

window_project_to_path["Email-testing:scripts"]="${session_project_to_path["Email-testing"]}"
window_project_to_path["Email-testing:execution"]="${session_project_to_path["Email-testing"]}"

window_project_to_path["Coreedge:server"]="${session_project_to_path["Coreedge"]}"
window_project_to_path["Coreedge:django-server"]="${session_project_to_path["Coreedge"]}"

window_project_to_path["Automize:server"]="${session_project_to_path["Automize"]}"
window_project_to_path["Automize:django-server"]="${session_project_to_path["Automize"]}"

window_project_to_path["VeriFlow:server"]="${session_project_to_path["VeriFlow"]}"
window_project_to_path["VeriFlow:django-server"]="${session_project_to_path["VeriFlow"]}"

window_project_to_path["GasFlow:server"]="${session_project_to_path["GasFlow"]}"
window_project_to_path["GasFlow:django-server"]="${session_project_to_path["GasFlow"]}"

window_to_commands["Delivino:server"]=""
window_to_commands["Delivino:web"]=""
window_to_commands["Delivino:mobile"]=""
window_to_commands["Delivino:business"]=""
window_to_commands["Delivino:django-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'venvshell' C-m 'django runserver' C-m;
tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m 'venvshell' C-m;"
window_to_commands["Delivino:web-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'yarn dev' C-m; tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m;"
window_to_commands["Delivino:mobile-server"]=""
window_to_commands["Delivino:business-server"]=""
window_to_commands["Delivino:docker"]=""

check_session_exists() {
    if tmux has-session -t "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

for i in "${!sessions[@]}"; do
    session=${sessions[$i]}

    echo "Would you like to create this session '$session' (y/N): "
    read -r should_create_session

    # Check if answer is "N" or "n" (default to N)
    if [[ "$should_create_session" == "N" || "$should_create_session" == "n" ]]; then
        echo "Skipping session '$session'"
        continue
    fi

    # If the session already exists, skip it.
    if check_session_exists "$session"; then
        echo "Session '$session' already exists! Skipping..."
        continue

    else
        echo "Creating session '$session'"

        # Create the new session in detached mode with the first window named "project"
        tmux new-session -s "$session" -n main -d

        tmux send-keys -t "$session:main" "cd ${session_project_to_path[$session]}" C-m "clear" C-m
    fi

    if check_session_exists "$session"; then
        echo "Session '$session' created successfully!"
    fi
done

initial_window_cmd="cd WINDOW_PROJECT_PATH"
new_window_cmd="tmux new-window -n WINDOW_NAME -t SESSION_NAME: "

for i in "${!windows[@]}"; do
    window=${windows[$i]}

    IFS=":" read -r sess win <<<"$window"

    window_path="${window_project_to_path["$sess:$win"]}"

    if [ ! -d "$window_path" ]; then
        echo "No path found for session '$sess' and window '$win'. Would you like to create this path? (y/N): "
        read -r should_create_path

        if [[ $should_create_path == "N" || $should_create_path == "n" ]]; then
            echo "Skipping..."
            continue
        else
            mkdir -p "$window_path"
        fi
    fi

    tmux list-windows -t "$sess" | grep -q "$win" &>/dev/null

    if [ $? -eq 0 ]; then
        echo "Window '$win' already exists. Skipping..."
        continue
    fi

    cmd="${new_window_cmd//SESSION_NAME/$sess}"
    cmd="${cmd//WINDOW_NAME/$win}"

    echo "Creating window $win with command: $cmd"
    eval "$cmd"

    initialize_cmd="${initial_window_cmd//WINDOW_PROJECT_PATH/$window_path}"
    echo "Initializing window with command: $initialize_cmd"
    tmux send-keys -t "$sess:$win" "$initialize_cmd" C-m "clear" C-m
done

for i in "${!window_to_commands[@]}"; do
    cmd=${window_to_commands[$i]}

    IFS=":" read -r sess win <<<"$i"

    echo "Running command for window '$sess:$win': $cmd"
    if ! check_session_exists "$sess:$win"; then
        echo "Session or window '$sess:$win' does not exist. Skipping..."
        continue
    fi

    if [ "$cmd" = "" ]; then
        echo "No command found for window '$sess:$win'. Skipping..."
        continue
    fi

    window_path="${window_project_to_path["$sess:$win"]}"
    cmd="${cmd//SESSION_NAME/$sess}"
    cmd="${cmd//WINDOW_NAME/$win}"
    cmd="${cmd//WINDOW_PROJECT_PATH/$window_path}"

    echo "Evaluating command: $cmd"
    eval "$cmd"
done

echo "Would you like to attach to a session? (y/N): "
read -r attach_choice

if [[ "$attach_choice" == "y" || "$attach_choice" == "Y" ]]; then

    while true; do

        echo "Enter session name to attach to: "
        read -r session_name

        tmux list-sessions | grep "$session_name" &>/dev/null

        if [ $? -eq 0 ]; then
            tmux attach -t "$session_name"
            break
        else
            echo "Invalid session name: $session_name, retrying..."
        fi

    done

fi
