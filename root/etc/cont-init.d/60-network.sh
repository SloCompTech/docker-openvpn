#!/usr/bin/with-contenv bash

# 
#	Setup tunnel drivers
#
#	@see https://help.skysilk.com/support/solutions/articles/9000136471-how-to-enable-tun-tap-on-linux-vps-with-skysilk
#	@see https://community.openvpn.net/openvpn/wiki/UnprivilegedUser
#	@see https://community.openvpn.net/openvpn/wiki/HOWTO#UnprivilegedmodeLinuxonly
#	@see https://unix.stackexchange.com/questions/18215/which-user-group-can-use-the-tap-net-device
#	@see https://github.com/kylemanna/docker-openvpn/issues/39
#

if [ -n "$SKIP_APP" ]; then
  exit 0
fi

if [ ! -d "/dev/net" ]; then
	echo "Creating /dev/net"
	mkdir -p /dev/net
fi

if [ ! -c "/dev/net/tun" ]; then
	mknod /dev/net/tun c 10 200
	chmod 666 /dev/net/tun
fi

config="$(ovpn-confpath)"

# Configured interface
device="$(ovpn-dev)"
if [ -z "$device" ]; then
	echo 'Interface not set'
	exit 1
fi

# Delete tunnel interface (if not persistant), so no permission errors occur
if [ -n "$(cat /proc/net/dev | grep $device)" ] && [ ! -f "/config/persistent-interface" ] && [ -z "$PERSIST_INTERFACE" ]; then
  echo "Removing $device interface"
	openvpn --rmtun --dev $device
fi

# Create tunnel interface
if [ -z "$(cat /proc/net/dev | grep $device)" ]; then
	echo "Creating $device interface"
	openvpn --mktun --dev $device --dev-type tun --user $CONTAINER_USER --group $CONTAINER_USER
fi
