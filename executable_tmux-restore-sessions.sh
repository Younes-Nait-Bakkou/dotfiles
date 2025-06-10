#!/bin/bash

declare -a sessions
declare -A session_project_to_path
declare -a windows
declare -A window_project_to_path
declare -A window_to_commands

sessions=("Arnabix" "Email-testing" "Coreedge" "Automize" "VeriFlow" "GasFlow" "AGR" "Expo-Tuto" "weather-app" "oui-gaz" "Delivino" "Knowplus")

session_project_to_path["Arnabix"]="$HOME/Desktop/codes/Projects/Arnabix"
session_project_to_path["oui-gaz"]="$HOME/Desktop/codes/Projects/oui-gaz"
session_project_to_path["Email-testing"]="$HOME/Desktop/codes/Python/E2E-email-testing"
session_project_to_path["Coreedge"]="$HOME/Desktop/codes/Projects/Coreedge"
session_project_to_path["Automize"]="$HOME/Desktop/codes/Projects/Automize"
session_project_to_path["VeriFlow"]="$HOME/Desktop/codes/Projects/VeriFlow"
session_project_to_path["GasFlow"]="$HOME/Desktop/codes/Projects/GasFlow"
session_project_to_path["AGR"]="$HOME/Desktop/codes/Projects/AGR"
session_project_to_path["Expo-Tuto"]="$HOME/Desktop/codes/React-Native/Expo-Tutorial"
session_project_to_path["weather-app"]="$HOME/Desktop/codes/React-Native/Weather-App"
session_project_to_path["Delivino"]="$HOME/Desktop/codes/Projects/Delivino"
session_project_to_path["Knowplus"]="$HOME/Desktop/codes/Projects/Knowplus"

windows=("Arnabix:server" "Arnabix:web" "Arnabix:mobile" "Arnabix:business" "Arnabix:django-server" "Arnabix:web-server" "Arnabix:mobile-server" "Arnabix:business-server" "Email-testing:scripts" "Email-testing:execution" "Coreedge:server" "Coreedge:django-server" "Automize:server" "Automize:django-server" "VeriFlow:server" "VeriFlow:django-server" "GasFlow:server" "GasFlow:django-server" "AGR:server" "AGR:laravel-server" "Expo-Tuto:code" "Expo-Tuto:mobile-server" "weather-app:code" "weather-app:mobile-server" "oui-gaz:server" "oui-gaz:client" "oui-gaz:django-server" "oui-gaz:web-server" "Delivino:server" "Delivino:django-server" "Knowplus:server" "Knowplus:django-server")

window_project_to_path["Arnabix:server"]="${session_project_to_path["Arnabix"]}/server"
window_project_to_path["Arnabix:web"]="${session_project_to_path["Arnabix"]}/packages/web"
window_project_to_path["Arnabix:mobile"]="${session_project_to_path["Arnabix"]}/packages/mobile"
window_project_to_path["Arnabix:business"]="${session_project_to_path["Arnabix"]}/packages/business"
window_project_to_path["Arnabix:django-server"]="${session_project_to_path["Arnabix"]}/server"
window_project_to_path["Arnabix:web-server"]="${session_project_to_path["Arnabix"]}/packages/web"
window_project_to_path["Arnabix:mobile-server"]="${session_project_to_path["Arnabix"]}/packages/mobile"
window_project_to_path["Arnabix:business-server"]="${session_project_to_path["Arnabix"]}/packages/business"
window_project_to_path["Arnabix:docker"]="${session_project_to_path["Arnabix"]}"

window_project_to_path["oui-gaz:server"]="${session_project_to_path["oui-gaz"]}/server"
window_project_to_path["oui-gaz:client"]="${session_project_to_path["oui-gaz"]}/client"
window_project_to_path["oui-gaz:django-server"]="${session_project_to_path["oui-gaz"]}/server"
window_project_to_path["oui-gaz:web-server"]="${session_project_to_path["oui-gaz"]}/client"

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

window_project_to_path["AGR:server"]="${session_project_to_path["AGR"]}"
window_project_to_path["AGR:laravel-server"]="${session_project_to_path["AGR"]}"

window_project_to_path["Expo-Tuto:code"]="${session_project_to_path["Expo-Tuto"]}"
window_project_to_path["Expo-Tuto:mobile-server"]="${session_project_to_path["Expo-Tuto"]}"

window_project_to_path["weather-app:code"]="${session_project_to_path["weather-app"]}"
window_project_to_path["weather-app:mobile-server"]="${session_project_to_path["weather-app"]}"

window_project_to_path["Delivino:server"]="${session_project_to_path["Delivino"]}"
window_project_to_path["Delivino:django-server"]="${session_project_to_path["Delivino"]}"

window_project_to_path["Knowplus:server"]="${session_project_to_path["Knowplus"]}"
window_project_to_path["Knowplus:django-server"]="${session_project_to_path["Knowplus"]}"

window_to_commands["Arnabix:server"]=""
window_to_commands["Arnabix:web"]=""
window_to_commands["Arnabix:mobile"]=""
window_to_commands["Arnabix:business"]=""
window_to_commands["Arnabix:django-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'venvshell' C-m 'django runserver' C-m;
tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m 'venvshell' C-m;"
window_to_commands["Arnabix:web-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'yarn dev' C-m; tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m;"
window_to_commands["Arnabix:mobile-server"]=""
window_to_commands["Arnabix:business-server"]=""
window_to_commands["Arnabix:docker"]=""

window_to_commands["oui-gaz:django-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'venvshell' C-m 'django runserver' C-m;
tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m 'venvshell' C-m;"
window_to_commands["oui-gaz:web-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'npm run dev' C-m; tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m;"

window_to_commands["Delivino:django-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'venvshell' C-m 'django runserver' C-m;
tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m 'venvshell' C-m;"

window_to_commands["Knowplus:django-server"]="tmux split-window -t SESSION_NAME:WINDOW_NAME; tmux send-keys -t SESSION_NAME:WINDOW_NAME.1 'venvshell' C-m 'django runserver' C-m;
tmux send-keys -t SESSION_NAME:WINDOW_NAME.2 'cd WINDOW_PROJECT_PATH' C-m 'venvshell' C-m;"

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

    # Check if answer is "Y" or "y" (default to N)
    if [[ "$should_create_session" != "Y" && "$should_create_session" != "y" ]]; then
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
