#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-standard
tmux rename-window sulu-standard

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "env SYMFONY_ENV=dev app/console server:run" C-m
