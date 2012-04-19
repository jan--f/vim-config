#!/bin/bash

cd bundle

for dir in $(ls -1)
do
    echo "Updating $dir .............."
    cd $dir
    git pull
    git checkout master
    cd -
done
cd ..
