#!/bin/bash

# creates symlinks for each file in the user's $HOME

cd ${0%/*}

# finds all regular files except under .git or *.sh files
FILES=($(find . -path ./.git -prune -o -type f -a ! -name *.sh -printf "%p "))

for file in ${FILES[@]}; do
    name=${file:2}
    ln -fsv $(pwd)/$name $HOME/$name
done
