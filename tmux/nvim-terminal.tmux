#!/bin/bash

tmux rename-window $(basename $1)

tmux send-keys "cd $1" C-m

tmux split-window -h -c "$1"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m
