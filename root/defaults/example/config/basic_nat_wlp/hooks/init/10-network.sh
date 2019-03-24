#!/bin/bash

#
#   Network initialization
#

#
# Because default iptables rules are set to ACCEPT all connection, we need to put some
# security settings in place
#

# Drop everything from input
ovpn-iptables -P INPUT DROP

# Allow established connection 
ovpn-iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT -m comment --comment "Accept traffic from established connections"

# Drop all forwarded traffic
ovpn-iptables -P FORWARD DROP