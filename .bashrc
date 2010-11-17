# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then # Shell is non-interactive.
  return
fi

function macgen() {
  echo $(dd if=/dev/urandom count=1 2>/dev/null | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/')
}

function rmkey() {
  if [[ $# -lt '1' ]]; then
    echo "usage: $FUNCNAME <host>"
  else
    host="$1"
    sed -i -e "s/^${host}.*//g" ~/.ssh/known_hosts || { echo "Could not remove public key for ${host}"; exit 1; }
  fi
}

# Linux and BSD userland are JUST enough different to be annoying so let's split this file up
#### Common

# unified diff, for human readability
alias diff='diff -u'

# Convenient audible bell alias for alerting
alias bell='echo -ne "\a"'

# Ask and verbose
alias rm='rm -iv'

# Enabled colorized output in tree
alias tree='tree -C'

# Maximum snapshot length for packets (capture the entire packet, not just the default (which is 68 bytes))
alias tcpdump='tcpdump -s0'

# Set preferred editor
export EDITOR=vim

# Enable colorized output in grep
export GREP_COLOR=auto

# Add timestamps to .bash_history
export HISTTIMEFORMAT="%d/%m/%y %T "

# The "ignoredups" setting ignores repeated lines. 
export HISTCONTROL=ignoredups

# Commands to not log in history
export HISTIGNORE=ls:cd

# If set, the history list is appended to the file named by the value of the HISTFILE variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# Force ls to output ansi escape sequences (colors) even when output is not a terminal, eg. a pipe
export CLICOLOR_FORCE=true

# causes raw control characters to be printed and therefore interpreted
export LESS=-R

# Exotic vless alias (functionality of less + syntax highlighting from vim)
vimVersion=$(vim --version | head -n1 | cut -d' ' -f5 | sed 's/\.//g')

if [[ -f "/usr/share/vim/vim${vimVersion}/macros/less.sh" && -f "/usr/share/vim/vim${vimVersion}/macros/less.vim" ]]; then
  alias vless="/usr/share/vim/vim${vimVersion}/macros/less.sh"
fi

unset vimVersion

#### Linux specific

if [[ "$(uname -s)" == "Linux" ]]; then
  # Colorized output and classification
  alias ls='ls --color=auto -F'

  # only display ipv4 addresses in output
  alias ip='ip -4'

  # Colorful prompt
  if [[ ! $EUID == "0" ]]; then
    export PS1='\[\e[0;37m\]\u\[\e[1;30m\]@\[\e[0;32m\]\h${SSH_TTY#/dev}: \[\e[34m\]\W \[\e[30m\]\$ \[\e[0m\]'
  else # you are root and you get darkprompt(tm)
    export PS1='\[\e[1;30m\]\h:\W \$ \[\e[0m\]'
  fi

  # Prefix sbin before normal path because I hate typing /sbin/${util}
  export PATH=~/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
fi

#### Darwin specific

if [[ "$(uname -s)" == "Darwin" ]]; then
  # Colorized output and classification
  alias ls='ls -FG'

  # Lock screen
  alias lock='/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'   
 
  # Happy/Sad Prompt
  if [[ ! $EUID == "0" ]]; then
    export PS1='\[\e[1;34m\]\u\[\e[1;30m\]@\[\e[1;36m\]\h \[\e[34m\]\W \[\e[3$((($?))&&echo 1m\]:\(||echo 2m\]:\)) \[\e[30m\]\$ \[\e[0m\]'
  else # you are root and you get darkprompt(tm)
    export PS1='\[\e[1;30m\]\h:\W \$ \[\e[0m\]'
  fi
 
  # Path for MacPorts
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH

  # Prevent history from being logged (accidental password disclosures, embarassing career ending mistakes, etc)
  export HISTFILE=/dev/null

  # Source bash_completion
#  if [[ -f /opt/local/etc/bash_completion ]]; then
#    source /opt/local/etc/bash_completion
#  fi
fi
