#!/usr/bin/with-contenv bash

#
#   Network clear
#
echo "Clearing up basic firewall rules"

# Accept everything from input
ovpn-iptables -P INPUT ACCEPT

# Delete: Allow established connection 
ovpn-iptables -D INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Accept traffic from established connections"

# Delete: Allow ICMP ping request
ovpn-iptables -D INPUT -p icmp --icmp-type 8 -j ACCEPT

# Accept all forwarded traffic
ovpn-iptables -P FORWARD ACCEPT
