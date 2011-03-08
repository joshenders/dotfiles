# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then # Shell is non-interactive.
  return
fi

# would be great if this were pull and not push...and tested if
# the file has changed before it needlessly syncs.. or you know
# under version control :P
function updaterc() {
  for dotfile in ~/.vimrc ~/.bashrc ~/.screenrc ~/.irssi/config; do
    echo "Syncing ${dotfile}"
    scp ${dotfile} jenders@oak-ss-admin002:/u/jenders/${dotfile#/*/*/}
    scp ${dotfile} jenders@oak-ss-admin002:/data/home/jenders/${dotfile#/*/*/}
    # This is hardcoded for now but we should really do our best effort to find the current IP in case it changes
    scp ${dotfile} jenders@lan-190-sf2-it-gw1.sixapart.net:/Users/jenders/${dotfile#/*/*/}
    # sudo cp -v ${dotfile} /var/root/
    echo 
  done
}

function rmkey() {
  # this is so shameful, we should just sync host keys
  if [[ $# -lt '1' ]]; then
    echo "usage: $FUNCNAME <host>"
  else
    host="$1"
    sed -i -e "s/^${host}.*//g" ~/.ssh/known_hosts || { echo "Could not remove public key for ${host}"; exit 1; }
  fi
}

# GNU and BSD userland are JUST enough different to be annoying so let's split this file up

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

# Keep bash history sync'd between multiple terminals. Reread histfile and flush unwritten commands at every prompt
export PROMPT_COMMAND="history -na"

# The "ignoredups" setting ignores repeated lines. 
export HISTCONTROL=ignoredups

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


#### Linux specific

if [[ "$(uname -s)" == "Linux" ]]; then
  
  function xenfo() {
    if [[ $# -gt '0' ]]; then
      echo "usage: $FUNCNAME"
    else
      if [[ -x /usr/local/bin/runon ]]; then
        runon oak-dev-xen "echo \"  free memory : \$((\$(xm info | grep free_memory | cut -d: -f2)/1024))G\" ; echo '  free disk   : '\$(df -h /data | tail -n1 | tr -s ' ' | cut -d' ' -f4)"
      else
        echo "$FUNCNAME: runon is not installed in /usr/local/bin" >&2
      fi
    fi
  }

  function upstage() {
    if [[ $# -gt '0' ]]; then
      echo "usage: $FUNCNAME"
    else
      if [[ -e /staging ]]; then
        ( cd ~/repos/git/ops && git pull && git push && ssh root@oak-ss-admin003 "cd /staging && sudo git pull" )
      fi
    fi
  }

  function whichcluster() {
    if [[ $# -ne '1' ]]; then
      echo "Usage: $FUNCNAME query"
    else
      highest=69
      lowest=1
      class=oak-tp-web
      host=$(echo ${class}$(printf "%03d\n" "$[($RANDOM % ($[${highest} - ${lowest}] + 1 )) + ${lowest}]"))
      port=22
      alive=$(nc -z ${host} ${port} >/dev/null; echo $?)

      if [[ "${alive}" -eq '0' ]]; then
        cluster=$(ssh -o StrictHostKeyChecking=no ${host} "grep -RhA3 \"$1\" /home/comet/typepad/*/conf/events.yaml | grep cluster | head -n1 | awk '{ print \$2 }'")
        
        if [[ -z "${cluster}" ]]; then
          echo "Cannot determine cluster for job $1" >&2
        else
          echo ${cluster}
        fi
      else
        echo "${host} is not connectable on port ${port}!" >&2 
      fi
    fi
  }

  function whichxen() {
    if [[ $# -ne 1 ]]; then
      echo "Usage: $FUNCNAME query" >&2
    else
      if [[ -x /usr/local/bin/runon ]]; then
        { runon oak-dev-xen "ls /etc/xen/configs -l | grep $1" | grep -B1 $1; } || echo "unable to locate $1" >&2
      else
        echo "$FUNCNAME: runon is not installed in /usr/local/bin" >&2
      fi
    fi
  }

  function admin-user() {
    if [[ $# -ne '2' ]]; then
      echo "Usage: $FUNCNAME <uid|xid|uri> query"
    else
      highest=50
      lowest=1
      class=oak-tp-web
      host=$(echo ${class}$(printf "%03d\n" "$[($RANDOM % ($[${highest} - ${lowest}] + 1 )) + ${lowest}]"))
      port=22
      alive=$(nc -z ${host} ${port} > /dev/null; echo $?)

      if [[ "${alive}" -eq '0' ]]; then
        case $1 in 
          uid)
            record=$(ssh -o StrictHostKeyChecking=no root@${host} "sudo -u comet /home/comet/typepad/archetype/tools/admin-user --info $2 2>&1 | grep -i 'User ID' | cut -d' ' -f3")
            if [[ -z "${record}" ]]; then 
              echo "Cannot determine $1 for $2"
            else
              echo ${record}
            fi          
            ;;
          xid)
            record=$(ssh -o StrictHostKeyChecking=no root@${host} "sudo -u comet /home/comet/typepad/archetype/tools/admin-user --info $2 2>&1 | grep -i $1 | cut -d' ' -f2")
            if [[ -z "${record}" ]]; then 
              echo "Cannot determine $1 for $2"
            else
              echo ${record}
            fi          
            ;;
          uri)
            record=$(ssh -o StrictHostKeyChecking=no root@${host} "sudo -u comet /home/comet/typepad/archetype/tools/admin-user --info $2 2>&1 | grep -i $1 | cut -d' ' -f2")
            if [[ -z "${record}" ]]; then 
              echo "Cannot determine $1 for $2"
            else
              echo ${record}
            fi          
            ;;
        esac
      else
        echo "${host} is not connectable on port ${port}!" 
      fi
    fi
  }

  # time stamps and 79 chars wide
  alias strace='strace -T -s79'

  # Colorized output and classification
  alias ls='ls --color=auto -F'

  # only display ipv4 addresses in output
  alias ip='ip -4'

  # Exotic vless alias (functionality of less + syntax highlighting from vim) similar to `view`
  vimVersion=$(vim --version | head -n1 | cut -d' ' -f5 | sed 's/\.//g')

  if [[ -f "/usr/share/vim/vim${vimVersion}/macros/less.sh" && -f "/usr/share/vim/vim${vimVersion}/macros/less.vim" ]]; then
    alias vless="/usr/share/vim/vim${vimVersion}/macros/less.sh"
  fi
  
  unset vimVersion
  
  # Colorful prompt
  if ! [[ $EUID == "0" ]]; then
    export PS1='\[\e[0;37m\]\u\[\e[1;30m\]@\[\e[0;32m\]\h${SSH_TTY#/dev}: \[\e[34m\]\W \[\e[30m\]\$ \[\e[0m\]'
  else # you are root and you get darkprompt(tm)
    export PS1='\[\e[1;30m\]\h:\W \$ \[\e[0m\]'
  fi

  # Prefix sbin before normal path because who likes tying typing /sbin/$util 
  export PATH=~/bin:/usr/local/sbin:/sbin:/usr/sbin:$PATH
fi

#### Darwin specific

if [[ "$(uname -s)" == "Darwin" ]]; then
  
  # fix for Network Connect in Snow Leopard
  # - http://forums.juniper.net/t5/SSL-VPN/Snow-Leopard-Network-Connect-Fix/m-p/25056
  function fixnc() {
    sudo chmod 755 /usr/local/juniper/nc/*.*.*/
    sudo mkdir '/Applications/Network Connect.app/Contents/Frameworks'
  }

  # Colorized output and classification
  alias ls='ls -FG'

  # Lock screen
  alias lock='/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'   
 
  # Happy/Sad Prompt
  if ! [[ $EUID == "0" ]]; then
    export PS1='\[\e[1;34m\]\u\[\e[1;30m\]@\[\e[1;36m\]\h \[\e[34m\]\W \[\e[3$((($?))&&echo 1m\]:\(||echo 2m\]:\)) \[\e[30m\]\$ \[\e[0m\]'
  else # you are root and you get darkprompt(tm)
    export PS1='\[\e[1;30m\]\h:\W \$ \[\e[0m\]'
  fi
 
  # Path for MacPorts
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH

  # Prevent history from being logged (accidental password disclosures, embarassing career ending mistakes, etc)
  export HISTFILE=/dev/null

  # Source bash_completion
  # FIXME: broken as of 1/13/11
  #if [[ -f /opt/local/etc/bash_completion ]]; then
  #  source /opt/local/etc/bash_completion
  #fi
fi
