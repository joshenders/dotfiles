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

dotfiles=(
    .bash_profile
    .bash_profile.linux
    .bash_profile.osx
    .bash_profile.oi
    .gitconfig
    .htoprc
    .screenrc
    .vimrc
    .my.cnf
) 

echo "Installing..."
for file in ${dotfiles[@]}; do
    rm -rf "${HOME}/.${file}"
    ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
done
