#!/usr/bin/with-contenv bash

#
#   Network setup
#

# Delete tunnel interface (if not persistant)
if [ -n "$(cat /proc/net/dev | grep $TUNNEL_INTERFACE)" ] && { [ -z "$PERSISTENT_INTERFACE" ] || [ "$PERSISTENT_INTERFACE" != "true" ]; }; then
  echo "Removing $TUNNEL_INTERFACE interface"
	openvpn --rmtun --dev $TUNNEL_INTERFACE
fi