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
    .bash_profile.linux.aliases
    .bash_profile.linux.environment
    .bash_profile.osx.aliases
    .bash_profile.osx.environment
    .gitconfig
    .htoprc
    .screenrc
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

dotfiles=(
    .bash_profile.linux.aliases.fb
)

echo -e "\nPrivate files:"

for file in ${dotfiles[@]}; do
    rm -rf "${HOME}/.${file}"
    ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
done

# ssh config
rm -f "${HOME}/.ssh/config"
ln -sfv "${PWD}/ssh_config.fb" "${HOME}/.ssh/config"

# irssi config
rm -f "${HOME}/.irssi/config"
ln -sfv "${PWD}/irssi_config.fb" "${HOME}/.irssi/config"
