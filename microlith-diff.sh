#!/bin/bash
set -euo pipefail

# Diff the microlith, taking account of modifications

currentdir=$(pwd)
scriptdir=$(basedir $0 2>/dev/null || dirname $0 2>/dev/null)
datafile="$scriptdir/company/microlith-data"
dirfile="$scriptdir/company/microlith-dir"
fixdir=$( cat $dirfile | grep -v '^#' )

# SETUP

if [[ "$currentdir" != "$fixdir" ]]
then
    echo "Only permitted in dir: $fixdir"
    exit 1
fi

if [[ ! -e "$datafile" ]]
then
    echo "missing $datafile"
    exit 1
fi

# MAIN

# Display a visual divider
perl -le'$tr = ("=") x 120; print $tr for 1..2'

# Build exclusions command
git_exclude=""
git_exclude=":(exclude,top)adcourier.broadbean" # $current_job
for thisdir in $(cat $datafile)
do
    git_exclude="$git_exclude :(exclude,top)$thisdir"
done

# Temporarily restore .git
#mv ../.git-for-microlith .git

# Perform diff
git diff --relative --color --histogram $@ -- :/ $git_exclude
#git diff --relative --color --histogram --diff-filter=D $@

echo
# More useful output
git status $@ -- :/ $git_exclude

# Move .git out of the way again
#mv .git ../.git-for-microlith
