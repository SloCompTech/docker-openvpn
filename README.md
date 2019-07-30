
# [slocomptech/docker-openvpn](https://github.com/SloCompTech/docker-openvpn)

[![](https://images.microbadger.com/badges/version/slocomptech/openvpn.svg)](https://microbadger.com/images/slocomptech/openvpn "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/slocomptech/openvpn.svg)](https://microbadger.com/images/slocomptech/openvpn "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/slocomptech/openvpn.svg)](https://microbadger.com/images/slocomptech/openvpn "Get your own commit badge on microbadger.com") ![](https://img.shields.io/docker/cloud/automated/slocomptech/openvpn.svg) ![](https://img.shields.io/docker/cloud/build/slocomptech/openvpn.svg)

Features:  

- OpenVPN running as non-root user (limited permission)
- Containerized (Isolated environment)
- Easy managed (Helper scripts).
- Easy start (Simple first-start guide).
- Easly modified to your needs (see [docs](CONTRIBUTING.md)).
- Easy scripting (python3 installed).

## Usage

Here are some example snippets to help you get started creating a container.  

### docker

``` bash
# Normal start command (but you need to setup config first)
docker run \
  --name=ovpn \
  --cap-add NET_ADMIN \
  -e PUID=1000 \
  -e GUID=1000 \
  -p 1194:1194/udp \
  -v </path/o/config>:/config \
  --restart=unless-stopped \
  --network host \
  slocomptech/openvpn:latest
```

### docker-compose

``` yml
version: '2.2'
services:
  ovpn:
    image: slocomptech/openvpn
    container_name: ovpn
    hostname: ovpn
    cap_add:
      - NET_ADMIN
    ports:
      - "1194:1194/udp"
    volumes:
      - ./data:/config
    environment:
      - PUID=1000
      - PGUID=1000
    restart: on-failure
    # If you want to build from source add build:
    build:
      context: .
    sysctls: # For IPv6
      - net.ipv6.conf.all.disable_ipv6=0
      - net.ipv6.conf.default.forwarding=1
      - net.ipv6.conf.all.forwarding=1
    network_mode: host

```

## Parameters

|**Parameter**|**Function**|
|:-----------:|:----------:|
|`-e FAIL_MODE=hard`|Restart whole container on error|
|`-e PUID=1000`|for UserID - see below for explanation|
|`-e PGID=1000`|for GroupID - see below for explanation|
|`-e PERSISTENT_INTERFACE=true`|Enable persistent TUN interface|
|`-e TUNNEL_INTERFACE="tun0"`|Tunnel interface name (default: tun0)|
|`-e USE_FIREWALL=false`|Disable any firewall related rules to be created, modified ... (must be implemented in example)|
|`-v /config`|All the config files including OpenVPNs reside here|
|`-v /log`|Log files reside here|

See also: [EasyRSA](https://github.com/OpenVPN/easy-rsa/blob/master/doc/EasyRSA-Advanced.md)  

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application setup

### Initial setup

If you are new to containers please see rather [Detailed first setup guide](docs/SetupGuide.md), because it includes more detailed description.

1. Init configuration directory with initial config files:

  ``` bash
  docker run -it --rm --cap-add NET_ADMIN -v </path/to/config>:/config slocomptech/openvpn:latest bash
  ```

2. At this point you will have bash shell which runs in container. Now run following commands to setup your PKI:

  ``` bash
  ovpn pki init [nopass] # Inits PKI
  ```

3. Setup OpenVPN config based on example `basic_nat` with configuration wizard:  

  ``` bash
  ovpn enconf basic_nat
  #Out interface [eth0]: <interface connected to the Internet>
  #Protocol udp, tcp, udp6, tcp6 [udp]:
  #VPN network [10.0.0.0]:
  #Port [1194]:
  #Public IP or domain of server: <YOUR PUBLIC IP>
  #DNS1 [8.8.8.8]:
  #DNS2 [8.8.4.4]:
  ```

4. Enable **port forwarding** on your router so OpenVPN server will be accessible from the internet.
5. Add clients

  ``` bash
  # Generates client certificates
  ovpn client add <name> [nopass]

  # Generates client config file and saves it to /config/tmp
  ovpn client ovpn <name>

  # OR BETTER SOLLUTION: Run outside container
  docker exec -it <container name> ovpn client ovpnp <name> > <config file>.ovpn
  ```

5. Exit container with `exit`, then it will destroy itself.
6. Start container using command specified in *Usage* section.

For more infromation see:

- [Detailed first setup guide](docs/SetupGuide.md)  
- [docs](docs) (for detailed command usage)  
- **configuration example directory** (for more info about example)  
- [Contributing](CONTRIBUTING.md) (for explanation how container works, how to write an example config ...)  

### Client mode

Just put *.ovpn* file in `/config/openvpn/config` and restart container.

## Troubleshooting

- [OpenVPN troubleshoot guide](https://community.openvpn.net/openvpn/wiki/HOWTO#Troubleshooting)  

### Cannot ioctl TUNSETIFF tun0: Operation not permitted (errno=1)

Just manualy remove **tun0**  manually `openvpn --rmtun --dev tun0`.

## Contribute

Feel free to contribute new features to this container, but first see [Contribute Guide](CONTRIBUTING.md).

## TODO

Planed features:

Wanted features (please help implement):

- LDAP authentication script
- Google authenticator

## Licenses

- [This project](LICENSE.md)  
- [OpenVPN](https://openvpn.net/terms/)  
- [Base image](https://github.com/linuxserver/docker-baseimage-alpine)  
- [s6 Layer](https://github.com/just-containers/s6-overlay/blob/master/LICENSE.md)  

## Versions

See [CHANGELOG](CHANGELOG.md)
