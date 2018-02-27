#!/bin/bash

# Find files

TERM="$1"
DIR=${2:-.}
set -x
find $DIR -name "$TERM"
