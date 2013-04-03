#!/bin/bash

# stash possible changes
git stash
cd bundle

for dir in $(ls -1)
do
    echo "Updating $dir .............."
    cd $dir
    git pull origin master
    cd -
done
cd ..

# inform master repo of changes and commit them
git commit -am "Updated all submodules"
git submodule update

# pop stashed changes
git stash pop
