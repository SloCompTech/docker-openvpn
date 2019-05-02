#!/usr/bin/with-contenv bash

source /app/lib/settings
source /app/lib/utils

# Check if firewall rules are disabled
useFW
if [ $? -eq 0 ]; then
    # Don't use fw rules
    exit 0
fi

# Run only once if interface persistent
intPersistant
if [ $? -eq 1 ]; then
    run_once "/config/hooks/up/10-network"
fi

#
#   Network initialization
#
echo "Setting up OpenVPN related firewall rules"

# Open OpenVPN port to outside
ovpn-iptables -A INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Protect LANs after VPN
ovpn-iptables -A FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -d 10.0.0.0/8 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"
ovpn-iptables -A FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -d 192.168.0.0/16 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"
ovpn-iptables -A FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -d 172.16.0.0/12 -j REJECT -m comment --comment "Drop traffic VPN --> LANs"

# Allow Routing Internet <--> VPN network
ovpn-iptables -A FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -A FORWARD -i $OUT_INT -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

# Preform NAT for VPN traffic
ovpn-iptables -t nat -A POSTROUTING -s $NETWORK_ADDRESS/24 -o $OUT_INT -j MASQUERADE -m comment --comment "NAT traffic VPN --> Internet"

