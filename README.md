
# [slocomptech/docker-openvpn]()


## Usage

### docker

``` bash

```

### docker-compose

```

```

## Parameters

|**Parameter**|**Function**|
|:-----------:|:----------:|

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application setup

``` bash
# Setup config directory
sudo docker run -v <Config on Host>:/config --rm -it slocomptech/docker-openvpn bash
$ ovpn_init
# Here will ask for password for CA (needed for signing new certificates) (add nopass if you dont want to set password)
# Enable basic example as config & edit /config/openvpn/server/server_*.conf & /config/openvpn/client_*.conf
$ ovpn_enconf basic1
# Or put your own server config in /config/openvpn/server & client template (without certs) to /config/openvpn/client
# To add client (generate certificates)
$ ovpn_client add <name> [nopass]
# To build .ovpn file
$ ovpn_client ovpn <name> > <file>
# Or from outside of docker (currently not working yet)
sudo docker exec -it <container name> ovpn_client add <name> nopass && ovpn_client ovpn <name> > <file>
# Exit from temporary container
$ exit
# Run container for real
sudo docker run -v <Config on Host>:/config --cap-add NET_ADMIN -p 1104:1194/udp --restart=unless-stopped slocomptech/docker-openvpn
# Setup routing

```

See more in [docs](docs).  

## Contribute

Feel free to contribute new features to this container, but first see [Contribute Guide](CONTRIBUTING.md).

## TODO

Planed features:

- Hooks
- Example configs
- Setup instructions
- Setup scripts
- Setup & run via environment variables
- Config overwrite protection

Wanted features (please help implement):

- LDAP authentication script
- Google authenticator 

## Versions

