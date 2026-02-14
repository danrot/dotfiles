export CDPATH=~/Documents/Development/YumpuNew/:~/Documents/Development/Yumpu/:~/Documents/Development/Personal/
HISTCONTROL=erasedups:ignorespace
HISTSIZE=
HISTFILESIZE=
export PS1='$(exit=$?; if [ $exit -ne 0 ]; then echo "\[\033[0;31m\]$exit "; fi)\[\033[0;35m\]$(date +%H:%M:%S) \[\033[1;34m\]\u@\h \[\033[1;32m\]\W \[\033[0m\]\$ '

bind 'set show-all-if-ambiguous on'

alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color=auto'

dotfiles_root=$(dirname $(dirname $(readlink $BASH_SOURCE)))

if [ $(uname) = "Darwin" ]; then
	source $dotfiles_root/mac/config.sh
fi

source $dotfiles_root/bin/config.sh
source $dotfiles_root/direnv/config.sh
source $dotfiles_root/docker/aliases.sh
source $dotfiles_root/docker/config.sh
source $dotfiles_root/git/aliases.sh
source $dotfiles_root/helix/config.sh
source $dotfiles_root/kitty/aliases.sh
source $dotfiles_root/node/config.sh
