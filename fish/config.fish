set -U fish_color_autosuggestion 4D5566
set -U fish_color_cancel \x2d\x2dreverse
set -U fish_color_command 39BAE6
set -U fish_color_comment 626A73
set -U fish_color_cwd 59C2FF
set -U fish_color_cwd_root red
set -U fish_color_end F29668
set -U fish_color_error FF3333
set -U fish_color_escape 95E6CB
set -U fish_color_history_current \x2d\x2dbold
set -U fish_color_host normal
set -U fish_color_host_remote \x1d
set -U fish_color_keyword \x1d
set -U fish_color_match F07178
set -U fish_color_normal B3B1AD
set -U fish_color_operator E6B450
set -U fish_color_option \x1d
set -U fish_color_param B3B1AD
set -U fish_color_quote C2D94C
set -U fish_color_redirection FFEE99
set -U fish_color_search_match \x2d\x2dbackground\x3dE6B450
set -U fish_color_selection \x2d\x2dbackground\x3dE6B450
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path \x2d\x2dunderline

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
source $dotfiles_root/rust/config.fish

set -g fish_user_abbreviations

abbr --add g 'grep'
abbr --add ~dev --position anywhere ~/Documents/Development
bind '/' expand-abbr self-insert

source $dotfiles_root/composer/aliases.fish
source $dotfiles_root/docker/aliases.fish
source $dotfiles_root/git/aliases.fish
source $dotfiles_root/kitty/aliases.fish
