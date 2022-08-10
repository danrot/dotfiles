#!/bin/bash

tmux rename-window $(basename $1)

tmux split-window -h
tmux split-window -v
tmux split-window -v

tmux send-keys -t 0 "cd $1" C-m
tmux send-keys -t 1 "cd $1" C-m
tmux send-keys -t 2 "cd $1" C-m
tmux send-keys -t 3 "cd $1" C-m

tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m

tmux send-keys -t 2 "ls script.md | entr make script" C-m
tmux send-keys -t 3 "ls slides.md | entr make presentation" C-m
