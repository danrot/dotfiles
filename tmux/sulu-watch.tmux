#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-skeleton
tmux rename-window sulu-watch

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "bin/console server:run" C-m

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys "cd assets/admin" C-m
tmux send-keys "npm run watch" C-m
