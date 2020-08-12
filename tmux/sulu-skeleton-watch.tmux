#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-skeleton
tmux rename-window sulu-skeleton-watch

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "php -S 127.0.0.1:8001 -t public config/router.php" C-m

tmux split-window -v -c "#{pane_current_path}"
tmux send-keys "cd assets/admin" C-m
tmux send-keys "npm run watch" C-m
