#!/bin/bash
set -euo pipefail

# Modify the checkout of a monolithic git repo,
# making it easier to work with.

currentdir=$(pwd)
scriptdir=$(basedir $0 2>/dev/null || dirname $0 2>/dev/null)
datafile="$scriptdir/company/microlith-data"
dirfile="$scriptdir/company/microlith-dir"
fixdir=$( cat $dirfile | grep -v '^#' )
backupdir="/tmp/microlith-backup"
mkdir -p "$backupdir"

# SETUP

if [[ "$currentdir" != "$fixdir" ]]
then
    echo "Only permitted in dir: $fixdir"
    exit 1
fi

# MAIN

echo "Size:" $(du -hs .)

# Remove unwanted directories
for thisdir in $(cat $datafile)
do
    echo "removing: $thisdir"
    rm -rf "./$thisdir"
done

# Move .git out of the way
#mv .git ../.git-for-microlith

echo "Size:" $(du -hs .)

echo "Microlith started"
