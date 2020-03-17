#!/usr/bin/with-contenv bash

#
#   Network initialization
#
echo "Setting up basic firewall rules"

#
# Because default iptables rules are set to ACCEPT all connection, we need to put some
# security settings in place
#

# Drop everything from input
ovpn-iptables -P INPUT DROP

# Allow established connection 
ovpn-iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Accept traffic from established connections"

# Allow ICMP ping request
ovpn-iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT

# Drop all forwarded traffic
ovpn-iptables -P FORWARD DROP