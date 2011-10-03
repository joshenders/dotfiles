#!/bin/bash

# Instead of working with dotfiles directly, they've been renamed in git.
# This script "fixes" that.

# circle back and make this more robust
ln -fs ${PWD}/bash_profile ~/.bash_profile
ln -fs ${PWD}/bash_profile.osx ~/.bash_profile.osx
ln -fs ${PWD}/bash_profile.linux ~/.bash_profile.linux
ln -fs ${PWD}/gitconfig ~/.gitconfig
ln -fs ${PWD}/screenrc ~/.screenrc
ln -fs ${PWD}/vimrc ~/.vimrc
