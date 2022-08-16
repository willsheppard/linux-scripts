#!/bin/bash

# Modify the checkout of a monolithic git repo,
# making it easier to work with.

fixdir="$HOME/<YOUR_DIR_HERE>"
currentdir=$(pwd)
scriptdir=$(basedir $0 2>/dev/null || dirname $0 2>/dev/null)
datafile="$scriptdir/microlith-data"

# SETUP

if [[ "$currentdir" != "$fixdir" ]]
then
    echo "Only permitted in dir: $fixdir"
    exit 1
fi

# MAIN

echo "Size:" $(du -hs .)

for thisdir in $(cat $datafile)
do
    echo "removing: $thisdir"
    rm -rf "./$thisdir"
done

echo "Size:" $(du -hs .)

echo "Microlith started"
