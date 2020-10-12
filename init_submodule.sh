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

../nd_pull.sh --no-rebase --depth 1
cd -

