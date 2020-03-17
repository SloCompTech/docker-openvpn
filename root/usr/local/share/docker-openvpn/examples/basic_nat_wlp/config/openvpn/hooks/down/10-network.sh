#!/usr/bin/with-contenv bash

#
#   Network clear
#
echo "Clearing OpenVPN releated firewall rules"

# Close OpenVPN port to outside
ovpn-iptables -D INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Disable Routing Internet <--> VPN network
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -D FORWARD -i $OUT_INT -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

# Disable NAT for VPN traffic
ovpn-iptables -t nat -D POSTROUTING -s $NETWORK_ADDRESS/24 -o $OUT_INT -j MASQUERADE -m comment --comment "NAT traffic VPN --> Internet"
