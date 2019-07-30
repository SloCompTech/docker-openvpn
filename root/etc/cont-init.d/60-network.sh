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
if [ -n "$(cat /proc/net/dev | grep $TUNNEL_INTERFACE)" ] && { [ -z "$PERSISTENT_INTERFACE" ]  ||  [ "$PERSISTENT_INTERFACE" != "true" ]; }; then
  echo "Removing $TUNNEL_INTERFACE interface"
	openvpn --rmtun --dev $TUNNEL_INTERFACE
fi

# Create tunnel interface
if [ -z "$(cat /proc/net/dev | grep $TUNNEL_INTERFACE)" ]; then
	echo "Creating $TUNNEL_INTERFACE interface"
	openvpn --mktun --dev $TUNNEL_INTERFACE --dev-type tun --user $CONTAINER_USER --group $CONTAINER_USER
fi
