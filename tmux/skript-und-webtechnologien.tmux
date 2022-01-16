#!/bin/bash

tmux new-window -c ~/Documents/Teaching/FTB-IDI-BB/skript-und-webtechnologien
tmux rename-window skript-und-webtechnologien

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 126
tmux select-pane -t 0

tmux send-keys "nvim ." C-m

tmux select-pane -t 1
tmux split-window -v -c "#{pane_current_path}"
tmux split-window -v -c "#{pane_current_path}"

tmux send-keys -t 2 "ls script.md | entr make script" C-m
tmux send-keys -t 3 "ls slides.md | entr make presentation" C-m

tmux select-pane -t 0
