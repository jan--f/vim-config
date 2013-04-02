#!/bin/bash

# stash possible changes
git stash
cd bundle

for dir in $(ls -1)
do
    echo "Updating $dir .............."
    cd $dir
    git checkout master
    git pull
    cd -
done
cd ..
# inform master repo of changes and commit them
git submodule update
git commit -am "Updated all submodules"

# pop stashed changes
git stash pop
