#!/bin/fish

tmux new-window -c ~/Development/danrot/danrot.github.io
tmux rename-window danielrotter
tmux send-keys "nvim ." C-m

tmux split-window -h -c "#{pane_current_path}"
tmux send-keys "bundle exec jekyll serve" C-m

tmux resize-pane -t 0 -x 126
