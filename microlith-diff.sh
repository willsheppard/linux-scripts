#!/bin/bash

# Diff the microlith, taking account of modifications

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
for thisdir in $(cat $datafile)
do
    git_exclude="$git_exclude :(exclude,top)$thisdir"
done

# Perform diff
git diff --relative --color --histogram -- :/ $git_exclude $@
#git diff --relative --color --histogram --diff-filter=D $@

echo
# More useful output
git status -- :/ $git_exclude
