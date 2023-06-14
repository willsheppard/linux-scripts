#!/bin/bash
set -euo pipefail

# Revert modifications made to the checkout of a monolithic git repo,
# restoring it ready for a branch to be pushed upstream.

currentdir=$(pwd)
scriptdir=$(basedir $0 2>/dev/null || dirname $0 2>/dev/null)
datafile="$scriptdir/company/microlith-data"
dirfile="$scriptdir/company/microlith-dir"
fixdir=$( cat $dirfile | grep -v '^#' )
backupdir="/tmp/microlith-backup"

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

# Put .git back
#mv ../.git-for-microlith ./.git

echo "Size:" $(du -hs .)

echo "Microlith finished"
