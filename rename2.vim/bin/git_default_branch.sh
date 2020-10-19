#!/bin/bash
NAME=`git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'`
if [ -n "$NAME" ]; then
    echo "$NAME";
    exit 0
fi

NAME=`git remote show origin | grep "HEAD branch" | cut -d " " -f 5`
if [ -n "$NAME" ]; then
    echo $NAME;
    exit 0
fi
echo "master";
exit 0
