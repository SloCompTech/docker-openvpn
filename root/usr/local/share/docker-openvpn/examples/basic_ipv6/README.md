# basic_nat_ipv6

Features:  

- Works out of the box on bridge or host network
- Has configuration wizard

## Configure

``` bash
ovpn_enconf basic_nat
#Protocol udp, tcp, udp6, tcp6 [udp]:
#VPN network [10.0.0.0]:
#VPN IPv6 network with CIDR [2001:db8::/32]:
#Port [1194]:
#Public IP or domain of server: <PUBLIC IP>
#DNS1 [8.8.8.8]:
#DNS2 [8.8.4.4]:
```
