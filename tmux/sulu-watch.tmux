#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu
tmux rename-window sulu-watch

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "php -S 127.0.0.1:8000 -t public config/router.php" C-m

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys "npm run watch" C-m
