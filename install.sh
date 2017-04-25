#!/bin/bash

#search nessesary tools installed.
git_exist=0
git --version > /dev/null && git_exist=1 || gitexist=0
if test "x$git_exist" = "x0"; then
	echo "error: git not installed"
	exit
fi

vim_exist=0
vim --version > /dev/null && vim_exist=1 || vim_exist=0
if test "x$vim_exist" = "x0"; then
	echo "error: vim not installed"
	exit
fi

old_dir=`pwd`
cd ~

vimrc_exist=
if test -e ".vimrc"; then
	vimrc_exist=".vimrc"
	mv ~/.vimrc ~/.vimrc.bak
fi

git config --global core.autocrlf false

echo "installing & updating tm_vimcfg..."
tmp_dir="./tmp_vimrc"
git clone https://github.com/yangyinqi/tm_vimcfg $tmp_dir
cp $tmp_dir/.vimrc ~/
rm -rf $tmp_dir

echo "installing & updating Vundle..."
if test ! -e "~/.vim/bundle/Vundle.vim"; then
	git clone https://github.com/VundleVim/Vundle.vim.git ".vim/bundle/Vundle.vim"
fi

vim +BundleInstall +qall

#do some extra environment checking
ctags_exist=0
ctags --version > /dev/null && ctags_exist=1 || ctags_exist=0
if test "x$ctags_exist" = "x0"; then
	echo "warning: ctags/exuberant ctags not installed, you should install it
	for tagbar"
fi

echo "You may compile 'YouCompleteMe' by yourself in order to use the code
completition function"
echo "See https://github.com/Valloric/YouCompleteMe/blob/master/README.md for
detail and installation steps"

cd $old_dir
