#!/bin/bash

tmux new-window -c ~/Documents/Development/danrot.github.io
tmux rename-window danielrotter

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 126
tmux send-keys "bundle exec jekyll serve" C-m

tmux select-pane -t 0
tmux send-keys "nvim ." C-m
