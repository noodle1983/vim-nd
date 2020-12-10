#!/bin/bash
rm -rf luarocks
mkdir -p luarocks
cd luarocks
git init .
cat >>.git/config <<END_OF_NEW_BRANCH
[remote "origin"]
        url = https://github.com/luarocks/luarocks.git
        fetch = +refs/heads/master:refs/remotes/origin/master

[branch "master"]
        remote = origin
        merge = refs/heads/master
END_OF_NEW_BRANCH

# git config --global http.proxy http://127.0.0.1:1080
# git config --global https.proxy http://127.0.0.1:1080
../rename2.vim/bin/pull.sh && ./configure --with-lua-include=/usr/local/include && make && make install
cd -

