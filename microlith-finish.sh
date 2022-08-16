#!/bin/bash

# Revert modifications made to the checkout of a monolithic git repo,
# restoring it ready for a branch to be pushed upstream.

fixdir="$HOME/dev/p5-adcourier-sync"
currentdir=$(pwd)
scriptdir=$(basedir $0 2>/dev/null || dirname $0 2>/dev/null)
datafile="$scriptdir/microlith-data"

# SETUP

if [[ "$currentdir" != "$fixdir" ]]
then
    echo "Only permitted in dir: $fixdir"
    exit 1
fi

echo "Size:" $(du -hs .)

# Restore the missing directories
for thisdir in $(cat $datafile)
do
    echo "restoring: $thisdir"
    git checkout "$thisdir"
done

echo "Size:" $(du -hs .)

echo "Microlith finished"
