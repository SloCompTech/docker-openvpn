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
    run_once "/config/hooks/init/10-network"
fi

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