#!/bin/bash
rm -rf vim
mkdir -p vim
cd vim 
git init .
git remote add origin https://github.com/vim/vim.git 

cat >>.git/config <<END_OF_NEW_BRANCH
[branch "master"]
        remote = origin
        merge = refs/heads/master
END_OF_NEW_BRANCH

# git config --global http.proxy http://127.0.0.1:1080
# git config --global https.proxy http://127.0.0.1:1080
../rename2.vim/bin/fetch.sh --depth 1
git checkout -b master origin/master
cd -

