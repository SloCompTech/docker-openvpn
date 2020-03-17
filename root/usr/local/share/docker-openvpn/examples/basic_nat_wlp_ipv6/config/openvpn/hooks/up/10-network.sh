#!/usr/bin/with-contenv bash

#
#   Network initialization
#
echo "Setting up OpenVPN related firewall rules"

# Open OpenVPN port to outside
ovpn-iptables -A INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"
ovpn-ip6tables -A INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Allow Routing Internet <--> VPN network
ovpn-iptables -A FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -A FORWARD -i $OUT_INT -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"
ovpn-ip6tables -A FORWARD -i tun0 -s $NETWORK_ADDRESS_IPV6 -o $OUT_INT -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-ip6tables -A FORWARD -i $OUT_INT -d $NETWORK_ADDRESS_IPV6 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

# Preform NAT for VPN traffic
ovpn-iptables -t nat -A POSTROUTING -s $NETWORK_ADDRESS/24 -o $OUT_INT -j MASQUERADE -m comment --comment "NAT traffic VPN --> Internet"
ovpn-ip6tables -t nat -A POSTROUTING -s $NETWORK_ADDRESS_IPV6 -o $OUT_INT -j MASQUERADE -m comment --comment "NAT traffic VPN --> Internet"