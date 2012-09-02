# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then # Shell is non-interactive.
  return
fi

# If set, the history list is appended to the file named by the value of the
# HISTFILE variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# enable extended globbing. Think extended regex but for globbing
shopt -s extglob

# Taste the UNIX rainbow
if [[ "$(uname -s)" == "Linux" ]]; then
    source ~/.bash_profile.linux
elif [[ "$(uname -s)" == "Darwin" ]]; then
    source ~/.bash_profile.darwin
elif [[ "$(uname -s)" == "SunOS" ]]; then
    source ~/.bash_profile.sunos
fi
