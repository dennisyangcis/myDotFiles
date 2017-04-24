#!/bin/bash

#search nessesary tools installed.
exist=0
git --version > /dev/null && exist=1 || exist=0
if test "x$exist" = "x0"; then
	echo "error: git not installed"
	exit
fi

exist=0
vim --version > /dev/null && exist=1 || exist=0
if test "x$exist" = "x0"; then
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

cd $old_dir
