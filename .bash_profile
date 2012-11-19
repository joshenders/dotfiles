# This file is sourced by login shells

# Some login shells are not interactive and cannot tolerate output. (e.g scp)
if [[ $- != *i* ]]; then # Shell is non-interactive.
    return
fi

# Don't care to maintain separate config files for login and non-login shells
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi
