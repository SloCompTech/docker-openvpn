#!/usr/bin/with-contenv bash

#
# Cleanup tunnel drivers
#

if [ -n "$SKIP_APP" ]; then
  exit 0
fi

config="$(ovpn-confpath)"

device="$(ovpn-dev)"
if [ -z "$device" ]; then
	echo 'Interface not set'
	exit 1
fi

# Delete tunnel interface (if not persistant)
if [ -n "$(cat /proc/net/dev | grep $device)" ] && [ ! -f "/config/persistent-interface" ] && [ -z "$PERSIST_INTERFACE" ]; then
  echo "Removing $device interface"
	openvpn --rmtun --dev $device
fi
