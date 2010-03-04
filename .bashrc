# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now
	return
fi

# Fancier output
alias ls='ls -FG'

# Happy/Sad Prompt 
export PS1='\[\e[1;34m\]\u\[\e[1;30m\]@\[\e[1;36m\]\h \[\e[34m\]\W \[\e[3$((($?))&&echo 1m\]:\(||echo 2m\]:\)) \[\e[30m\]\$ \[\e[0m\]'

# Path for MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
