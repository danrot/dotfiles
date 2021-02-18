#!/bin/bash

tmux new-window -c ~/Documents/Development/sulu
tmux rename-window sulu-dev

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m
