#!/bin/bash

declare -a sessions
declare -A session_project_to_path
declare -a windows
declare -A window_project_to_path

sessions=("Delivino")

session_project_to_path["Delivino"]="$HOME/Desktop/codes/Projects/Delivino"

windows=("Delivino:server" "Delivino:web" "Delivino:mobile" "Delivino:business" "Delivino:django-server" "Delivino:web-server" "Delivino:mobile-server" "Delivino:business-server")

window_project_to_path["Delivino:server"]="${session_project_to_path["Delivino"]}/server"
window_project_to_path["Delivino:web"]="${session_project_to_path["Delivino"]}/packages/web"
window_project_to_path["Delivino:mobile"]="${session_project_to_path["Delivino"]}/packages/mobile"
window_project_to_path["Delivino:business"]="${session_project_to_path["Delivino"]}/packages/business"
window_project_to_path["Delivino:django-server"]="${session_project_to_path["Delivino"]}/server"
window_project_to_path["Delivino:web-server"]="${session_project_to_path["Delivino"]}/packages/web"
window_project_to_path["Delivino:mobile-server"]="${session_project_to_path["Delivino"]}/packages/mobile"
window_project_to_path["Delivino:business-server"]="${session_project_to_path["Delivino"]}/packages/business"
window_project_to_path["Delivino:docker"]="${session_project_to_path["Delivino"]}"

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
    tmux has-session -t "$session" &>/dev/null

    if [ $? -eq 0 ]; then
        echo "Session '$session' already exists! Skipping..."
        continue
    else
        echo "Creating session '$session'"
        # Create the new session in detached mode with the first window named "project"

        tmux new-session -s "$session" -n main -d

        tmux send-keys -t "$session:main" "cd ${session_project_to_path[$session]}" C-m "clear" C-m
    fi

    tmux has-session -t "$session"

    if [ $? -eq 0 ]; then
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
