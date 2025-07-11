#!/bin/bash

session=$(tmux display-message -p '#S')

tmux list-panes -s -F '#{session_name}:#{window_index}.#{pane_index}' | grep "^$session:" | while read -r pane; do
    tmux send-keys -t "$pane" 'cd .' C-m "clear" C-m
done
