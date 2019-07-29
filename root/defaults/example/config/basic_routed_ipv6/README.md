# basic_routed_ipv6

Features:  

- Has configuration wizard
- Prepared for using routing (so you will have access to LANs directly without using NAT)

## Configure

``` bash
ovpn_enconf basic_routed
#Protocol udp, tcp, udp6, tcp6 [udp]:
#VPN network [10.0.0.0]:
#VPN IPv6 network with CIDR [2001:db8::/32]:
#Port [1194]:
#Public IP or domain of server: <PUBLIC IP>
#DNS1 [8.8.8.8]:
#DNS2 [8.8.4.4]:
```

### Network configuration

1. If you are using **bridge** networking mode else skip this step:

	- Assign static IP to this container  
	- see [docker compose networks](https://docs.docker.com/compose/compose-file/compose-file-v2/#networks), you can also check current IP of container
			with `docker exec -it CONTAINERNAME ifconfig`  
	- Add static route on host to the container with network

		``` bash
				route add -net NETWORK netmask MASK gw CONTAINER_IP
		```

2. Add route to the network on your router

	- Destination IP Address: NETWORK
	- Subnet mask: MASK
	- Gateway: SERVERIP_OR_CONTAINERIP (IP where your OpenVPN server is running: server ip when bridge mode, container ip on host mode)

	![Sample interface](img/img1.png)  

3. If you have Mikrotik or Cisco router make sure you have NAT correctly configured
4. Make sure you have firewall rules correctly configured on your router
5. Add additional routes in *server config* if nessesary (see [--route option](https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage)), default route is set as default gateway  

	``` OpenVPN
	route network/IP [netmask] [gateway] [metric]
	```
