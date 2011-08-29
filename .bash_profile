# TODO: Figure out best way to organize a bash_profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Shorthand aliases
alias ls='ls -G'
alias sourceit='source ~/.bash_profile'

# Shortcut for grepping stuff
find_in_files () {
	if [ $# -ne 1 ]
	then
		echo "Whoa buddy, you need to enter a term to search for."
		echo "Example:"
		echo "	ff 'dave'"
	else
		grep -lr -i $1 .
	fi
}

alias ff=find_in_files

# Git info
function parse_git_branch {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	echo "("${ref#refs/heads/}")"
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
WHITE="\e[0;37m"

PS1="$RED\$(date +%H:%M) \W$YELLOW \$(parse_git_branch)$WHITE\$ "

# Node.js stuff
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/share/npm/bin:$PATH"
