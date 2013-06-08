#!/bin/bash

# This script creates symlinks in $HOME for certain files in this directory
red='\e[0;31m'
bold='\e[1m'
end='\e[m'

printf "${red}WARNING:${end} This operation will remove existing files in ${bold}${HOME}${end}.\n\n"

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

# FIXME: This is clumsy but works for now

#
# Public files
#

# Common configs
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
case "$(uname -s)" in
    Linux)   dotfiles=(${dotfiles[@]} .bashrc.linux .hushlogin .config .inputrc) ;;
    Darwin)  dotfiles=(${dotfiles[@]} .bashrc.darwin .inputrc)           ;;
    SunOS)   dotfiles=(${dotfiles[@]} .bashrc.sunos .inputrc)   ;;
    FreeBSD) dotfiles=(${dotfiles[@]} .bashrc.freebsd)          ;;
esac

echo "Installing..."
for file in ${dotfiles[@]}; do
    rm -rf "${HOME}/${file}"
    printf "  "
    ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
done
