#!/bin/bash
#1. install
#yum install -y lua-devel luarocks

#luarocks install luacheck
luarocks install https://raw.githubusercontent.com/luarocks/luacheck/master/luacheck-dev-1.rockspec
luarocks install lanes

#2. install pathogen
mkdir -p $VIM/autoload $VIM/bundle && wget -O $VIM/autoload/pathogen.vim https://tpo.pe/pathogen.vim
[ -f $VIM/autoload/pathogen.vim ] || ( echo 'failed to install pathogen!'; exit -1 )

#3. install syntastic
cd $VIM/bundle && git clone --depth=1 https://github.com/vim-syntastic/syntastic.git
cd -
[ -d $VIM/bundle/syntastic ] || ( echo 'failed to clone syntastic!'; exit -1 )

#4. add to vimrc
sed -i -e "/syntastic/d" -e "/pathogen/d" ~/.vimrc
cat >>~/.vimrc <<END_SET_ENV

execute pathogen#infect()
let g:syntastic_check_on_open = 1
let g:syntastic_lua_checkers = ["luac", "luacheck"]
let g:syntastic_lua_luacheck_args = "--no-unused-args"
let g:syntastic_cpp_config_file = "./.syntastic_cpp_config"
let g:syntastic_c_config_file = "./.syntastic_c_config"
END_SET_ENV

