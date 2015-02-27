#!/bin/bash

# Catch Ctrl-C and don't do anything (i.e. disable it)

trap '' 2
echo "This is a test. Hit [Ctrl+C] to test it..."
sleep 20
trap 2
