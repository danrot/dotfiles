#!/bin/fish

tmux new-window -c ~/Development/sulu/sulu-minimal/vendor/sulu/sulu
tmux rename-window sulu-dev

tmux send-keys "nvim ." C-m

tmux split-window -h -c "#{pane_current_path}"
tmux resize-pane -t 0 -x 124
