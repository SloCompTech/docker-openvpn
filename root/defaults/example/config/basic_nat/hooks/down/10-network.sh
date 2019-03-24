#!/bin/bash

#
#   Network clear
#

# Close OpenVPN port to outside
ovpn-iptables -D INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Disable LAN protection of VPN
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o eth0 -d 10.0.0.0/8 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o eth0 -d 192.168.0.0/16 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o eth0 -d 172.16.0.0/12 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"

# Disable Routing Internet <--> VPN network
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o eth0 -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -D FORWARD -i eth0 -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

# Disable NAT for VPN traffic
ovpn-iptables -t nat -D POSTROUTING -s $NETWORK_ADDRESS/24 -o eth0 -j MASQUERADE -m comment --comment "NAT traffic VPN --> Internet"

