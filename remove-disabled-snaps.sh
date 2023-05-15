#!/bin/bash
# https://gitlab.com/snippets/1927120

set -eu -o pipefail

if (( $# )) ; then
    cat << HELP
Looks for inactive snaps and removes them.

There are no command line options.
You will be asked to confirm before removal.

HELP
    echo -n 'Requires curl: ' ; type curl
    echo -n 'Requires jq: ' ; type jq
    exit 1
fi

BOLD=$'\e[1m'
UNBOLD=$'\e[22m'

function list-snaps {
    # According to https://github.com/snapcore/snapd/wiki/REST-API
    curl --silent --show-error \
        --get --data select=all \
        --unix-socket /run/snapd.socket \
        http://localhost/v2/snaps
}

function filter-disabled {
    jq --raw-output '
        .result[] | 
        select(.status != "active") | 
        "snap remove --revision=\(.revision|@sh) \(.name|@sh)"
'
}

remove_cmds=$(list-snaps | filter-disabled)

if [ -z "${remove_cmds}" ] ; then
    echo No inactive snaps found.
    exit 0
fi

echo "${BOLD}To remove:${UNBOLD}"
# -v screens out control characters that might obscure what we're about to sudo
cat -nv <<< "${remove_cmds}"
echo
read -rp "${BOLD}Run these commands with sudo? [yes/no]${UNBOLD} "

case "$REPLY" in
    [Yy]*) ;;
    *)
        echo Cancelling.
        exit 1
	;;
esac

exec sudo -- bash -es <<< "${remove_cmds}"

