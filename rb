#!/bin/bash

# Convenience script for "git rebase" command
# Calls another convenience script "gitrebase"

NUMBER=$1
if [[ -z $NUMBER ]]
then
    echo "usage: rb [number of revisions]"
    exit 1
fi
gitrebase --autosquash -i HEAD~$NUMBER
