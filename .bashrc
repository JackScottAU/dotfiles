#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Enable color support for a few tools, if it's supported.
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
fi

# Add my favourite aliases.
alias ll='ls -lhA'
alias lsd='ls -lA'
alias rootify='sudo -Es'
alias vi='nano'		# As per https://twitter.com/FourOctets/status/875199740878635008
alias mkdir='mkdir -p'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

parse_git_branch() {
    git -c color.ui=always branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set a nice colour prompt. Green username (red if sudoing as root), yellow hostname, cyan path.
if [[ $EUID -ne 0 ]]; then
	PS1="\[\e[1;32m\]\u\[\e[m\]@\e[1;33m\h\[\e[m\] \[\e[1;36m\]\w\[\e[m\]\$(parse_git_branch) \[\e[1;32m\]\$\[\e[m\] "
else
	# Note we use $PWD (evaluated at runtime of prompt display) to get around non-root home directories being displayed as '~'.
	PS1='\[\e[1;31m\]\u\[\e[m\]@\e[1;33m\h\[\e[m\] \[\e[1;36m\]$PWD\[\e[m\] \[\e[1;32m\]#\[\e[m\] '
fi

# Set the config and data directories for GPG to match what the XDG specifications say they should be.
alias gpg='gpg --options ~/.config/gnupg/gpg.conf --homedir ~/.local/share/gnupg'
alias gpg2='gpg2 --options ~/.config/gnupg/gpg.conf --homedir ~/.local/share/gnupg'
