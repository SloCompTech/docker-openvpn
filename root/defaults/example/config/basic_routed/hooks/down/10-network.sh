#!/usr/bin/with-contenv bash

source /app/lib/settings
source /app/lib/utils

# Check if firewall rules are disabled
useFW
if [ $? -eq 0 ]; then
    # Don't use fw rules
    exit 0
fi

# Don't run if interface persistent
intPersistant
if [ $? -eq 1 ]; then
    exit 0
fi

#
#   Network clear
#
echo "Clearing OpenVPN releated firewall rules"

# Close OpenVPN port to outside
ovpn-iptables -D INPUT -p udp -m udp --dport $PORT -j ACCEPT -m comment --comment "Open OpenVPN port"

# Disable Routing Internet <--> VPN network
ovpn-iptables -D FORWARD -i tun0 -s $NETWORK_ADDRESS/24 -o $OUT_INT -j ACCEPT -m comment --comment "Allow traffic VPN --> Internet"
ovpn-iptables -D FORWARD -i $OUT_INT -d $NETWORK_ADDRESS/24 -o tun0 -j ACCEPT -m comment --comment "Allow traffic Internet --> VPN"

