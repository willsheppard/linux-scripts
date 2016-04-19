#!/bin/bash
 
# Example of arrays in Bash
 
# NICK:IP:TYPE:TIER
NODES=(
    "s:1.2.3.4:STAGING:dev"
    "n1:5.6.7.8:LIVE:production"
)
 
for item in "${NODES[@]}" ; do
    ORIGINALIFS=$IFS
    IFS=':' read -a myarray <<< "$item"
    NODE=${myarray[0]}
    IP=${myarray[1]}
    NODE_TYPE=${myarray[2]}
    NODE_TIER=${myarray[3]}
    IFS=$ORIGINALIFS
    LOWERCASE_TIER=`echo $NODE_TIER | tr '[:upper:]' '[:lower:]'`
 
    # Show variables
    echo "node='$NODE', ip='$IP', node_type='$NODE_TYPE', node_tier='$NODE_TIER', lower_tier='$LOWERCASE_TIER'"
done
