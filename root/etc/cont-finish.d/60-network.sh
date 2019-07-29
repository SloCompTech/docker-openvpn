#!/usr/bin/with-contenv bash

#
#   Network setup
#

# Delete tunnel interface (if not persistant)
if [ -n "$(cat /proc/net/dev | grep tun0)" ] && { [ -z "$PERSISTENT_INTERFACE" ] || [ "$PERSISTENT_INTERFACE" != "true" ]; }; then
  echo "Removing tun0 interface"
	openvpn --rmtun --dev tun0
fi