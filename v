#!/bin/bash

# Choose between helper scripts to open text files...
#
# Depends on other helper scripts "vimline" and "vimmod"

if [[ "$2" == "line" ]]
then
    # use script for copy-and-pasted filename and line number from error messages
    vimline $@

############################################################

elif [[ "$1" =~ "::" ]]
then
    # use script to translate module name into filename
    vimmod $@

############################################################

else
    # assume it's just a filename and use normal vim
    vim $@
fi
