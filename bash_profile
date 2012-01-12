# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then # Shell is non-interactive.
  return
fi

#### Common ####

# unified diff, for human readability
alias diff='diff -u'

# Convenient audible bell alias for alerting
alias bell='printf "\a"'

# confirm and verbose
alias rm='rm -iv'

# Enabled colorized output in tree
alias tree='tree -C'

# Maximum snapshot length for packets (capture the entire packet, not just the default (which is 68 bytes))
alias tcpdump='tcpdump -s0'

# Set preferred editor
export VISUAL=vim # This is checked before $EDITOR on some older utils
export EDITOR=vim

# Enable colorized output in grep
export GREP_COLOR=auto

# Unset bounds on history file. Disk is cheap, unlimited is fine until it's not
# and then I'll rotate
export HISTFILESIZE=
export HISTSIZE=

# Add timestamps to .bash_history
export HISTTIMEFORMAT="%d/%m/%y %T "

# The "ignoreboth" setting ignores repeated lines as well as silently discards
# lines beginning with a space for privacy. Equivalent to 'ignoredups' and
# 'ignorespace'
export HISTCONTROL=ignoreboth

# Commands to not log in history
export HISTIGNORE=ls:cd

# If set, the history list is appended to the file named by the value of the HISTFILE variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# enable extended globbing. Think extended regex but for globbing
shopt -s extglob
 
# Force ls to output ansi escape sequences (colors) even when output is not a terminal, eg. a pipe
export CLICOLOR_FORCE=true

# causes raw control characters to be printed and therefore interpreted by your terminal emulator
export LESS=-R

# export locale
export LC_ALL=
export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

#### OS specific ####

if [[ "$(uname -s)" == "Linux" ]]; then
    source ~/.bash_profile.linux
elif [[ "$(uname -s)" == "Darwin" ]]; then
    source ~/.bash_profile.osx
fi
