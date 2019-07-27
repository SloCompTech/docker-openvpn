#!/usr/bin/with-contenv bash

#
#	Pre-checks for firewall related hooks
#

# Check if firewall rules are disabled
if [ "$USE_FIREWALL" == "false" ]; then
    exit 0 # Don't use fw rules
fi

# Run script only once if persistent interface
# @see https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
if [ "$PERSISTENT_INTERFACE" == "true" ]; then
    flagFile="$(realpath $0).flag"
    if [ -f "$flagFile" ]; then
        exit 0 # Flag file exists, exit
    fi
    touch $flagFile
fi