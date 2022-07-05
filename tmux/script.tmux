#!/bin/bash

tmux rename-window $(basename $1)

tmux send-keys "cd $1" C-m

tmux split-window -h -c "$1"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m

tmux select-pane -t 1
tmux split-window -v -c "$1"
tmux split-window -v -c "$1"

tmux send-keys -t 2 "ls script.md | entr make script" C-m
tmux send-keys -t 3 "ls slides.md | entr make presentation" C-m

tmux select-pane -t 0
