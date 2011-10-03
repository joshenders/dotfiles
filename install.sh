#!/bin/bash

# Instead of working with dotfiles directly, they've been renamed in git.
# This script "fixes" that.

# circle back and make this more robust
ln -s bashrc ~/.bash_profile
ln -s bash_profile.osx ~/.bash_profile.osx
ln -s bash_profile.linux ~/.bash_profile.linux
ln -s gitconfig ~/.gitconfig
ln -s screenrc ~/.screenrc
ln -s vimrc ~/.vimrc
