#!/bin/bash

tmux new-window -c ~/Documents/Teaching/FTB-INF-VZ/creating-a-web-application-with-react
tmux rename-window creating-a-web-application-with-react

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m
