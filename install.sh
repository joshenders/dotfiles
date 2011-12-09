#!/bin/bash

# Instead of working with dotfiles directly, they've been renamed in git.
# This script addresses that and moves them in to $HOME.

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

dotfiles=(
    bash_profile
    bash_profile.linux
    bash_profile.osx
    gitconfig
    htoprc
    screenrc
    vim
    vimrc
    my.cnf
) 

for file in ${dotfiles[@]}; do
    echo "Working on $file"

    if [[ -e "${HOME}/.${file}" ]]; then
        rm -rfv "${HOME}/.${file}"
    fi
    ln -sfv "${PWD}/${file}" "${HOME}/.${file}"
done