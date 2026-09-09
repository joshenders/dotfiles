#!/bin/bash

function prompt() {
    # usage: prompt "prompt message"

    local message="$1"
    local response

    while [[ -z "${response}" ]]; do
        read -r -p "${message} [y/n] " response

        if [[ "${response}" =~ ^[yY]$ ]]; then
            printf "\n"
            return 0
        elif [[ "${response}" =~ ^[nN]$ ]]; then
            return 1
        else
            unset response
        fi
    done
}


function main() {
    # This script creates symlinks in $HOME for certain files in this directory
    local red=$'\e[0;31m'
    local bold=$'\e[1m'
    local end=$'\e[m'

    echo -e "${red}WARNING:${end} This operation will remove existing files in ${bold}${HOME}${end}.\n\n"

	prompt "Are you ready to install?"

	# FIXME: This is clumsy but works for now

	#
	# Public files
	#

	# Common configs
	local dotfiles=(
		.bash_profile
		.bashrc
		.gitconfig
		.my.cnf
		.tmux.conf
		.screenrc
		.vimrc
		.parallel
	)

	# shellcheck disable=SC2155
	local distro=$(uname -s)

	# distribution specific dotfiles
	case "${distro}" in
		Linux)   dotfiles+=(.bashrc.linux .colordiffrc .config .hushlogin .inputrc) ;;
		Darwin)  dotfiles+=(.bashrc.darwin .colordiffrc .config .inputrc .mitmproxy) ;;
		SunOS)   dotfiles+=(.bashrc.sunos .inputrc) ;;
		FreeBSD) dotfiles+=(.bashrc.freebsd) ;;
	esac

	echo -e "${bold}Installing...${end}\n"

	for file in "${dotfiles[@]}"; do
		rm -rf "${HOME:?}/${file:?}"
		printf "  "
		ln -sfv "${PWD}/${file}" "${HOME}/${file}" # create symlinks for each file pointing here
	done

	prompt "${bold}Would you like to source your new .bashrc now${end}\n"

}

main "$@"
