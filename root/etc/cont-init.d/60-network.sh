#!/usr/bin/with-contenv bash

# 
# 	Setup tunnel driver
#
#	  @see https://help.skysilk.com/support/solutions/articles/9000136471-how-to-enable-tun-tap-on-linux-vps-with-skysilk
#	  @see https://community.openvpn.net/openvpn/wiki/UnprivilegedUser
#	  @see https://unix.stackexchange.com/questions/18215/which-user-group-can-use-the-tap-net-device
#

if [ ! -d "/dev/net" ]; then
	echo "Creating /dev/net"
	mkdir -p /dev/net
fi

if [ ! -c "/dev/net/tun" ]; then
	mknod /dev/net/tun c 10 200
	chmod 666 /dev/net/tun
fi

# Remove existing interface if not persistent interface selected
if [ -n "$(cat /proc/net/dev | grep tun0)" ] && { [ -z "$PERSISTENT_INTERFACE" ]  ||  [ "$PERSISTENT_INTERFACE" != "true" ]; }; then
  echo "Removing tun0 interface"
	openvpn --rmtun --dev tun0
fi

# Create tunnel interface
if [ -z "$(cat /proc/net/dev | grep tun0)" ]; then
	echo "Creating tun0 interface"
	openvpn --mktun --dev tun0 --dev-type tun --user abc --group abc
fi
