#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-minimal
tmux rename-window sulu-minimal-watch

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "env SYMFONY_ENV=dev bin/console server:run" C-m
