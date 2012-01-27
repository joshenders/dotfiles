#!/bin/bash

# This script creates symlinks in $HOME for certain files in this directory

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

#
# Public files
#

dotfiles=(
    .bash_profile
    .bash_profile.linux
    .bash_profile.osx
    .gitconfig
    .htoprc
    .screenrc
    .vim
    .vimrc
    .my.cnf
) 

echo "Public files:"
for file in ${dotfiles[@]}; do
    rm -rf "${HOME}/.${file}"
    ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
done

#
# Private files
#

echo -e "\nPrivate files:"

# ssh config
rm -f "${HOME}/.ssh/config"
ln -sfv "${PWD}/ssh_config" "${HOME}/.ssh/config"

# irssi config
rm -f "${HOME}/.irssi/config"
ln -sfv "${PWD}/irssi_config" "${HOME}/.irssi/config"
