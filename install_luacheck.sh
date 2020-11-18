#!/bin/bash
rm -rf luarocks
mkdir -p luarocks
cd luarocks
git init .
git remote add origin https://github.com/luarocks/luarocks.git
cat >>.git/config <<END_OF_NEW_BRANCH

[branch "master"]
        remote = origin
        merge = refs/heads/master
END_OF_NEW_BRANCH

# git config --global http.proxy http://127.0.0.1:1080
# git config --global https.proxy http://127.0.0.1:1080
../pull.sh && ./configure --with-lua-include=/usr/local/include && make && make install
cd -

