# This file is sourced by non-login shells (and .bash_profile)

# If set, the history list is appended to the file named by the value of the
# HISTFILE variable when the shell exits, rather than overwriting the file.
shopt -s histappend

# enable extended globbing. Think extended regex but for globbing
shopt -s extglob

# Remove all bash completion statements. I never use it and it seems to slow
# down the shell and pollute the environment.
type complete >/dev/null 2>&1 && complete -r

# Taste the Unix rainbow
if [[ "$(uname -s)" == "Linux" ]]; then
    source ~/.bashrc.linux
elif [[ "$(uname -s)" == "Darwin" ]]; then
    source ~/.bashrc.darwin
elif [[ "$(uname -s)" == "SunOS" ]]; then
    source ~/.bashrc.sunos
fi
