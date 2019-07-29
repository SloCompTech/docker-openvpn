#!/usr/bin/with-contenv bash

#
#	Pre-checks for firewall destruction related hooks
#

# Check if firewall rules are disabled
if [ "$USE_FIREWALL" == "false" ]; then
  exit 0 # Don't use fw rules
fi

# Don't run if persistent interface
if [ "$PERSISTENT_INTERFACE" == "true" ]; then
  exit 0  
fi
