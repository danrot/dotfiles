#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-minimal
tmux rename-window sulu-watch

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "bin/console server:run" C-m

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys "npm run watch" C-m
