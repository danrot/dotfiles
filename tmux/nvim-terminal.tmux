#!/bin/bash

tmux rename-window $(basename $1)

tmux split-window -h

tmux send-keys -t 0 "cd $1" C-m
tmux send-keys -t 1 "cd $1" C-m

tmux resize-pane -t 0 -x 170

tmux select-pane -t 0

tmux send-keys "nvim ." C-m
