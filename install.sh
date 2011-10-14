#!/bin/bash

# Instead of working with dotfiles directly, they've been renamed in git.
# This script "fixes" that.

# circle back and make this more robust
ln -sfv ${PWD}/bash_profile ~/.bash_profile
ln -sfv ${PWD}/bash_profile.osx ~/.bash_profile.osx
ln -sfv ${PWD}/bash_profile.linux ~/.bash_profile.linux
ln -sfv ${PWD}/gitconfig ~/.gitconfig
ln -sfv ${PWD}/screenrc ~/.screenrc
ln -sfv ${PWD}/vim ~/.vim
ln -sfv ${PWD}/vimrc ~/.vimrc
