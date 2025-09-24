#!/bin/bash
VIM_DIR_NAME=vim$(egrep '\s(VIM_VERSION_MAJOR|VIM_VERSION_MINOR)\s' vim/src/version.h |tr -cd 0-9)
echo "VIM_DIR_NAME=${VIM_DIR_NAME}"

cd vim
export CFLAGS=-fPIC
./configure  \
	--with-features=huge \
	--enable-fontset \
	--enable-cscope \
	--enable-multibyte \
	--enable-pythoninterp \
	--with-python-config-dir=/usr/lib64/python2.7/config \
	--enable-python3interp \
	--with-python3-config-dir=/usr/lib64/python3.6/config \
	--enable-luainterp \
	--enable-rubyinterp \
	--enable-perlinterp \
	--enable-multibyte \
	--with-compiledby="brooksj" \
	--disable-gui \
	--without-x \
	--prefix=$HOME/$VIM_DIR_NAME 
make install
cd -


tar -C ./rename2.vim/ --exclude='bin' --exclude='readme' --exclude='vimrc' -cf - '.' | tar -C $HOME/$VIM_DIR_NAME/share/vim/*/ -xf - 
tar -C ./rename2.vim/ -cf - 'bin' | tar -C $HOME/$VIM_DIR_NAME/ -xf - 
cp ./rename2.vim/vimrc ~/.vimrc
cat >$HOME/$VIM_DIR_NAME/bin/setenv <<END_SET_ENV
export PATH=~/$VIM_DIR_NAME/bin:\$PATH
export VIM=~/$VIM_DIR_NAME/share/vim/$VIM_DIR_NAME
#export CSCOPE_DB=./cscope.out:./cscope.in.out:./cscope.po.out
END_SET_ENV

chmod +x $HOME/$VIM_DIR_NAME/bin/setenv
echo "source ~/$VIM_DIR_NAME/bin/setenv" >> ~/.bashrc


