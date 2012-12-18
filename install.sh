#!/bin/bash

# This script creates symlinks in $HOME for certain files in this directory

# FIXME: these should really be backed up, this will sting at some point
printf "WARNING: This operation will remove existing files in $HOME.\n\n"

while [[ -z "$response" ]]; do
    read -p "Are you ready to install? [y/n] " response
    
    if [[ "$response" =~ ^[yY]$ ]]; then
	printf "\n"
        break
    elif [[ "$response" =~ ^[nN]$ ]]; then
        exit 1
    else
        unset response
    fi
done

# FIXME: This is not elegant but works for now

#
# Public files
#

# General configs
dotfiles=(
    .bash_profile
    .bashrc
    .gitconfig
    .htoprc
    .screenrc
    .vimrc
    .my.cnf
)

# distribution specific dotfiles
if [[ "$(uname -s)" == "Linux" ]]; then
    dotfiles=(${dotfiles[@]} .bashrc.linux .hushlogin)
elif [[ "$(uname -s)" == "Darwin" ]]; then
    dotfiles=(${dotfiles[@]} .bashrc.darwin)
elif [[ "$(uname -s)" == "SunOS" ]]; then
    dotfiles=(${dotfiles[@]} .bashrc.sunos .inputrc)
fi

echo "Installing..."
for file in ${dotfiles[@]}; do
    rm -rf "${HOME}/.${file}"
    ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
done
