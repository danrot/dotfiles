set dotfiles_root (dirname (dirname (readlink (status -f))))

if test (uname) = "Darwin"
	source $dotfiles_root/mac/config.fish
end

source $dotfiles_root/android/config.fish
source $dotfiles_root/bin/config.fish
source $dotfiles_root/composer/config.fish
source $dotfiles_root/direnv/config.fish
source $dotfiles_root/n/config.fish
source $dotfiles_root/npm/config.fish
source $dotfiles_root/nvim/config.fish
source $dotfiles_root/ruby/config.fish
source $dotfiles_root/tmux/config.fish

set -g fish_user_abbreviations
abbr --add g 'grep'
source $dotfiles_root/composer/aliases.fish
source $dotfiles_root/git/aliases.fish
