#!/bin/bash

tmux new-window -c ~/Documents/Teaching/FTB-IDI-BB/softwareentwurf-und-implementierung
tmux rename-window softwareentwurf-und-implementierung

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m
