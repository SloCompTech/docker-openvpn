# basic_nat_wlp_ipv6

Features:  

- Works out of the box on bridge or host network
- NAT (Network translation protocol)
- Has configuration wizard
- **WITHOUT** LAN protection (does not allow traffic to LANs connected to server), so you can still access devices in LAN (but **routed** example is recommended, because here traffic is still NAT-ed)

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
