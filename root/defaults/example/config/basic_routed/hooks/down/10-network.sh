#!/bin/bash

#
#   Network clear
#

# Close OpenVPN port to outside
ovpn-iptables -D INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Disable Routing Internet <--> VPN network
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o eth0 -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -D FORWARD -i eth0 -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

