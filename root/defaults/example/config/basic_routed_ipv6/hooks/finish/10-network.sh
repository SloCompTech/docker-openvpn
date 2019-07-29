#!/usr/bin/with-contenv bash

source /app/hookBaseFirewallDestroy.sh

#
#   Network clear
#
echo "Clearing up basic firewall rules"

# Accept everything from input
ovpn-iptables -P INPUT ACCEPT
ovpn-ip6tables -P INPUT ACCEPT

# Delete: Allow established connection 
ovpn-iptables -D INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Accept traffic from established connections"
ovpn-ip6tables -D INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Accept traffic from established connections"

# Delete: Allow ICMP ping request
ovpn-iptables -D INPUT -p icmp --icmp-type 8 -j ACCEPT
ovpn-ip6tables -D INPUT -p icmp --icmp-type 128 -j ACCEPT

# Accept all forwarded traffic
ovpn-iptables -P FORWARD ACCEPT
ovpn-ip6tables -P FORWARD ACCEPT